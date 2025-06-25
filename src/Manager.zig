//! Manages multiple `Tree`s, allowing for dynamic content

const Manager = @This();

gpa: Allocator,
trees: MultiArrayList(SubTree),
strings: ArrayListUnmanaged(u8),

pub const Generator = *const fn (
    /// User provided data, owned by `HtmlTree`.
    ctx: *anyopaque,
    /// Reference to the parent `HtmlTree` for rendering subtrees.
    tree: *Manager,
    /// Allocator for persistent data, memory fully managed by generator.
    gpa: Allocator,
    /// Arena for temporary data, particularly useful for formatted strings.
    /// This arena is reset before every call to generator.
    arena: Allocator,
) anyerror!Tree;

pub const SubTree = struct {
    arena: ArenaAllocator,
    generator: Generator,
    ctx: *anyopaque,
};

pub const SubTreeIndex = enum(u32) { _ };

pub fn init(gpa: Allocator) Manager {
    return .{
        .gpa = gpa,
        .trees = .{},
        .strings = .empty,
    };
}

pub fn deinit(self: *Manager) void {
    defer self.* = undefined;
}

pub fn register(self: *Manager, context: anytype, generator: Generator) !SubTreeIndex {
    const ctx = try self.gpa.create(@TypeOf(context));
    ctx.* = context;

    const index: SubTreeIndex = @enumFromInt(self.trees.len);

    try self.trees.append(self.gpa, .{
        .arena = .init(self.gpa),
        .generator = generator,
        .ctx = ctx,
    });

    return index;
}

// pub fn render(self: *Manager, idx: SubTreeIndex) ![]const u8 {
//     // var arr: ArrayListUnmanaged(u8) = .empty;
//     // const w = arr.writer(self.gpa);
//
//     const tree = self.trees.get(@intFromEnum(idx));
//     defer _ = tree.arena.reset(.{ .retain_with_limit = 1 << 12 });
//
//     const node = try tree.generator(tree.ctx, self, self.gpa, tree.arena);
// }

const std = @import("std");

const Tree = @import("Tree.zig");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const MultiArrayList = std.MultiArrayList;
const ArrayListUnmanaged = std.ArrayListUnmanaged;

comptime {
    _ = @import("HtmlNode.zig");
}
