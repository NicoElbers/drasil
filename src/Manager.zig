//! Manages multiple `Tree`s, allowing for dynamic content

const Manager = @This();

gpa: Allocator,

// TODO: Get this thing removed
context_arena: ArenaAllocator,

sub_trees: ArrayListUnmanaged(SubTree),
events: ArrayListUnmanaged(?ArrayListUnmanaged(Event.Listener)),

pub fn init(gpa: Allocator) Manager {
    return .{
        .gpa = gpa,
        .context_arena = .init(gpa),
        .sub_trees = .empty,
        .events = .empty,
    };
}

pub fn deinit(self: *Manager) void {
    defer self.* = undefined;

    for (self.sub_trees.items) |st| {
        st.arena.deinit();
    }
    self.sub_trees.deinit(self.gpa);

    // Can't figure out a better way for rn
    for (0..self.events.items.len) |idx| {
        if (self.events.items[idx] == null) continue;
        self.events.items[idx].?.deinit(self.gpa);
    }
    self.events.deinit(self.gpa);

    self.context_arena.deinit();
}

pub fn register(
    self: *Manager,
    comptime T: type,
    generator: SubTree.Index(T).Generator,
) !SubTree.Index(T) {
    comptime {
        const si = @typeInfo(SubTree.GenericIndex);
        const ti = @typeInfo(SubTree.Index(T));
        assert(si.@"enum".tag_type == ti.@"enum".tag_type);
    }

    const index: SubTree.Index(T) = @enumFromInt(self.sub_trees.items.len);
    try self.sub_trees.append(self.gpa, .{
        .arena = .init(self.gpa),

        // This is safe because `SubTree.GenericIndex` and `SubTree.Index(T)`
        // have the same layout being u32's
        .generator = @ptrCast(generator),

        .ctx = null,
        .cache = null,
    });

    return index;
}

pub fn registerEvent(self: *Manager) !Event {
    for (self.events.items, 0..) |event, idx| {
        if (event != null) continue;

        self.events.items[idx] = .empty;
        return @enumFromInt(idx);
    } else {
        const idx = self.events.items.len;
        try self.events.append(self.gpa, .empty);
        return @enumFromInt(idx);
    }
}

pub fn manage(self: *Manager, arena: Allocator, tree: Tree) !SubTree.Managed {
    const dupeAttributes = struct {
        fn dupeAttributes(a: Allocator, attributes: []const Attribute) ![]const Attribute {
            const res: []Attribute = try a.alloc(Attribute, attributes.len);

            for (attributes, res) |src, *sink| {
                switch (src) {
                    inline else => |val, t| {
                        const value: @TypeOf(val) = switch (@TypeOf(val)) {
                            []const u8 => try a.dupe(u8, val),
                            else => val,
                        };

                        sink.* = @unionInit(Attribute, @tagName(t), value);
                    },
                }
            }

            return res;
        }
    }.dupeAttributes;

    switch (tree.node) {
        .text => |v| {
            const managed: *Tree = try arena.create(Tree);
            managed.* = .{ .node = .{ .text = try arena.dupe(u8, v) } };
            return .{ .tree = .{ .node = .{ .static = managed } } };
        },
        .void => |v| {
            const managed: *Tree = try arena.create(Tree);
            const attributes = try dupeAttributes(arena, v.attributes);

            managed.* = .{ .node = .{ .void = .{
                .tag = v.tag,
                .attributes = attributes,
            } } };

            return .{ .tree = .{ .node = .{ .static = managed } } };
        },
        .element => |v| {
            const managed: *Tree = try arena.create(Tree);
            const attributes = try dupeAttributes(arena, v.attributes);

            const sub_trees = try arena.alloc(Tree, v.sub_trees.len);
            for (v.sub_trees, sub_trees) |src, *sink| {
                sink.* = (try self.manage(arena, src)).tree;
            }

            managed.* = .{ .node = .{ .element = .{
                .tag = v.tag,
                .attributes = attributes,
                .sub_trees = sub_trees,
            } } };
            return .{ .tree = .{ .node = .{ .static = managed } } };
        },
        .dynamic => return .{ .tree = tree },
        .static => return .{ .tree = tree },
    }
}

pub fn subTree(self: *Manager, sub_tree_index: SubTree.GenericIndex) *SubTree {
    return &self.sub_trees.items[@intFromEnum(sub_tree_index)];
}

// TODO: move all this rendering stuff out to the backend
pub fn render(m: *Manager, sti: SubTree.GenericIndex) ![]const u8 {
    const tree = try sti.generate(m);

    var arr: std.ArrayListUnmanaged(u8) = .empty;
    errdefer arr.deinit(m.gpa);

    try m.innerRender(
        tree,
        false,
        {},
        arr.writer(m.gpa),
    );

    return try arr.toOwnedSlice(m.gpa);
}

pub fn renderPretty(self: *Manager, sub_tree_index: SubTree.Index) ![]const u8 {
    const sub_tree = self.subTree(sub_tree_index);
    const tree = try sub_tree.generate(self);

    var arr: std.ArrayList(u8) = .init(self.gpa);

    try self.innerRender(
        tree,
        sub_tree_index,
        true,
        0,
        arr.writer(),
    );

    try tree.render(self, arr.writer());

    return try arr.toOwnedSlice();
}

fn innerRender(
    manager: *Manager,
    tree: Tree,
    comptime pretty: bool,
    indent: if (pretty) u16 else void,
    writer: anytype,
) !void {
    const renderAttributes = struct {
        fn renderAttributes(
            attributes: []const Attribute,
            w: @TypeOf(writer),
        ) !void {
            for (attributes) |attr| {
                // try w.print(" {s}", .{@tagName(attr)});

                switch (attr) {
                    inline else => |v| {
                        switch (@TypeOf(v)) {
                            // TODO: Escape
                            []const u8 => try w.print(" {s}=\"{s}\"", .{ @tagName(attr), v }),
                            bool => try w.print(" {s}=\"{s}\"", .{ @tagName(attr), v }),
                            void => {},
                            Event => try w.print(
                                " drasil-event=\"[{d}, {d}]\"",
                                .{ @intFromEnum(attr), @intFromEnum(v) },
                            ),
                            else => {
                                if (@typeInfo(@TypeOf(v)) != .@"enum")
                                    @compileError("Invalid attribute type");

                                try w.print(" {s}=\"{s}\"", .{ @tagName(attr), @tagName(v) });
                            },
                        }
                    },
                }
            }
        }
    }.renderAttributes;

    switch (tree.node) {
        .text => |v| {
            if (pretty)
                try writer.writeByteNTimes(' ', indent);

            try writer.writeAll(v);

            if (pretty)
                try writer.writeAll("\n");
        },
        .void => |v| {
            if (pretty)
                try writer.writeByteNTimes(' ', indent);

            try writer.print("<{s}", .{@tagName(v.tag)});
            try renderAttributes(v.attributes, writer);
            try writer.writeAll(">");

            if (pretty)
                try writer.writeAll("\n");
        },
        .element => |v| {
            // start
            if (pretty)
                try writer.writeByteNTimes(' ', indent);

            try writer.print("<{s}", .{@tagName(v.tag)});
            try renderAttributes(v.attributes, writer);
            try writer.writeAll(">");

            if (pretty)
                try writer.writeAll("\n");

            // subtrees
            const new_indent = if (pretty) indent + 1 else {};

            for (v.sub_trees) |child| {
                try manager.innerRender(child, pretty, new_indent, writer);
            }

            // end
            if (pretty)
                try writer.writeByteNTimes(' ', indent);

            try writer.print("</{s}>", .{@tagName(v.tag)});

            if (pretty)
                try writer.writeAll("\n");
        },
        .static => |ptr| try manager.innerRender(ptr.*, pretty, indent, writer),
        .dynamic => |idx| try manager.innerRender(
            try idx.generate(manager),
            pretty,
            indent,
            writer,
        ),
    }
}

const std = @import("std");
const builtin = @import("builtin");
const html_data = @import("html_data.zig");

const assert = std.debug.assert;

const Tree = @import("Tree.zig");
const Event = @import("event.zig").Event;
const SubTree = @import("SubTree.zig");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const MultiArrayList = std.MultiArrayList;
const ArrayListUnmanaged = std.ArrayListUnmanaged;
const Attribute = html_data.Attribute;
const ElementTag = html_data.ElementTag;
