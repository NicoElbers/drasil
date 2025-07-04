//! Manages multiple `Tree`s, allowing for dynamic content

const Manager = @This();

gpa: Allocator,
context_arena: ArenaAllocator,
sub_trees: ArrayListUnmanaged(SubTree),
events: ArrayListUnmanaged(?ArrayListUnmanaged(Event.Listener)),

pub const Event = enum(u32) {
    _,

    var id_counter: u32 = 0;

    const Listener = struct {
        id: Id,
        sti: SubTree.Index,
        cb: Fn,

        const Id = enum(u32) { _ };
    };

    pub const Fn = *const fn (
        sub_tree: *SubTree,
        gpa: Allocator,
        data: ?*anyopaque,
    ) anyerror!void;

    /// Asserts that the event is registered
    pub fn fire(event: Event, manager: *Manager, data: ?*anyopaque) !void {
        const list = event.listeners(manager).?;

        for (list.items) |listener| {
            const tree = listener.sti.tree(manager);
            try listener.cb(tree, manager.gpa, data);
        }
    }

    /// Asserts that the event is registered
    pub fn addListener(event: Event, manager: *Manager, sti: SubTree.Index, callback: Fn) !Listener.Id {
        const list = event.listeners(manager).?;

        const id: Listener.Id = @enumFromInt(id_counter);
        id_counter += 1;

        try list.append(manager.gpa, .{
            .id = id,
            .cb = callback,
            .sti = sti,
        });

        return id;
    }

    /// Asserts that the event is registered
    /// Asserts that the id is registered
    pub fn removeListener(event: Event, manager: *Manager, id: Listener.Id) void {
        const list = event.listeners(manager).?;

        for (list.items, 0..) |listener, idx| {
            if (listener.id == id) {
                list.swapRemove(idx);
                return;
            }
        }
        unreachable; // id was not registered
    }

    /// Asserts that the event was registered
    pub fn deregister(event: Event, manager: *Manager) void {
        event.listeners(manager).?.* = null;
    }

    fn listeners(event: Event, manager: *Manager) ?*ArrayListUnmanaged(Listener) {
        const idx = @intFromEnum(event);
        if (manager.events.items.len <= idx) return null;
        if (manager.events.items[idx]) |*l| return l;
        return null;
    }
};

pub const SubTree = struct {
    arena: ArenaAllocator,
    generator: Generator,
    ctx: ?*anyopaque,
    cache: ?Managed,

    pub const Generator = *const fn (
        /// User provided data, owned by `HtmlTree`.
        ctx: ?*anyopaque,
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

    pub const Index = enum(u32) {
        _,

        pub fn tree(index: Index, manager: *Manager) *SubTree {
            return manager.subTree(index);
        }

        pub fn setContext(index: Index, manager: *Manager, context: anytype) !void {
            try index.tree(manager).setContext(manager, context);
        }
    };

    pub fn setContext(self: *SubTree, manager: *Manager, context: anytype) !void {
        assert(self.ctx == null);

        const ctx = try manager.context_arena.allocator().create(@TypeOf(context));
        ctx.* = context;

        self.ctx = ctx;
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

pub fn register(self: *Manager, generator: SubTree.Generator) !SubTree.Index {
    const index: SubTree.Index = @enumFromInt(self.sub_trees.items.len);
    try self.sub_trees.append(self.gpa, .{
        .arena = .init(self.gpa),
        .generator = generator,
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
            try manager.generate(idx),
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
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const MultiArrayList = std.MultiArrayList;
const ArrayListUnmanaged = std.ArrayListUnmanaged;
const Attribute = html_data.Attribute;
const ElementTag = html_data.ElementTag;
