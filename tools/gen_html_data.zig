const start_marker = "// @GENERATED SECTION START";
const end_marker = "// @GENERATED SECTION END";

pub fn main() !void {
    var dbg_inst = std.heap.DebugAllocator(.{}).init;
    defer _ = dbg_inst.deinit();
    var arena_inst = std.heap.ArenaAllocator.init(dbg_inst.allocator());
    defer arena_inst.deinit();
    const arena = arena_inst.allocator();

    const args = try std.process.argsAlloc(arena);
    defer std.process.argsFree(arena, args);

    assert(args.len == 4); // {self} {tools dir} {html_data file} {Tree file}

    var tools_dir = try fs.cwd().openDir(args[1], .{});
    defer tools_dir.close();

    const elems, const attrs, const events = try parseZon(arena, tools_dir);

    try writeData(arena, args[2], elems, attrs, events);
    try writeNodeFunctions(arena, args[3], elems);
}

fn writeNodeFunctions(arena: Allocator, html_node_path: []const u8, elements: []const Element) !void {
    const html_node = try std.fs.openFileAbsolute(html_node_path, .{ .mode = .read_write });
    defer html_node.close();

    const pre, const post = blk: {
        const bytes = try html_node.readToEndAlloc(arena, 1 << 25);

        const start = std.mem.indexOf(u8, bytes, start_marker) orelse return error.NoMarker;
        const end = std.mem.indexOf(u8, bytes, end_marker) orelse return error.NoMarker;

        const pre = bytes[0..start];
        const post = bytes[end + end_marker.len ..];

        break :blk .{ pre, post };
    };

    try html_node.seekTo(0); // reset position
    const writer = html_node.writer();

    try writer.writeAll(pre);
    try writer.writeAll(start_marker ++ "\n\n// generated - *DO NOT EDIT MANUALLY*\n\n");

    for (elements) |elem| {
        try documentElement(html_node, elem, 0);

        if (elem.void_element) {
            try writer.print("pub fn {}(attributes: []const Attribute) Tree {{\n", .{std.zig.fmtId(elem.tag)});
            try writer.writeAll(
                \\    return .{ .node = .{ .void = .{
                \\
            );

            try writer.print(
                \\        .tag = .{p},
                \\
            , .{std.zig.fmtId(elem.tag)});

            try writer.writeAll(
                \\        .attributes = attributes,
                \\    } } };
                \\}
                \\
            );
        } else {
            try writer.print(
                "pub fn {}(attributes: []const Attribute, sub_trees: []const Tree) Tree {{\n",
                .{std.zig.fmtId(elem.tag)},
            );
            try writer.writeAll(
                \\    return .{ .node = .{ .element = .{
                \\
            );

            try writer.print(
                \\        .tag = .{p},
                \\
            , .{std.zig.fmtId(elem.tag)});

            try writer.writeAll(
                \\        .attributes = attributes,
                \\        .sub_trees = sub_trees,
                \\    } } };
                \\}
                \\
            );
        }
    }

    try writer.writeAll(end_marker);
    try writer.writeAll(post);

    try html_node.setEndPos(try html_node.getPos());
}

fn writeData(
    arena: Allocator,
    html_data_path: []const u8,
    elems: []const Element,
    attrs: []const Attribute,
    events: []const Event,
) !void {
    const html_data = try std.fs.openFileAbsolute(html_data_path, .{ .mode = .read_write });
    defer html_data.close();

    const pre, const post = blk: {
        const bytes = try html_data.readToEndAlloc(arena, 1 << 25);

        const start = std.mem.indexOf(u8, bytes, start_marker) orelse return error.NoMarker;
        const end = std.mem.indexOf(u8, bytes, end_marker) orelse return error.NoMarker;

        const pre = bytes[0..start];
        const post = bytes[end + end_marker.len ..];

        break :blk .{ pre, post };
    };

    try html_data.seekTo(0); // reset position
    const writer = html_data.writer();

    try writer.writeAll(pre);
    try writer.writeAll(start_marker ++ "\n\n// generated - *DO NOT EDIT MANUALLY*\n\n");

    try writeAttributes(arena, html_data, attrs, events);
    try writeElements(html_data, elems);

    try writer.writeAll("\n" ++ end_marker);
    try writer.writeAll(post);

    try html_data.setEndPos(try html_data.getPos());
}

fn writeAttributes(
    arena: Allocator,
    html_data: File,
    attrs: []const Attribute,
    events: []const Event,
) !void {
    const writer = html_data.writer();

    try writer.writeAll(
        \\pub const Attribute = union(enum) {
        \\
    );

    try writer.writeAll("    // Events\n\n");
    for (events) |event| {
        var buf: [40]u8 = undefined;
        const full_name = try std.fmt.bufPrint(&buf, "on{s}", .{event.name});

        try writer.print(
            \\    /// Event with interface {s}
            \\
        , .{event.interface});

        try writer.print("    {p}: Event,\n\n", .{std.zig.fmtId(full_name)});
    }

    try writer.writeAll("    // Attributes\n\n");
    for (attrs) |attr| {
        if (attr.global) {
            const details = attr.details[0];

            try documentDescription(details.description, html_data, 4);
            try writer.writeAll(
                \\    ///
                \\    /// Is a global attribute
                \\    ///
                \\
            );
            try documentMeta(details.meta, html_data, 4);
        } else {
            for (attr.details) |d| {
                switch (d.elements.len) {
                    0 => try writer.writeAll(
                        \\    /// For unknown elements:
                        \\
                    ),
                    1 => try writer.print(
                        \\    /// For .{p}:
                        \\
                    , .{std.zig.fmtId(d.elements[0])}),
                    else => {
                        try writer.writeAll(
                            \\    /// For:
                            \\
                        );
                        for (d.elements) |e| {
                            try writer.print(
                                \\    ///   .{p}
                                \\
                            , .{std.zig.fmtId(e)});
                        }
                    },
                }

                try writer.writeAll("    ///\n");
                try documentDescription(d.description, html_data, 4);
                try writer.writeAll("    ///\n");

                try documentMeta(d.meta, html_data, 4);
            }
        }

        try writer.print("    {p}", .{std.zig.fmtId(attr.tag)});
        try writer.writeAll(switch (attr.value) {
            .string => ": []const u8,\n\n",
            .items => |vals| blk: {
                assert(vals.len > 0);

                var str: std.ArrayListUnmanaged(u8) = .empty;
                const str_writer = str.writer(arena);

                try str.appendSlice(arena, ": enum {");

                for (vals) |val| {
                    try str_writer.print(" {p},", .{std.zig.fmtId(val)});
                }
                _ = str.pop(); // pop final comma

                try str.appendSlice(arena, " },\n\n");
                break :blk try str.toOwnedSlice(arena);
            },
            .boolean => ": bool,\n\n",
            .void => ",\n\n",
        });
    }

    try html_data.seekBy(-1); // remove last newline
    try writer.writeAll(
        \\};
        \\
    );
}

fn documentElement(out: File, elem: Element, indent: u16) !void {
    const writer = out.writer();

    { // Description
        try documentDescription(elem.description, out, indent);

        try writer.writeByteNTimes(' ', indent);
        try writer.writeAll("///\n");
    }

    if (elem.void_element) {
        try writer.writeByteNTimes(' ', indent);
        try writer.writeAll("/// Is a void element\n");

        try writer.writeByteNTimes(' ', indent);
        try writer.writeAll("///\n");
    }

    { // Interface
        try writer.writeByteNTimes(' ', indent);
        try writer.print(
            "/// Element with interface {s}\n",
            .{elem.interface},
        );

        try writer.writeByteNTimes(' ', indent);
        try writer.writeAll("///\n");
    }

    { // Attributes
        try writer.writeByteNTimes(' ', indent);
        try writer.writeAll("/// Allowed attributes:\n");

        for (elem.attributes) |attr| {
            try writer.writeByteNTimes(' ', indent);
            try writer.writeAll("///   ");

            if (std.mem.eql(u8, "globals", attr)) {
                try writer.writeAll("globals\n");
            } else {
                try writer.print(".{p}\n", .{std.zig.fmtId(attr)});
            }
        }

        try writer.writeByteNTimes(' ', indent);
        try writer.writeAll("///\n");
    }

    try documentMeta(elem.meta, out, indent);
}

fn writeElements(html_data: File, elements: []const Element) !void {
    const writer = html_data.writer();

    try writer.writeAll(
        \\pub const ElementTag = enum {
        \\
    );

    for (elements) |elem| {
        try documentElement(html_data, elem, 4);
        try writer.print("    {p},\n\n", .{std.zig.fmtId(elem.tag)});
    }

    try html_data.seekBy(-1); // remove last newline
    try writer.writeAll(
        \\};
        \\
    );
}

fn documentDescription(desc: []const u8, out: File, indent: u16) !void {
    const writer = out.writer();

    try writer.writeByteNTimes(' ', indent);
    try writer.writeAll("/// ");

    var i: usize = 0;
    while (i < desc.len) {
        const byte = desc[i];
        try writer.writeByte(byte);
        switch (byte) {
            '\n' => {
                try writer.writeByteNTimes(' ', indent);
                try writer.writeAll("/// ");

                i += 1;
                while (desc[i] == ' ') : (i += 1) {}
            },
            else => i += 1,
        }
    }
    try writer.writeByte('\n');
}

fn documentMeta(meta: Meta, out: File, indent: u16) !void {
    const writer = out.writer();

    switch (meta.spec_url.len) {
        0 => {},
        1 => {
            try writer.writeByteNTimes(' ', indent);
            try writer.print("/// Spec: {s}\n", .{meta.spec_url[0]});
        },
        else => {
            try writer.writeByteNTimes(' ', indent);
            try writer.writeAll("/// Spec:\n");
            for (meta.spec_url) |s| {
                try writer.writeByteNTimes(' ', indent);
                try writer.print("///   {s}\n", .{s});
            }
        },
    }

    switch (meta.mdn_url.len) {
        0 => {},
        1 => {
            try writer.writeByteNTimes(' ', indent);
            try writer.print("/// MDN: {s}\n", .{meta.mdn_url[0]});
        },
        else => {
            try writer.writeByteNTimes(' ', indent);
            try writer.writeAll("/// MDN:\n");
            for (meta.mdn_url) |s| {
                try writer.writeByteNTimes(' ', indent);
                try writer.print("///   {s}\n", .{s});
            }
        },
    }

    try writer.writeByteNTimes(' ', indent);
    try writer.print("/// status: {s}\n", .{@tagName(meta.state)});
}

fn parseZon(arena: Allocator, tools_dir: fs.Dir) !struct { []const Element, []const Attribute, []const Event } {
    const elems_file = try tools_dir.openFile("html_elements.zon", .{});
    defer elems_file.close();
    const elems_bytes = try elems_file.readToEndAllocOptions(arena, 1 << 25, null, .of(u8), 0);
    const elems = try std.zon.parse.fromSlice([]const Element, arena, elems_bytes, null, .{});

    const attrs_file = try tools_dir.openFile("html_attributes.zon", .{});
    defer attrs_file.close();
    const attrs_bytes = try attrs_file.readToEndAllocOptions(arena, 1 << 25, null, .of(u8), 0);
    const attrs = try std.zon.parse.fromSlice([]const Attribute, arena, attrs_bytes, null, .{});

    const events_file = try tools_dir.openFile("html_events.zon", .{});
    defer events_file.close();
    const events_bytes = try events_file.readToEndAllocOptions(arena, 1 << 25, null, .of(u8), 0);
    const events = try std.zon.parse.fromSlice([]const Event, arena, events_bytes, null, .{});

    return .{ elems, attrs, events };
}

const std = @import("std");
const fs = std.fs;
const schemas = @import("schemas.zig");

const assert = std.debug.assert;

const Element = schemas.Element;
const Attribute = schemas.Attribute;
const Event = schemas.Event;
const Meta = schemas.Meta;
const Allocator = std.mem.Allocator;
const File = std.fs.File;
