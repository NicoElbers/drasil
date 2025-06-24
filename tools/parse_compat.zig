pub const Compat = struct {
    origin: []const u8,
    mdn: ?[]const u8,
    spec: ?[]const u8,
    experimental: bool,
    standard: bool,
    deprecated: bool,

    pub fn deinit(self: Compat, gpa: Allocator) void {
        gpa.free(self.origin);
        if (self.mdn) |u| gpa.free(u);
        if (self.spec) |u| gpa.free(u);
    }
};

pub const Attribute = struct {
    name: []const u8,
    compat: Compat,

    pub fn deinit(self: Attribute, gpa: Allocator) void {
        gpa.free(self.name);
        self.compat.deinit(gpa);
    }
};

pub const Element = struct {
    tag: []const u8,
    compat: Compat,
    extra_attributes: []const Attribute,

    pub fn deinit(self: Element, gpa: Allocator) void {
        for (self.extra_attributes) |attrib|
            attrib.deinit(gpa);

        gpa.free(self.extra_attributes);

        gpa.free(self.tag);

        self.compat.deinit(gpa);
    }
};

pub fn parseCompatData(origin: []const u8, value: std.json.Value, gpa: Allocator) !Compat {
    // const Schema = struct {
    //     mdn_url: []const u8,
    //     spec_url: []const u8,
    //     status: struct {
    //         experimental: bool,
    //         standard_track: bool,
    //         deprecated: bool,
    //     },
    // };

    const compat_obj = value.object;

    var mdn_url: ?[]const u8 = null;
    var spec_url: ?[]const u8 = null;
    var status: ?struct {
        experimental: bool,
        standard_track: bool,
        deprecated: bool,
    } = null;

    var it = compat_obj.iterator();
    while (it.next()) |entry| {
        if (mem.eql(u8, "mdn_url", entry.key_ptr.*)) {
            assert(mdn_url == null);
            mdn_url = entry.value_ptr.string;
        } else if (mem.eql(u8, "spec_url", entry.key_ptr.*)) {
            assert(spec_url == null);

            switch (entry.value_ptr.*) {
                .string => |s| spec_url = s,
                .array => |a| {
                    std.log.info("Spec is array over string", .{});
                    spec_url = a.items[0].string; // TODO: better solution
                },
                else => @panic("spec url is not a string or array"),
            }

            // spec_url = entry.value_ptr.string;
        } else if (mem.eql(u8, "status", entry.key_ptr.*)) {
            assert(status == null);

            var experimental: ?bool = null;
            var standard_track: ?bool = null;
            var deprecated: ?bool = null;

            const status_obj = entry.value_ptr.object;
            var status_it = status_obj.iterator();
            while (status_it.next()) |status_entry| {
                if (mem.eql(u8, "experimental", status_entry.key_ptr.*)) {
                    assert(experimental == null);
                    experimental = status_entry.value_ptr.bool;
                } else if (mem.eql(u8, "standard_track", status_entry.key_ptr.*)) {
                    assert(standard_track == null);
                    standard_track = status_entry.value_ptr.bool;
                } else if (mem.eql(u8, "deprecated", status_entry.key_ptr.*)) {
                    assert(deprecated == null);
                    deprecated = status_entry.value_ptr.bool;
                } else {
                    std.log.err("{s}", .{status_entry.key_ptr.*});
                    @panic("Status has unknown field");
                }
            }

            status = .{
                .experimental = experimental.?,
                .standard_track = standard_track.?,
                .deprecated = deprecated.?,
            };
        }
    }

    return .{
        .origin = try gpa.dupe(u8, origin),
        .mdn = if (mdn_url) |u| try gpa.dupe(u8, u) else null,
        .spec = if (spec_url) |u| try gpa.dupe(u8, u) else null,
        .deprecated = status.?.deprecated,
        .experimental = status.?.experimental,
        .standard = status.?.standard_track,
    };
}

pub fn parseAttribute(name: []const u8, origin: []const u8, value: std.json.Value, gpa: Allocator) !Attribute {
    var compat: ?Compat = null;

    var it = value.object.iterator();
    while (it.next()) |entry| {
        if (mem.eql(u8, "__compat", entry.key_ptr.*)) {
            assert(compat == null);
            compat = try parseCompatData(origin, entry.value_ptr.*, gpa);
        } else {
            std.log.err("{s}", .{entry.key_ptr.*});
            // @panic("Attribute has more fields than __compat?");
        }
    }

    return .{
        .name = try gpa.dupe(u8, name),
        .compat = compat.?,
    };
}

pub fn parseGlobalAttributes(html_dir: Dir, gpa: Allocator) ![]const Attribute {
    const Schema = struct {
        html: struct {
            global_attributes: std.json.Value,
        },
    };

    const global_file = try html_dir.openFile("global_attributes.json", .{});
    defer global_file.close();

    const bytes = try global_file.readToEndAlloc(gpa, 1 << 25);
    defer gpa.free(bytes);

    const json = try std.json.parseFromSlice(Schema, gpa, bytes, .{});
    defer json.deinit();

    const schema: Schema = json.value;
    const value = schema.html.global_attributes;

    const map = value.object;

    var attribs: std.ArrayListUnmanaged(Attribute) = .empty;

    var it = map.iterator();
    while (it.next()) |entry| {
        try attribs.append(
            gpa,
            try parseAttribute(entry.key_ptr.*, "Global attributes", entry.value_ptr.*, gpa),
        );
    }

    return try attribs.toOwnedSlice(gpa);
}

pub fn parseElements(html_dir: Dir, gpa: Allocator) ![]const Element {
    var elements: std.ArrayListUnmanaged(Element) = .empty;
    errdefer {
        for (elements.items) |el|
            el.deinit(gpa);
        elements.deinit(gpa);
    }

    var elements_dir = try html_dir.openDir("elements", .{ .iterate = true });
    defer elements_dir.close();

    var elements_iter = elements_dir.iterate();
    while (try elements_iter.next()) |entry| {
        switch (entry.kind) {
            .file => {},

            .block_device,
            .character_device,
            .directory,
            .named_pipe,
            .sym_link,
            .unix_domain_socket,
            .whiteout,
            .door,
            .event_port,
            .unknown,
            => continue,
        }

        var file = try elements_dir.openFile(entry.name, .{});
        defer file.close();

        try elements.append(gpa, try parseElement(gpa, file));
    }

    return try elements.toOwnedSlice(gpa);
}

pub fn parseElement(gpa: Allocator, file: File) !Element {
    const Schema = struct {
        html: struct {
            elements: std.json.Value,
        },
    };

    const bytes = try file.readToEndAlloc(gpa, 1 << 25);
    defer gpa.free(bytes);

    const json = try std.json.parseFromSlice(Schema, gpa, bytes, .{});
    defer json.deinit();

    const schema: Schema = json.value;
    const value = schema.html.elements;

    assert(value == .object);
    assert(value.object.count() == 1);

    const elements_object = value.object;

    assert(elements_object.count() == 1);

    const tag: []const u8, const element_object = blk: {
        var it = elements_object.iterator();
        const entry = it.next().?;
        assert(it.next() == null);
        break :blk .{ entry.key_ptr.*, entry.value_ptr.object };
    };

    var compat: ?Compat = null;
    var attribs: std.ArrayListUnmanaged(Attribute) = .empty;

    var it = element_object.iterator();
    while (it.next()) |entry| {
        if (mem.eql(u8, "__compat", entry.key_ptr.*)) {
            assert(compat == null);
            compat = try parseCompatData(tag, entry.value_ptr.*, gpa);
            continue;
        }

        try attribs.append(gpa, try parseAttribute(entry.key_ptr.*, tag, entry.value_ptr.*, gpa));
    }

    return .{
        .tag = try gpa.dupe(u8, tag),
        .compat = compat.?,
        .extra_attributes = try attribs.toOwnedSlice(gpa),
    };
}

pub fn print(value: std.json.Value, depth: u16) void {
    for (0..depth) |_|
        std.debug.print(" ", .{});

    switch (value) {
        .null => std.debug.print("null\n", .{}),
        .bool => |b| std.debug.print("{}\n", .{b}),
        .integer => |i| std.debug.print("{d}\n", .{i}),
        .float => |f| std.debug.print("{d}\n", .{f}),
        .number_string => |s| std.debug.print("num({s})\n", .{s}),
        .string => |s| std.debug.print("\"{s}\"\n", .{s}),
        .array => |arr| {
            std.debug.print("[\n", .{});

            for (arr.items) |v|
                print(v, depth + 1);

            for (0..depth) |_|
                std.debug.print(" ", .{});
            std.debug.print("]\n", .{});
        },
        .object => |obj| {
            var it = obj.iterator();

            std.debug.print("{{\n", .{});
            while (it.next()) |entry| {
                for (0..depth + 1) |_|
                    std.debug.print(" ", .{});

                std.debug.print("{s}:\n", .{entry.key_ptr.*});
                print(entry.value_ptr.*, depth + 2);
            }

            for (0..depth) |_|
                std.debug.print(" ", .{});
            std.debug.print("}}\n", .{});
        },
    }
}

const std = @import("std");
const fs = std.fs;
const mem = std.mem;

const assert = std.debug.assert;

const Dir = fs.Dir;
const File = fs.File;
const Allocator = std.mem.Allocator;
