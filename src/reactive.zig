pub fn Reactive(comptime T: type) type {
    return struct {
        value: T,
        event: Event,

        pub fn init(m: *Manager, value: T) !@This() {
            return .{
                .value = value,
                .event = try m.registerEvent(),
            };
        }

        pub fn deinit(self: @This(), m: *Manager) T {
            self.event.deregister(m);
            return self.value;
        }

        fn genericSti(sti: anytype) SubTree.GenericIndex {
            return if (@TypeOf(sti) == SubTree.GenericIndex)
                sti
            else
                sti.generic();
        }

        pub fn get(self: *const @This(), m: *Manager, sti: anytype) !*const T {
            const stgi = genericSti(sti);
            _ = try self.event.addListener(m, .{ .sti = stgi }, SubTree.dirtyCallback);

            return &self.value;
        }

        pub fn getMut(self: *@This(), m: *Manager, sti: anytype) !*T {

            // We know that the callback won't fail, nor will
            // `Event.fire` ever fail, thus we can catch unreachable
            self.event.fire(m, .none) catch unreachable;

            const stgi = genericSti(sti);

            // Clear all listeners, and add self
            // We need to add self as otherwise we can't tell the next time this
            // value is modified. This is potentially a pointless rerender
            // TODO: Event should have a better primive to do this
            const listeners = self.event.listeners(m).?;

            listeners.clearRetainingCapacity();
            _ = try self.event.addListener(m, .{ .sti = stgi }, SubTree.dirtyCallback);

            return &self.value;
        }

        pub fn set(self: *@This(), m: *Manager, sti: anytype, value: T) !void {
            const val = try self.getMut(m, sti);
            val.* = value;
        }
    };
}

test "Correct rerenders" {
    const CaseGet = struct {
        value: Reactive(void),

        pub var render: u32 = 0;

        pub fn init(m: *Manager, value: Reactive(void)) !SubTree.Index(@This()) {
            const sti = try m.register(@This(), generate);

            try sti.setContext(m, .{ .value = value });

            return sti;
        }

        fn generate(sti: SubTree.Index(@This()), m: *Manager, arena: Allocator) !SubTree.Managed {
            const ctx = sti.context(m).?;

            _ = try ctx.value.get(m, sti);

            @This().render += 1;

            return m.manage(arena, .raw(""));
        }
    };

    const CaseGetMut = struct {
        value: Reactive(void),

        pub var render: u32 = 0;

        pub fn init(m: *Manager, value: Reactive(void)) !SubTree.Index(@This()) {
            const sti = try m.register(@This(), generate);

            try sti.setContext(m, .{ .value = value });

            return sti;
        }

        fn generate(sti: SubTree.Index(@This()), m: *Manager, arena: Allocator) !SubTree.Managed {
            const ctx = sti.context(m).?;

            _ = try ctx.value.getMut(m, sti);

            @This().render += 1;

            return m.manage(arena, .raw(""));
        }
    };

    const alloc = std.testing.allocator;

    var m: Manager = .init(alloc);
    defer m.deinit();

    inline for (.{ CaseGet, CaseGetMut }) |Case| {
        var value: Reactive(void) = try .init(&m, {});

        const case = try Case.init(&m, value);

        const dummy = try Case.init(&m, value);

        // Initial condition
        try std.testing.expectEqual(0, Case.render);

        { // First render
            const content = try m.render(case.generic());
            defer alloc.free(content);

            try std.testing.expectEqual(1, Case.render);
        }
        { // No render after get
            _ = try value.get(&m, dummy);

            const content = try m.render(case.generic());
            defer alloc.free(content);

            try std.testing.expectEqual(1, Case.render);
        }
        { // Render after getMut
            _ = try value.getMut(&m, dummy);

            const content = try m.render(case.generic());
            defer alloc.free(content);

            try std.testing.expectEqual(2, Case.render);
        }
    }
}

const std = @import("std");

const Manager = @import("Manager.zig");
const SubTree = @import("SubTree.zig");
const Event = @import("event.zig").Event;
const Allocator = std.mem.Allocator;
