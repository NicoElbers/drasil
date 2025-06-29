//! Manages multiple `Tree`s, allowing for dynamic content

const Manager = @This();

gpa: Allocator,
context_arena: ArenaAllocator,
sub_trees: std.ArrayListUnmanaged(SubTree),
callbacks: std.ArrayListUnmanaged(Callback.Fn),

pub const Callback = struct {
    pub const Fn = *const fn (
        sub_tree: *SubTree,
        gpa: Allocator,
        data: Callback.Data,
    ) anyerror!void;
    pub const Data = union(enum) {
        empty,
        string: []const u8,
        time_ns: u64,
    };
    pub const Index = enum(u32) { _ };
};

pub const SubTree = struct {
    arena: ArenaAllocator,
    generator: Generator,
    ctx: *anyopaque,
    cache: ?Managed,

    pub const Generator = *const fn (
        /// User provided data, owned by `HtmlTree`.
        ctx: *anyopaque,
        /// Reference to the parent `Manager` for rendering subtrees.
        manager: *Manager,
        /// Allocator for persistent data, memory fully managed by generator.
        gpa: Allocator,
        /// Arena for temporary data, particularly useful for formatted strings.
        /// This arena is reset before every call to generator.
        arena: Allocator,
    ) anyerror!SubTree.Managed;

    /// Wrapper around tree to distinguish managed variants
    pub const Managed = struct { tree: Tree };

    pub const Index = enum(u32) { _ };

    pub fn dirty(self: *SubTree) void {
        _ = self.arena.reset(.{ .retain_with_limit = 1 << 20 });
        self.cache = null;
    }

    fn isDirty(self: *const SubTree, manager: *Manager) bool {
        const treeDirty = struct {
            fn treeDirty(tree: *const Tree, m: *Manager) bool {
                switch (tree.node) {
                    .dynamic => |idx| {
                        const st = m.subTree(idx);
                        st.update(m);
                        return st.cache == null;
                    },
                    .static => |ptr| return treeDirty(ptr, m),
                    .element => |v| {
                        for (v.sub_trees) |*st|
                            if (treeDirty(st, m)) return true;
                    },
                    .text => {},
                    .void => {},
                }
                return false;
            }
        }.treeDirty;

        if (self.cache) |*t| return treeDirty(&t.tree, manager);

        return true;
    }

    pub fn update(self: *SubTree, manager: *Manager) void {
        if (self.isDirty(manager)) self.dirty();
    }

    fn generate(self: *SubTree, manager: *Manager) !Tree {
        self.update(manager);
        if (self.cache == null)
            self.cache = try self.generator(
                self.ctx,
                manager,
                manager.gpa,
                self.arena.allocator(),
            );

        return self.cache.?.tree;
    }
};

pub fn init(gpa: Allocator) Manager {
    return .{
        .gpa = gpa,
        .context_arena = .init(gpa),
        .sub_trees = .empty,
        .callbacks = .empty,
    };
}

pub fn deinit(self: *Manager) void {
    defer self.* = undefined;

    for (self.sub_trees.items) |st| {
        st.arena.deinit();
    }
    self.sub_trees.deinit(self.gpa);

    self.callbacks.deinit(self.gpa);

    self.context_arena.deinit();
}

pub fn register(self: *Manager, context: anytype, generator: SubTree.Generator) !SubTree.Index {
    const ctx = try self.context_arena.allocator().create(@TypeOf(context));
    ctx.* = context;

    const index: SubTree.Index = @enumFromInt(self.sub_trees.items.len);
    try self.sub_trees.append(self.gpa, .{
        .arena = .init(self.gpa),
        .generator = generator,
        .ctx = ctx,
        .cache = null,
    });

    return index;
}

pub fn registerCallback(self: *Manager, func: Callback.Fn) !Callback.Index {
    // TODO: some bookkeeping to register a callback to a specific subtree

    const index: Callback.Index = @enumFromInt(self.callbacks.items.len);

    try self.callbacks.append(self.gpa, func);

    return index;
}

pub fn fireCallback(
    self: *Manager,
    subtree_index: SubTree.Index,
    callback_index: Callback.Index,
    data: Callback.Data,
) !void {
    // TODO: validate callback_index
    // TODO: validate subtree_index
    // TODO: validate that subtree indeed registered this callback

    const cb = self.callbacks.items[@intFromEnum(callback_index)];
    const subtree = self.subTree(subtree_index);

    // TODO: Error handling, do not crash please
    try cb(subtree, self.gpa, data);
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
        .static => unreachable, // static == managed, managed == dynamic
    }
}

pub fn subTree(self: *Manager, sub_tree_index: SubTree.Index) *SubTree {
    return &self.sub_trees.items[@intFromEnum(sub_tree_index)];
}

pub fn generate(self: *Manager, sub_tree_index: SubTree.Index) !Tree {
    return self.subTree(sub_tree_index).generate(self);
}

pub fn render(self: *Manager, sub_tree_index: SubTree.Index) ![]const u8 {
    const sub_tree = self.subTree(sub_tree_index);
    const tree = try sub_tree.generate(self);

    var arr: std.ArrayList(u8) = .init(self.gpa);

    try self.innerRender(
        tree,
        sub_tree_index,
        false,
        {},
        arr.writer(),
    );

    return try arr.toOwnedSlice();
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
    sub_tree_index: SubTree.Index,
    comptime pretty: bool,
    indent: if (pretty) u16 else void,
    writer: anytype,
) !void {
    const renderAttributes = struct {
        fn renderAttributes(
            attributes: []const Attribute,
            sti: SubTree.Index,
            w: @TypeOf(writer),
        ) !void {
            for (attributes) |attr| {
                try w.print(" {s}", .{@tagName(attr)});

                switch (attr) {
                    inline else => |v| {
                        switch (@TypeOf(v)) {
                            // TODO: Escape
                            []const u8 => try w.print("=\"{s}\"", .{v}),
                            bool => try w.print("=\"{s}\"", .{v}),
                            void => {},
                            Callback.Index => try w.print(
                                "=\"callback({d}, {d})\"",
                                .{ @intFromEnum(sti), @intFromEnum(v) },
                            ),
                            else => {
                                if (@typeInfo(@TypeOf(v)) != .@"enum")
                                    @compileError("Invalid attribute type");

                                try w.print("=\"{s}\"", .{@tagName(v)});
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
            try renderAttributes(v.attributes, sub_tree_index, writer);
            try writer.writeAll(">");

            if (pretty)
                try writer.writeAll("\n");
        },
        .element => |v| {
            // start
            if (pretty)
                try writer.writeByteNTimes(' ', indent);

            try writer.print("<{s}", .{@tagName(v.tag)});
            try renderAttributes(v.attributes, sub_tree_index, writer);
            try writer.writeAll(">");

            if (pretty)
                try writer.writeAll("\n");

            // subtrees
            const new_indent = if (pretty) indent + 1 else {};

            for (v.sub_trees) |child| {
                try manager.innerRender(child, sub_tree_index, pretty, new_indent, writer);
            }

            // end
            if (pretty)
                try writer.writeByteNTimes(' ', indent);

            try writer.print("</{s}>", .{@tagName(v.tag)});

            if (pretty)
                try writer.writeAll("\n");
        },
        .static => |ptr| try manager.innerRender(ptr.*, sub_tree_index, pretty, indent, writer),
        .dynamic => |idx| try manager.innerRender(
            try manager.generate(idx),
            sub_tree_index,
            pretty,
            indent,
            writer,
        ),
    }
}

const std = @import("std");
const html_data = @import("html_data.zig");

const Tree = @import("Tree.zig");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const MultiArrayList = std.MultiArrayList;
const ArrayListUnmanaged = std.ArrayListUnmanaged;
const Attribute = html_data.Attribute;
const ElementTag = html_data.ElementTag;
