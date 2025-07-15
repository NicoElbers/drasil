const start_marker = "// @GENERATED SECTION START";
const end_marker = "// @GENERATED SECTION END";

pub fn main() !void {
    var dbg_inst = std.heap.DebugAllocator(.{}).init;
    defer _ = dbg_inst.deinit();
    var arena_inst = std.heap.ArenaAllocator.init(dbg_inst.allocator());
    defer arena_inst.deinit();
    const arena = arena_inst.allocator();

    const args = try std.process.argsAlloc(arena);
    defer std.process.argsFree(arena, args);

    assert(args.len == 3); // {self} {tools dir} {web dir}

    var tools_dir = try fs.cwd().openDir(args[1], .{});
    defer tools_dir.close();

    const events = try parseZon(arena, tools_dir);

    var web_dir = try fs.cwd().openDir(args[2], .{});
    defer web_dir.close();

    try writeInitJs(arena, events, web_dir);
}

fn writeInitJs(arena: Allocator, events: []const Event, web_dir: fs.Dir) !void {
    const init_js = try web_dir.openFile("init.js", .{ .mode = .read_write });
    defer init_js.close();

    var freader = init_js.reader(&.{});
    const reader = &freader.interface;

    const pre, const post = blk: {
        const bytes = try reader.allocRemaining(arena, .unlimited);

        const start = std.mem.indexOf(u8, bytes, start_marker) orelse return error.NoMarker;
        const end = std.mem.indexOf(u8, bytes, end_marker) orelse return error.NoMarker;

        const pre = bytes[0..start];
        const post = bytes[end + end_marker.len ..];

        break :blk .{ pre, post };
    };

    var write_buf: [2048]u8 = undefined;
    var fwriter = init_js.writer(&write_buf);

    const writer = &fwriter.interface;
    defer writer.flush() catch {};

    try writer.writeAll(pre);
    try writer.writeAll(start_marker ++ "\n\n// generated - *DO NOT EDIT MANUALLY*\n\n");

    try writeEvents(writer, events);

    try writer.writeAll(end_marker);
    try writer.writeAll(post);

    try writer.flush();
    try init_js.setEndPos(fwriter.pos);
}

fn writeEvents(writer: *Writer, events: []const Event) !void {
    try writer.writeAll(
        \\const events = [
        \\
    );

    for (events, 0..) |e, idx| {
        try writer.print(
            \\  ["{s}", {d}],
            \\
        , .{ e.name, idx });
    }

    try writer.writeAll(
        \\];
        \\
    );
}

fn parseZon(arena: Allocator, tools_dir: fs.Dir) ![]Event {
    const event_zon = try tools_dir.openFile("html_events.zon", .{});
    defer event_zon.close();

    var freader = event_zon.reader(&.{});
    const reader = &freader.interface;

    var aw: Writer.Allocating = .init(arena);
    const writer = &aw.writer;

    // https://github.com/ziglang/zig/pull/24420
    while (true) {
        const read = reader.stream(writer, .unlimited) catch |err| switch (err) {
            error.EndOfStream => break,
            else => |e| return e,
        };
        if (read == 0) break;
    }

    const bytes: [:0]u8 = try aw.toOwnedSliceSentinel(0);

    return std.zon.parse.fromSlice([]Event, arena, bytes, null, .{});
}

const std = @import("std");
const schemas = @import("schemas.zig");
const fs = std.fs;

const assert = std.debug.assert;

const Allocator = std.mem.Allocator;
const Event = schemas.Event;
const Writer = std.Io.Writer;
