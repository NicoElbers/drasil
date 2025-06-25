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

    assert(args.len == 5); // {self} {elements zon} {attributes zon} {html_data file} {Tree file}

    const elements, const attributes = try parseZon(arena, args[1], args[2]);

    try writeData(arena, args[3], elements, attributes);
    try writeNodeFunctions(arena, args[4], elements);
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
        // Docs
        try documentMeta(elem.meta, html_node, 0);
        try writer.writeAll(
            \\///
            \\/// Allowed attributes:
            \\///   Global attributes
            \\
        );
        for (elem.attributes) |attr| {
            try writer.print("///   {s}\n", .{attr});
        }

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

fn writeData(arena: Allocator, html_data_path: []const u8, elements: []const Element, attributes: []const Attribute) !void {
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

    try writeAttributes(arena, html_data, attributes);
    try writeElements(html_data, elements);

    try writer.writeAll("\n" ++ end_marker);
    try writer.writeAll(post);

    try html_data.setEndPos(try html_data.getPos());
}

fn writeAttributes(arena: Allocator, html_data: File, attributes: []const Attribute) !void {
    const writer = html_data.writer();

    try writer.writeAll(
        \\pub const Attribute = union(enum) {
        \\
    );

    for (attributes) |attr| {
        for (attr.meta, 0..) |m, i| {
            if (i != 0)
                try writer.writeAll("    ///\n");

            try writer.print("    /// {s}:\n", .{m.origin});
            try documentMeta(m, html_data, 4);
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

fn writeElements(html_data: File, elements: []const Element) !void {
    const writer = html_data.writer();

    try writer.writeAll(
        \\pub const ElementTag = enum {
        \\
    );

    for (elements) |elem| {
        try documentMeta(elem.meta, html_data, 4);

        if (elem.void_element)
            try writer.writeAll("    /// is a void element\n");

        try writer.writeAll(
            \\    ///
            \\    /// Allowed attributes:
            \\    ///   Global attributes
            \\
        );
        for (elem.attributes) |attr| {
            try writer.print("    ///   {s}\n", .{attr});
        }
        try writer.print("    {p},\n\n", .{std.zig.fmtId(elem.tag)});
    }

    try html_data.seekBy(-1); // remove last newline
    try writer.writeAll(
        \\};
        \\
    );
}

fn documentMeta(meta: Meta, out: File, indent: u16) !void {
    const writer = out.writer();

    if (meta.spec_url.len == 1) {
        try writer.writeByteNTimes(' ', indent);
        try writer.print("/// spec: {s}\n", .{meta.spec_url[0]});
    } else if (meta.spec_url.len > 1) {
        try writer.writeByteNTimes(' ', indent);
        try writer.writeAll("/// spec:\n");
        for (meta.spec_url) |s| {
            try writer.writeByteNTimes(' ', indent);
            try writer.print("///   {s}\n", .{s});
        }
    }

    if (meta.mdn_url.len == 1) {
        try writer.writeByteNTimes(' ', indent);
        try writer.print("/// mdn: {s}\n", .{meta.mdn_url[0]});
    } else if (meta.mdn_url.len > 1) {
        try writer.writeByteNTimes(' ', indent);
        try writer.writeAll("/// mdn:\n");
        for (meta.mdn_url) |s| {
            try writer.writeByteNTimes(' ', indent);
            try writer.print("///   {s}\n", .{s});
        }
    }

    try writer.writeByteNTimes(' ', indent);
    try writer.print("/// status: {s}\n", .{@tagName(meta.state)});
}

fn parseZon(arena: Allocator, element_zon_path: []const u8, attribute_zon_path: []const u8) !struct { []const Element, []const Attribute } {
    const elements_file = try std.fs.openFileAbsolute(element_zon_path, .{});
    defer elements_file.close();
    const elements_bytes = try elements_file.readToEndAllocOptions(arena, 1 << 25, null, .of(u8), 0);
    const elements = try std.zon.parse.fromSlice([]const Element, arena, elements_bytes, null, .{});

    const attributes_file = try std.fs.openFileAbsolute(attribute_zon_path, .{});
    defer attributes_file.close();
    const attributes_bytes = try attributes_file.readToEndAllocOptions(arena, 1 << 25, null, .of(u8), 0);
    const attributes = try std.zon.parse.fromSlice([]const Attribute, arena, attributes_bytes, null, .{});

    return .{ elements, attributes };
}

const std = @import("std");
const schemas = @import("schemas.zig");

const assert = std.debug.assert;

const Element = schemas.Element;
const Attribute = schemas.Attribute;
const Meta = schemas.Meta;
const Allocator = std.mem.Allocator;
const File = std.fs.File;
