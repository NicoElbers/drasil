//! Manages multiple `Tree`s, allowing for dynamic content

const Manager = @This();

gpa: Allocator,
context_arena: ArenaAllocator,
sub_trees: std.ArrayListUnmanaged(SubTree),

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

pub const SubTree = struct {
    arena: ArenaAllocator,
    generator: Generator,
    ctx: *anyopaque,
    cache: ?Managed,

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
    };
}

pub fn deinit(self: *Manager) void {
    defer self.* = undefined;

    for (self.sub_trees.items) |st| {
        st.arena.deinit();
    }
    self.sub_trees.deinit(self.gpa);

    self.context_arena.deinit();
}

pub fn register(self: *Manager, context: anytype, generator: Generator) !SubTree.Index {
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

pub fn manage(self: *Manager, arena: Allocator, tree: Tree) !SubTree.Managed {
    const alloc = arena;
    switch (tree.node) {
        .text => |v| {
            const managed: *Tree = try alloc.create(Tree);
            managed.* = .{ .node = .{ .text = try alloc.dupe(u8, v) } };
            return .{ .tree = .{ .node = .{ .static = managed } } };
        },
        .void => |v| {
            const managed: *Tree = try alloc.create(Tree);
            const attributes: []Attibute = try alloc.alloc(Attibute, v.attributes.len);

            for (v.attributes, attributes) |src, *sink| {
                switch (src) {
                    inline else => |val, t| {
                        const value: @TypeOf(val) = switch (@TypeOf(val)) {
                            []const u8 => try alloc.dupe(u8, val),
                            else => val,
                        };

                        sink.* = @unionInit(Attibute, @tagName(t), value);
                    },
                }
            }

            managed.* = .{ .node = .{ .void = .{
                .tag = v.tag,
                .attributes = attributes,
            } } };

            return .{ .tree = .{ .node = .{ .static = managed } } };
        },
        .element => |v| {
            const managed: *Tree = try alloc.create(Tree);
            const attributes: []Attibute = try alloc.alloc(Attibute, v.attributes.len);

            for (v.attributes, attributes) |src, *sink| {
                switch (src) {
                    inline else => |val, t| {
                        const value: @TypeOf(val) = switch (@TypeOf(val)) {
                            []const u8 => try alloc.dupe(u8, val),
                            else => val,
                        };

                        sink.* = @unionInit(Attibute, @tagName(t), value);
                    },
                }
            }

            const sub_trees = try alloc.alloc(Tree, v.sub_trees.len);
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

    try tree.render(self, arr.writer());

    return try arr.toOwnedSlice();
}

const std = @import("std");
const html_data = @import("html_data.zig");

const Tree = @import("Tree.zig");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const MultiArrayList = std.MultiArrayList;
const ArrayListUnmanaged = std.ArrayListUnmanaged;
const Attibute = html_data.Attribute;
const ElementTag = html_data.ElementTag;
