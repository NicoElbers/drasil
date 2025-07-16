arena: ArenaAllocator,
generator: Generator,
ctx: ?Allocation,
cache: ?Managed,

const SubTree = @This();

const Allocation = struct {
    alignment: std.mem.Alignment,
    bytes: []u8,

    pub fn alloc(gpa: Allocator, comptime T: type, value: T) !Allocation {
        const alignment: std.mem.Alignment = .of(T);
        const sizeof = @sizeOf(T);

        const raw_bytes = gpa.rawAlloc(sizeof, alignment, @returnAddress()) orelse
            return error.OutOfMemory;

        assert(alignment.check(@intFromPtr(raw_bytes)));
        const bytes = raw_bytes[0..sizeof];

        const allocation: Allocation = .{
            .alignment = alignment,
            .bytes = bytes,
        };

        allocation.get(T).* = value;

        return allocation;
    }

    pub fn free(allocation: Allocation, gpa: Allocator) void {
        gpa.rawFree(allocation.bytes, allocation.alignment, @returnAddress());
    }

    pub fn get(allocation: Allocation, comptime T: type) *T {
        assert(@sizeOf(T) == allocation.bytes.len);
        assert(@alignOf(T) == allocation.alignment.toByteUnits());
        return @alignCast(@ptrCast(allocation.bytes));
    }
};

pub const Generator = *const fn (
    /// `SubTree.GenericIndex` used to access context and read reactive variables
    sti: GenericId,
    /// Reference to the parent `Manager` for rendering subtrees.
    manager: *Manager,
    /// Arena for temporary data, particularly useful for formatted strings.
    /// This arena is reset before every call to generator.
    arena: Allocator,
) anyerror!SubTree.Managed;

/// Wrapper around tree to distinguish managed variants
pub const Managed = struct { tree: Tree };

/// A type erased version of a `SubTree.Index`
pub const GenericId = enum(u32) {
    _,

    pub fn specific(index: GenericId, comptime T: type) Id(T) {
        return @enumFromInt(@intFromEnum(index));
    }

    pub fn tree(index: GenericId, m: *Manager) *SubTree {
        return m.subTree(index);
    }

    pub fn generate(index: GenericId, m: *Manager) !Tree {
        const st = m.subTree(index);
        st.update(m);

        if (st.cache == null)
            st.cache = try st.generator(index, m, st.arena.allocator());

        return st.cache.?.tree;
    }

    pub fn render(index: GenericId, m: *Manager) ![]const u8 {
        return try m.render(index);
    }

    pub fn listen(index: GenericId, m: *Manager, event: Event) !Event.Listener.Id {
        return try event.addListener(m, .{ .sti = index }, dirtyCallback);
    }

    pub fn updateGenerator(self: GenericId, m: *Manager, generator: Generator) void {
        std.log.info("Updating generator", .{});

        const t = self.tree(m);
        t.generator = generator;
        t.dirty();
    }
};

pub fn Id(comptime T: type) type {
    return enum(u32) {
        _,

        const Self = @This();

        pub const Generator = *const fn (
            sti: Self,
            manager: *Manager,
            arena: Allocator,
        ) anyerror!SubTree.Managed;

        pub fn generic(self: Self) GenericId {
            return @enumFromInt(@intFromEnum(self));
        }

        pub fn setContext(self: Self, m: *Manager, value: T) !void {
            try self.tree(m).setContext(m, value);
        }

        pub fn context(self: Self, m: *Manager) ?*T {
            return if (self.tree(m).ctx) |alloc|
                alloc.get(T)
            else
                null;
        }

        pub fn tree(self: Self, m: *Manager) *SubTree {
            return self.generic().tree(m);
        }

        pub fn generate(self: Self, m: *Manager) !Tree {
            return try self.generic().generate(m);
        }

        pub fn render(self: Self, m: *Manager) ![]const u8 {
            return try self.generic().render(m);
        }

        pub fn listen(self: Self, m: *Manager, event: Event) !Event.Listener.Id {
            return try self.generic().listen(m, event);
        }

        pub fn updateGenerator(self: Self, m: *Manager, generator: Self.Generator) void {
            self.generic().updateGenerator(m, @ptrCast(generator));
        }
    };
}

pub fn setContext(self: *SubTree, m: *Manager, context: anytype) !void {
    assert(self.ctx == null);

    self.ctx = try .alloc(m.gpa, @TypeOf(context), context);
}

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

pub fn dirtyCallback(ctx: Event.Context, m: *Manager, _: Event.Data) !void {
    ctx.sti.tree(m).dirty();
}

const std = @import("std");

const assert = std.debug.assert;

const Tree = @import("Tree.zig");
const Manager = @import("Manager.zig");
const Event = @import("event.zig").Event;
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
