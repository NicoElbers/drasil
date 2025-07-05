const paths = struct {
    pub var wasm_path: []const u8 = undefined;
    pub var html_path: []const u8 = undefined;
    pub var js_path: []const u8 = undefined;
};

pub fn main() !void {
    var dbg_inst = std.heap.DebugAllocator(.{}).init;
    defer _ = dbg_inst.deinit();
    const gpa = dbg_inst.allocator();

    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    if (args.len != 4) {
        log.info("Usage: {s} wasm_path html_path js_path", .{args[0]});
        std.process.exit(1);
    }
    paths.wasm_path = args[1];
    paths.html_path = args[2];
    paths.js_path = args[3];

    const addr = Address.parseIp("127.0.0.1", 8080) catch unreachable;
    var http_server = try addr.listen(.{ .reuse_address = true });
    defer http_server.deinit();

    log.info("Started server on http://{}", .{addr});

    while (true) {
        const conn = try http_server.accept();
        errdefer conn.stream.close();

        const t = try Thread.spawn(.{}, handler, .{conn});
        t.detach();
    }
}

fn handler(conn: Connection) !void {
    defer conn.stream.close();

    log.info("Opening connection with {}", .{conn.address});

    var read_buf: [4096]u8 = undefined;
    var server: Server = .init(conn, &read_buf);
    while (server.state == .ready) {
        var req = server.receiveHead() catch |err| switch (err) {
            error.HttpConnectionClosing => {
                log.info("Closing connection with {}", .{conn.address});
                return;
            },
            else => {
                log.err("Closing connection to {}: {}", .{ conn.address, err });
                return;
            },
        };

        const eql = std.ascii.eqlIgnoreCase;
        if (eql("/", req.head.target)) {
            try respondFile(&req, "text/html", paths.html_path);
            continue;
        } else if (eql("/js", req.head.target)) {
            try respondFile(&req, "text/javascript", paths.js_path);
            continue;
        } else if (eql("/wasm", req.head.target)) {
            try respondFile(&req, "application/wasm", paths.wasm_path);
            continue;
        } else {
            log.err("Target not found: '{s}'", .{req.head.target});
            try req.respond("", .{ .status = .not_found });
        }
    }
}

fn respondFile(
    req: *Request,
    content_type: []const u8,
    path: []const u8,
) !void {
    log.info("Sending {s}", .{path});
    const file = try fs.cwd().openFile(path, .{});
    defer file.close();

    var send_buf: [4096]u8 = undefined;
    var res = req.respondStreaming(.{
        .send_buffer = &send_buf,
        .respond_options = .{
            .extra_headers = &.{
                .{ .name = "content-type", .value = content_type },
            },
        },
    });

    const writer = res.writer();

    // ew
    var copy_buf: [4096]u8 = undefined;
    while (true) {
        const len = try file.read(&copy_buf);
        if (len == 0)
            break;

        try writer.writeAll(copy_buf[0..len]);
    }

    try res.end();
}

const std = @import("std");
const fs = std.fs;
const mem = std.mem;
const net = std.net;
const http = std.http;

const log = std.log.scoped(.server);

const Address = net.Address;
const Thread = std.Thread;
const Allocator = mem.Allocator;
const Connection = net.Server.Connection;
const Server = http.Server;
const Request = Server.Request;
