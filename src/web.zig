pub const Options = struct {
    init: *const fn () anyerror!void,
    render: *const fn () anyerror!void,
    manager: *Manager,
    log_buffer_size: usize = 1024,
};
const options: Options = @import("root").drasil_options;

pub const panic = std.debug.FullPanic(struct {
    pub fn panicFn(msg: []const u8, addr: ?usize) noreturn {
        _ = addr; // Wasm can't really do stack traces

        const panic_log = std.log.scoped(.panic);
        panic_log.err("{s}", .{msg});
        @trap();
    }
}.panicFn);

pub fn logFn(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.enum_literal),
    comptime format: []const u8,
    args: anytype,
) void {
    var buf: [options.log_buffer_size]u8 = undefined;

    const prefix = if (scope == .default) "wasm: " else "wasm(" ++ @tagName(scope) ++ "): ";

    const msg = std.fmt.bufPrint(&buf, prefix ++ format, args) catch blk: {
        buf[buf.len - 3 ..][0..3].* = "...".*;
        break :blk &buf;
    };

    js.log(.fromLevel(level), msg);
}

export fn init() void {
    options.init() catch |err|
        std.debug.panic("Init error: {s}", .{@errorName(err)});
}

pub const js = struct {
    pub const LogLevel = enum(u8) {
        info = 0,
        warn = 1,
        err = 2,
        debug = 3,

        pub fn fromLevel(level: std.log.Level) LogLevel {
            return switch (level) {
                .info => .info,
                .warn => .warn,
                .err => .err,
                .debug => .debug,
            };
        }
    };

    pub fn log(level: LogLevel, message: []const u8) void {
        js.api.log(level, message.ptr, message.len);
    }

    pub const Ref = enum(u32) {
        invalid = 0,
        _,

        pub fn unref(self: Ref) void {
            assert(self != .invalid);
            api.unref(self);
        }

        pub fn byId(id: []const u8) ?Ref {
            const ref = api.refById(id.ptr, id.len);
            return switch (ref) {
                .invalid => null,
                else => ref,
            };
        }

        pub fn setInnerHtml(self: Ref, content: []const u8) void {
            api.setInnerHtml(self, content.ptr, content.len);
        }
    };

    export fn handleCallback(subtree: SubTree.Index, index: Callback.Index) void {
        options.manager.fireCallback(subtree, index, .empty) catch
            std.debug.panic("Error firing callback", .{});

        options.render() catch
            std.debug.panic("Error rendering page", .{});
    }

    const api = struct {
        // Logging
        extern "env" fn log(level: LogLevel, ptr: [*]const u8, len: usize) void;

        // Object references
        extern "env" fn refById(ptr: [*]const u8, len: usize) Ref;
        extern "env" fn unref(ref: Ref) void;

        // Using references
        extern "env" fn setInnerHtml(ref: Ref, ptr: [*]const u8, len: usize) void;
    };
};

const std = @import("std");
const Manager = @import("Manager.zig");
const SubTree = Manager.SubTree;
const Callback = Manager.Callback;

const assert = std.debug.assert;
