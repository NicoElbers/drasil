//! Manages multiple `Tree`s, allowing for dynamic content

const Manager = @This();

gpa: Allocator,

sub_trees: AutoHashMapUnmanaged(SubTree.GenericId, SubTree),
id_counter: u32,

events: AutoHashMapUnmanaged(Event, ArrayListUnmanaged(Event.Listener)),
event_counter: u32,

pub fn init(gpa: Allocator) Manager {
    return .{
        .gpa = gpa,
        .sub_trees = .empty,
        .id_counter = 0,

        .events = .empty,
        .event_counter = 0,
    };
}

pub fn deinit(m: *Manager) void {
    defer m.* = undefined;

    {
        var it = m.sub_trees.valueIterator();
        while (it.next()) |st| {
            st.deinit(m);
        }
        m.sub_trees.deinit(m.gpa);
    }

    // Can't figure out a better way for rn
    {
        var it = m.events.iterator();
        while (it.next()) |entry| {
            entry.value_ptr.deinit(m.gpa);
        }
        m.events.deinit(m.gpa);
    }
}

pub fn register(
    m: *Manager,
    comptime T: type,
    generator: SubTree.Id(T).Generator,
) !SubTree.Id(T) {
    comptime {
        const si = @typeInfo(SubTree.GenericId);
        const ti = @typeInfo(SubTree.Id(T));
        assert(si.@"enum".tag_type == ti.@"enum".tag_type);
    }

    const id: SubTree.GenericId = blk: {
        defer m.id_counter += 1;
        break :blk @enumFromInt(m.id_counter);
    };

    const gop = try m.sub_trees.getOrPut(m.gpa, id);
    assert(!gop.found_existing);
    gop.value_ptr.* = .{
        .arena = .init(m.gpa),

        // This is safe because `SubTree.GenericIndex` and `SubTree.Index(T)`
        // have the same layout being u32's
        .generator = @ptrCast(generator),

        .ctx = null,
        .cache = null,
    };

    return id.specific(T);
}

pub fn deregister(m: *Manager, sti: SubTree.GenericId) void {
    const st = sti.tree(m);
    st.deinit(m);

    assert(m.sub_trees.remove(sti));
}

pub fn registerEvent(m: *Manager) !Event {
    const event: Event = @enumFromInt(m.event_counter);
    m.event_counter += 1;

    const gop = try m.events.getOrPut(m.gpa, event);
    assert(!gop.found_existing);
    gop.value_ptr.* = .empty;

    return event;
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

pub fn subTree(self: *Manager, id: SubTree.GenericId) *SubTree {
    return self.sub_trees.getPtr(id).?;
}

// TODO: move all this rendering stuff out to the backend
pub fn render(m: *Manager, sti: SubTree.GenericId) ![]const u8 {
    const tree = try sti.generate(m);

    var aw: Writer.Allocating = .init(m.gpa);
    errdefer aw.deinit();

    const writer = &aw.writer;

    try m.innerRender(
        tree,
        false,
        {},
        writer,
    );

    return try aw.toOwnedSlice();
}

pub fn renderPretty(m: *Manager, sub_tree_index: SubTree.Id) ![]const u8 {
    const sub_tree = m.subTree(sub_tree_index);
    const tree = try sub_tree.generate(m);

    var aw: Writer.Allocating = .init(m.gpa);
    errdefer aw.deinit();

    const writer = &aw.writer;

    try m.innerRender(
        tree,
        sub_tree_index,
        true,
        0,
        writer,
    );

    return try aw.toOwnedSlice();
}

fn innerRender(
    manager: *Manager,
    tree: Tree,
    comptime pretty: bool,
    indent: if (pretty) u16 else void,
    writer: *Writer,
) !void {
    const renderAttributes = struct {
        fn renderAttributes(
            attributes: []const Attribute,
            w: *Writer,
        ) !void {
            for (attributes) |attr| {
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
const AutoHashMapUnmanaged = std.AutoHashMapUnmanaged;
const Attribute = html_data.Attribute;
const ElementTag = html_data.ElementTag;
const Writer = std.io.Writer;
