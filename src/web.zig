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

        // TODO: make this API take an allocator
        pub fn call(
            self: Ref,
            comptime Ret: type,
            gpa: Allocator,
            func: []const u8,
            args: anytype,
        ) !switch (Ret) {
            void => void,
            else => std.json.Parsed(Ret),
        } {
            var call_buf: [1024]u8 = undefined;
            var fbw = std.io.fixedBufferStream(&call_buf);
            try std.json.stringify(args, .{}, fbw.writer());
            const json_args = fbw.getWritten();

            const js_ret = api.refCall(self, func.ptr, func.len, json_args.ptr, json_args.len);

            const json_ret = js_ret.to() orelse return error.JsError;

            if (Ret == void) return;

            return std.json.parseFromSlice(Ret, gpa, json_ret, .{});
        }

        // TODO: make this API take an allocator
        pub fn set(self: Ref, field: []const u8, arg: anytype) !void {
            var assign_buf: [1024]u8 = undefined;
            var fbw = std.io.fixedBufferStream(&assign_buf);
            try std.json.stringify(arg, .{}, fbw.writer());

            const json_arg = fbw.getWritten();

            api.refSet(
                self,
                field.ptr,
                field.len,
                json_arg.ptr,
                json_arg.len,
            );
        }

        pub fn get(self: Ref, field: []const u8) ![]const u8 {
            return api.refGet(
                self,
                field.ptr,
                field.len,
            ).to() orelse error.JsError;
        }

        pub fn getRef(self: Ref, field: []const u8) ?[]const u8 {
            const ref = api.refGetRef(
                self,
                field.ptr,
                field.len,
            );

            if (ref == .invalid) return null;
            return ref;
        }

        // TODO: make this API take an allocator
        pub fn setInnerHtml(self: Ref, content: []const u8) void {
            self.set("innerHTML", content) catch @panic("fuck me");
        }
    };

    const AttributeTag = std.meta.Tag(Attribute);
    export fn handleCallback(
        ref: Ref,
        data_type: u32,
        event: Manager.Event,
    ) void {
        const event_tag = std.enums.fromInt(AttributeTag, data_type) orelse
            std.debug.panic("{d} is not valid data type", .{data_type});

        var data: Data = switch (event_tag) {
            .onclick => .{ .pointer_event = .{ .ref = ref } },
            else => std.debug.panic("{d} is not an event", .{event}),
        };

        event.fire(options.manager, &data) catch
            @panic("Firing event failed");

        options.render() catch
            std.debug.panic("Error rendering page", .{});
    }

    export fn allocRet(size: usize) ?[*]const u8 {
        const slice = options.manager.gpa.alloc(u8, size) catch return null;
        return slice.ptr;
    }

    const api = struct {
        const String = packed struct(u64) {
            ptr: ?[*]const u8,
            len: u32,

            comptime {
                assert(@sizeOf(usize) == @sizeOf(u32));
            }

            pub fn to(self: String) ?[]const u8 {
                return if (self.ptr) |p|
                    p[0..self.len]
                else
                    null;
            }
        };

        // Logging
        extern "env" fn log(level: LogLevel, ptr: [*]const u8, len: usize) void;

        // Object references
        extern "env" fn refById(ptr: [*]const u8, len: usize) Ref;
        extern "env" fn unref(ref: Ref) void;
        extern "env" fn refCall(
            ref: Ref,
            fnptr: [*]const u8,
            fnlen: usize,
            jsonargsptr: [*]const u8,
            jsonargslen: usize,
        ) String;
        extern "env" fn refSet(
            ref: Ref,
            field_ptr: [*]const u8,
            field_len: usize,
            jsonarg_ptr: [*]const u8,
            jsonarg_len: usize,
        ) void;
        extern "env" fn refGetRef(
            ref: Ref,
            field_ptr: [*]const u8,
            field_len: usize,
        ) Ref;

        // This string is allocated with `options.manager.gpa` and must be
        // freed by the *caller*
        extern "env" fn refGet(
            ref: Ref,
            field_ptr: [*]const u8,
            field_len: usize,
        ) String;
    };
};

pub const PointerEvent = struct {
    ref: js.Ref,

    pub fn pointerType(self: PointerEvent) ![]const u8 {
        return self.ref.get("pointerType");
    }
};

pub const Data = union(enum) {
    empty,
    pointer_event: PointerEvent,
    time_ns: u64,
};

const std = @import("std");
const html_data = @import("html_data.zig");

const assert = std.debug.assert;

const Manager = @import("Manager.zig");
const SubTree = Manager.SubTree;
const Callback = Manager.Callback;
const Attribute = html_data.Attribute;
const Allocator = std.mem.Allocator;
