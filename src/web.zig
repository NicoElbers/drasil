// TODO: Generally get better at detecting errors in javascript

const global = struct {
    pub var manager: *Manager = undefined;
    pub var gpa: Allocator = undefined;
};

pub fn setup(manager: *Manager, gpa: Allocator) void {
    global.manager = manager;
    global.gpa = gpa;
}

pub const exports = {
    _ = &init;
    _ = &handleEvent;
    _ = &js.allocRet;
};

export fn init() void {
    root.setup() catch |err|
        std.debug.panic("Init error: {s}", .{@errorName(err)});

    root.render() catch |err|
        std.debug.panic("Render error: {s}", .{@errorName(err)});
}

const AttributeTag = std.meta.Tag(Attribute);
export fn handleEvent(
    ref: js.Ref,
    data_type: u32,
    event: Manager.Event,
) void {
    const event_tag = std.enums.fromInt(AttributeTag, data_type) orelse
        std.debug.panic("{d} is not valid data type", .{data_type});

    // TODO: Autogen this based on tools/html_events.zon the interface field
    var data: Data = switch (event_tag) {
        .onclick => .{ .pointer_event = .{ .ref = ref } },
        else => std.debug.panic("{d} is not an event", .{event}),
    };

    event.fire(global.manager, &data) catch |err|
        std.debug.panic("Firing event error: {s}", .{@errorName(err)});

    // TODO: see if we can avoid rerenders in callbacks
    root.render() catch |err|
        std.debug.panic("Render error: {s}", .{@errorName(err)});
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

        pub fn call(
            self: Ref,
            gpa: Allocator,
            func: []const u8,
            args: anytype,
        ) !?Ref {
            assert(self != .invalid);

            var arr: std.ArrayListUnmanaged(u8) = .empty;
            defer arr.deinit(gpa);

            try std.json.stringify(args, .{}, arr.writer(gpa));

            const json_args = arr.items;

            const ref = api.refCall(self, func.ptr, func.len, json_args.ptr, json_args.len);

            if (ref == .invalid) return null;
            return ref;
        }

        pub fn set(self: Ref, gpa: Allocator, field: []const u8, arg: anytype) !void {
            assert(self != .invalid);

            if (@TypeOf(arg) == []const u8 or @TypeOf(arg) == []u8) {
                api.refSetString(
                    self,
                    field.ptr,
                    field.len,
                    arg.ptr,
                    arg.len,
                );
                return;
            }

            var arr: std.ArrayListUnmanaged(u8) = .empty;
            defer arr.deinit(gpa);

            try std.json.stringify(arg, .{}, arr.writer(gpa));

            const json_arg = arr.items;

            api.refSet(
                self,
                field.ptr,
                field.len,
                json_arg.ptr,
                json_arg.len,
            );
        }

        pub fn get(self: Ref, field: []const u8) ![]const u8 {
            assert(self != .invalid);

            return api.refGet(
                self,
                field.ptr,
                field.len,
            ).to() orelse error.JsError;
        }

        pub fn getRef(self: Ref, field: []const u8) ?Ref {
            assert(self != .invalid);

            const ref = api.refGetRef(
                self,
                field.ptr,
                field.len,
            );

            if (ref == .invalid) return null;
            return ref;
        }
    };

    export fn allocRet(size: usize) ?[*]const u8 {
        const slice = global.gpa.alloc(u8, size) catch return null;
        return slice.ptr;
    }

    pub const fetch = struct {
        var counter: u32 = 0;
        var requests: std.ArrayListUnmanaged(Request) = .empty;

        const Id = enum(u32) { _ };

        pub const Request = struct {
            pub const Callback = *const fn (ctx: ?*anyopaque, data: ?[]const u8) anyerror!void;

            id: Id,
            ctx: ?*anyopaque,
            callback: Callback,
        };

        pub fn start(target: []const u8, ctx: ?*anyopaque, callback: Request.Callback) !void {
            const id: Id = @enumFromInt(counter);
            counter += 1;

            try requests.append(global.gpa, .{
                .id = id,
                .ctx = ctx,
                .callback = callback,
            });

            api.startFetch(id, target.ptr, target.len);
        }

        export fn handleFetch(id: Id, data: api.String) void {
            for (requests.items) |req| {
                if (req.id != id) continue;

                req.callback(req.ctx, data.to()) catch |err|
                    std.debug.panic("Fetch handle failed: {s}", .{@errorName(err)});

                return;
            }

            std.debug.panic("Tried to handle fetch with id {d} which does not exist", .{@intFromEnum(id)});
        }
    };

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
        ) Ref;
        extern "env" fn refSet(
            ref: Ref,
            field_ptr: [*]const u8,
            field_len: usize,
            jsonarg_ptr: [*]const u8,
            jsonarg_len: usize,
        ) void;
        extern "env" fn refSetString(
            ref: Ref,
            field_ptr: [*]const u8,
            field_len: usize,
            str_ptr: [*]const u8,
            str_len: usize,
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

        // This string is allocated with `options.manager.gpa` and must be
        // freed by the *caller*
        extern "env" fn startFetch(
            id: fetch.Id,
            target_ptr: [*]const u8,
            target_len: usize,
        ) void;
    };
};

// TODO: autogen a lot of the JS API

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

pub const Element = struct {
    ref: js.Ref,

    pub fn byId(id: []const u8) ?Element {
        const ref = js.api.refById(id.ptr, id.len);
        return switch (ref) {
            .invalid => null,
            else => .{ .ref = ref },
        };
    }

    pub fn unref(self: Element) void {
        self.ref.unref();
    }

    pub fn setInnerHtml(self: Element, gpa: Allocator, content: []const u8) !void {
        try self.ref.set(gpa, "innerHTML", content);
    }
};

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

pub const Options = struct {
    log_buffer_size: usize = 1024,
};

const std = @import("std");
const root = @import("root");
const html_data = @import("html_data.zig");

const assert = std.debug.assert;
const options: Options = if (@hasDecl(root, "drasil_options"))
    root.drasil_options
else
    .{};

const Manager = @import("Manager.zig");
const SubTree = Manager.SubTree;
const Attribute = html_data.Attribute;
const Allocator = std.mem.Allocator;
