pub fn main() !void {
    var dbg_inst = std.heap.DebugAllocator(.{}).init;
    defer _ = dbg_inst.deinit();
    var arena_inst = std.heap.ArenaAllocator.init(dbg_inst.allocator());
    defer arena_inst.deinit();
    const gpa = arena_inst.allocator();

    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    assert(args.len == 4); // {self} {html_dir} {elements zon} {attributes zon}

    const parsed_elements, const parsed_attributes = try parsedElements(gpa, args[1]);

    const found_elements = try foundElements(gpa, args[2]);
    const found_attributes = try foundAttributes(gpa, args[3]);

    const final_elements = try combineElements(gpa, found_elements, parsed_elements);
    const final_attributes = try combineAttributes(gpa, found_attributes, parsed_attributes);

    {
        const elements_file = try fs.openFileAbsolute(args[2], .{ .mode = .write_only });
        defer elements_file.close();

        try std.zon.stringify.serialize(final_elements, .{}, elements_file.writer());

        try elements_file.setEndPos(try elements_file.getPos());
    }

    {
        const attributes_file = try fs.openFileAbsolute(args[3], .{ .mode = .write_only });
        defer attributes_file.close();

        try std.zon.stringify.serialize(final_attributes, .{}, attributes_file.writer());

        try attributes_file.setEndPos(try attributes_file.getPos());
    }
}

fn combineElements(gpa: Allocator, old: []Element, new: []Element) ![]Element {
    var arr: std.ArrayListUnmanaged(Element) = .{ .capacity = old.len, .items = old };

    loop: for (new) |elem| {
        check: for (arr.items) |*e| {
            if (!std.mem.eql(u8, elem.tag, e.tag))
                continue :check;

            // Always update attributes and meta, stay up to date with browser compat
            e.attributes = elem.attributes;
            e.meta = elem.meta;

            // We found a matching element, so no need to add it to the list
            continue :loop;
        }

        // New element
        try arr.append(gpa, elem);
    }

    return arr.toOwnedSlice(gpa);
}

fn combineAttributes(gpa: Allocator, old: []Attribute, new: []Attribute) ![]const Attribute {
    var arr: std.ArrayListUnmanaged(Attribute) = .{ .capacity = old.len, .items = old };

    loop: for (new) |attr| {
        check: for (arr.items) |*a| {
            if (!std.mem.eql(u8, attr.tag, a.tag))
                continue :check;

            // Always update meta, stay up to date with browser compat
            a.meta = attr.meta;

            // We found a matching element, so no need to add it to the list
            continue :loop;
        }

        // New element
        try arr.append(gpa, attr);
    }

    return arr.toOwnedSlice(gpa);
}

fn parsedElements(gpa: Allocator, html_dir_path: []const u8) !struct { []Element, []Attribute } {
    var html_dir = try fs.openDirAbsolute(html_dir_path, .{ .iterate = true });
    defer html_dir.close();

    const parsed_elements = try parse_compat.parseElements(html_dir, gpa);

    const parsed_global_attributes = try parse_compat.parseGlobalAttributes(html_dir, gpa);

    var attr_set: std.StringArrayHashMapUnmanaged(Attribute) = .empty;

    for (parsed_global_attributes) |ga| {
        const spec_url: []const []const u8 = if (ga.compat.spec) |s| blk: {
            const slice = try gpa.alloc([]const u8, 1);
            slice[0] = try gpa.dupe(u8, s);
            break :blk slice;
        } else &.{};

        const mdn_url: []const []const u8 = if (ga.compat.mdn) |s| blk: {
            const slice = try gpa.alloc([]const u8, 1);
            slice[0] = try gpa.dupe(u8, s);
            break :blk slice;
        } else &.{};

        const meta = try gpa.alloc(Meta, 1);
        meta[0] = .{
            .origin = try gpa.dupe(u8, "Global attribute"),
            .spec_url = spec_url,
            .mdn_url = mdn_url,
            .state = if (ga.compat.deprecated and !ga.compat.experimental)
                .deprecated
            else if (ga.compat.experimental and !ga.compat.deprecated)
                .experimental
            else if (ga.compat.standard and !ga.compat.deprecated and !ga.compat.experimental)
                .standard
            else
                @panic("Weird compat combo"),
        };

        try attr_set.put(gpa, ga.name, .{
            .tag = try gpa.dupe(u8, ga.name),
            .global = true,
            .value = .string,
            .meta = meta,
        });
    }

    var elements: std.ArrayListUnmanaged(Element) = try .initCapacity(gpa, parsed_elements.len);
    errdefer {
        for (elements.items) |elem|
            std.zon.parse.free(gpa, elem);
        elements.deinit(gpa);
    }

    for (parsed_elements) |parsed| {
        const spec_url: []const []const u8 = if (parsed.compat.spec) |s| blk: {
            const slice = try gpa.alloc([]const u8, 1);
            slice[0] = try gpa.dupe(u8, s);
            break :blk slice;
        } else &.{};

        const mdn_url: []const []const u8 = if (parsed.compat.mdn) |s| blk: {
            const slice = try gpa.alloc([]const u8, 1);
            slice[0] = try gpa.dupe(u8, s);
            break :blk slice;
        } else &.{};

        const attributes = blk: {
            const slice = try gpa.alloc([]const u8, parsed.extra_attributes.len);
            for (slice, parsed.extra_attributes) |*attr_res, attr| {
                attr_res.* = try gpa.dupe(u8, attr.name);
            }
            break :blk slice;
        };

        try elements.append(gpa, .{
            .tag = try gpa.dupe(u8, parsed.tag),
            .value = .string,
            .void_element = false,
            .attributes = attributes,
            .meta = .{
                .origin = try gpa.dupe(u8, parsed.tag),
                .spec_url = spec_url,
                .mdn_url = mdn_url,
                .state = if (parsed.compat.deprecated and !parsed.compat.experimental)
                    .deprecated
                else if (parsed.compat.experimental and !parsed.compat.deprecated)
                    .experimental
                else if (parsed.compat.standard and !parsed.compat.deprecated and !parsed.compat.experimental)
                    .standard
                else
                    .unknown,
            },
        });

        for (parsed.extra_attributes) |attr| {
            const attr_spec_url: []const []const u8 = if (attr.compat.spec) |s| blk: {
                const slice = try gpa.alloc([]const u8, 1);
                slice[0] = try gpa.dupe(u8, s);
                break :blk slice;
            } else &.{};

            const attr_mdn_url: []const []const u8 = if (attr.compat.mdn) |s| blk: {
                const slice = try gpa.alloc([]const u8, 1);
                slice[0] = try gpa.dupe(u8, s);
                break :blk slice;
            } else &.{};

            if (attr_set.get(attr.name)) |existing| {
                const new_meta = try gpa.alloc(Meta, existing.meta.len + 1);
                defer gpa.free(existing.meta);

                @memcpy(new_meta[0 .. new_meta.len - 1], existing.meta);

                new_meta[new_meta.len - 1] = .{
                    .origin = try gpa.dupe(u8, parsed.tag),
                    .spec_url = attr_spec_url,
                    .mdn_url = attr_mdn_url,
                    .state = if (attr.compat.deprecated and !attr.compat.experimental)
                        .deprecated
                    else if (attr.compat.experimental and !attr.compat.deprecated)
                        .experimental
                    else if (attr.compat.standard and !attr.compat.deprecated and !attr.compat.experimental)
                        .standard
                    else
                        .unknown,
                };

                try attr_set.put(gpa, attr.name, .{
                    .tag = existing.tag,
                    .global = false,
                    .value = .string,
                    .meta = new_meta,
                });
            } else {
                const meta = try gpa.alloc(Meta, 1);

                meta[0] = .{
                    .origin = try gpa.dupe(u8, parsed.tag),
                    .spec_url = attr_spec_url,
                    .mdn_url = attr_mdn_url,
                    .state = if (attr.compat.deprecated and !attr.compat.experimental)
                        .deprecated
                    else if (attr.compat.experimental and !attr.compat.deprecated)
                        .experimental
                    else if (attr.compat.standard and !attr.compat.deprecated and !attr.compat.experimental)
                        .standard
                    else
                        .unknown,
                };

                try attr_set.put(gpa, attr.name, .{
                    .tag = try gpa.dupe(u8, attr.name),
                    .global = false,
                    .value = .string,
                    .meta = meta,
                });
            }
        }
    }

    var attributes: std.ArrayListUnmanaged(Attribute) = try .initCapacity(gpa, attr_set.count());

    var it = attr_set.iterator();
    while (it.next()) |entry| {
        try attributes.append(gpa, entry.value_ptr.*);
    }

    return .{ try elements.toOwnedSlice(gpa), try attributes.toOwnedSlice(gpa) };
}

fn foundElements(gpa: Allocator, elements_zon_path: []const u8) ![]Element {
    const elements_zon_file = try fs.openFileAbsolute(elements_zon_path, .{});

    const bytes = try elements_zon_file.readToEndAllocOptions(gpa, 1 << 25, null, .of(u8), 0);
    defer gpa.free(bytes);

    return try std.zon.parse.fromSlice([]Element, gpa, bytes, null, .{});
}

fn foundAttributes(gpa: Allocator, attributes_zon_path: []const u8) ![]Attribute {
    const attributes_zon_file = try fs.openFileAbsolute(attributes_zon_path, .{});

    const bytes = try attributes_zon_file.readToEndAllocOptions(gpa, 1 << 25, null, .of(u8), 0);
    defer gpa.free(bytes);

    return try std.zon.parse.fromSlice([]Attribute, gpa, bytes, null, .{});
}

const std = @import("std");
const fs = std.fs;
const schemas = @import("schemas.zig");
const parse_compat = @import("parse_compat.zig");

const assert = std.debug.assert;

const Allocator = std.mem.Allocator;

const Element = schemas.Element;
const Attribute = schemas.Attribute;
const Meta = schemas.Meta;
