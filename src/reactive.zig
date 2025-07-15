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

const std = @import("std");

const Manager = @import("Manager.zig");
const SubTree = @import("SubTree.zig");
const Event = @import("event.zig").Event;
