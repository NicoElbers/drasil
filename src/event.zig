pub const Event = enum(u32) {
    _,

    var id_counter: u32 = 0;

    pub const Listener = struct {
        id: Id,
        ctx: Context,
        cb: Fn,

        pub const Id = enum(u32) { _ };
    };

    pub const Context = union(enum) {
        none,
        sti: SubTree.GenericId,
        ptr: *anyopaque,
        int: u32,
    };

    pub const Data = union(enum) {
        none,
        ptr: *anyopaque,
        bytes: []const u8,
    };

    pub const Fn = *const fn (
        ctx: Context,
        manager: *Manager,
        data: Data,
    ) anyerror!void;

    /// Asserts that the event is registered
    pub fn fire(event: Event, manager: *Manager, data: Data) !void {
        const list = event.listeners(manager).?;

        for (list.items) |listener| {
            try listener.cb(listener.ctx, manager, data);
        }
    }

    /// Asserts that the event is registered
    pub fn addListener(
        event: Event,
        manager: *Manager,
        ctx: Context,
        callback: Fn,
    ) !Listener.Id {
        const list = event.listeners(manager).?;

        const id: Listener.Id = @enumFromInt(id_counter);
        id_counter += 1;

        try list.append(manager.gpa, .{
            .id = id,
            .ctx = ctx,
            .cb = callback,
        });

        return id;
    }

    /// Asserts that the event is registered
    /// Asserts that the id is registered
    pub fn removeListener(event: Event, manager: *Manager, id: Listener.Id) void {
        const list = event.listeners(manager).?;

        for (list.items, 0..) |listener, idx| {
            if (listener.id == id) {
                _ = list.swapRemove(idx);
                return;
            }
        }
        unreachable; // id was not registered
    }

    /// Asserts that the event was registered
    pub fn deregister(event: Event, manager: *Manager) void {
        const arr = event.listeners(manager).?;
        arr.deinit(manager.gpa);

        manager.events.items[@intFromEnum(event)] = null;
    }

    pub fn listeners(event: Event, manager: *Manager) ?*ArrayListUnmanaged(Listener) {
        const idx = @intFromEnum(event);
        if (manager.events.items.len <= idx) return null;
        if (manager.events.items[idx]) |*l| return l;
        return null;
    }
};

test "basic usage" {
    const case = struct {
        pub var called1: u32 = 0;

        pub fn callback1(_: Event.Context, _: *Manager, _: Event.Data) !void {
            called1 += 1;
        }

        pub var called2: u32 = 0;

        pub fn callback2(_: Event.Context, _: *Manager, _: Event.Data) !void {
            called2 += 1;
        }
    };
    const alloc = std.testing.allocator;

    var m: Manager = .init(alloc);
    defer m.deinit();

    const event = try m.registerEvent();

    // Initial conditions
    try std.testing.expectEqual(0, case.called1);
    try std.testing.expectEqual(0, case.called2);

    // Fire with no listeners
    try event.fire(&m, .none);
    try std.testing.expectEqual(0, case.called1);
    try std.testing.expectEqual(0, case.called2);

    // Add listener 1
    const listener1 = try event.addListener(&m, .none, case.callback1);
    try std.testing.expectEqual(0, case.called1);
    try std.testing.expectEqual(0, case.called2);

    // Fire with listener 1
    try event.fire(&m, .none);
    try std.testing.expectEqual(1, case.called1);
    try std.testing.expectEqual(0, case.called2);

    // Add listener 2
    const listener2 = try event.addListener(&m, .none, case.callback2);
    try std.testing.expectEqual(1, case.called1);
    try std.testing.expectEqual(0, case.called2);

    // Fire with listener 1 and 2
    try event.fire(&m, .none);
    try std.testing.expectEqual(2, case.called1);
    try std.testing.expectEqual(1, case.called2);

    // Remove listener 1
    event.removeListener(&m, listener1);
    try std.testing.expectEqual(2, case.called1);
    try std.testing.expectEqual(1, case.called2);

    // Fire listener 2
    try event.fire(&m, .none);
    try std.testing.expectEqual(2, case.called1);
    try std.testing.expectEqual(2, case.called2);

    // Remove listener 2
    event.removeListener(&m, listener2);
    try std.testing.expectEqual(2, case.called1);
    try std.testing.expectEqual(2, case.called2);
}

const std = @import("std");

const Manager = @import("Manager.zig");
const SubTree = @import("SubTree.zig");
const ArrayListUnmanaged = std.ArrayListUnmanaged;
