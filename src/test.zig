const alloc = std.testing.allocator;

fn casePure(manager: *Manager, idx: SubTree.Index, expected: []const u8) !void {
    const out = try manager.render(idx);
    defer alloc.free(out);
    try std.testing.expectEqualStrings(expected, out);

    // Should be cached, and thus guaranteed to be equal
    const rerender = try manager.render(idx);
    defer alloc.free(rerender);
    try std.testing.expectEqualStrings(expected, rerender);

    manager.subTree(idx).dirty();

    // Should be pure, and thus guaranteed to be equal
    const pure_rerender = try manager.render(idx);
    defer alloc.free(pure_rerender);
    try std.testing.expectEqualStrings(expected, pure_rerender);
}

fn caseImpure(manager: *Manager, idx: SubTree.Index, expected1: []const u8, expected2: []const u8) !void {
    const out = try manager.render(idx);
    defer alloc.free(out);
    try std.testing.expectEqualStrings(expected1, out);

    // Should be cached, and thus guaranteed to be equal
    const rerender = try manager.render(idx);
    defer alloc.free(rerender);
    try std.testing.expectEqualStrings(expected1, rerender);

    manager.subTree(idx).dirty();

    const impure = try manager.render(idx);
    defer alloc.free(impure);
    try std.testing.expectEqualStrings(expected2, impure);

    // Should be cached, and thus guaranteed to be equal
    const impure_rerender = try manager.render(idx);
    defer alloc.free(impure_rerender);
    try std.testing.expectEqualStrings(expected2, impure_rerender);
}

test "sanity" {
    {
        const Case = struct {
            fn generate(
                ctx: *anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                _ = ctx;
                _ = gpa;

                return manager.manage(
                    arena,
                    .h1(&.{}, &.{.raw("Hello world!")}),
                );
            }
        };
        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const case = try manager.register(Case{}, Case.generate);

        try casePure(&manager, case, "<h1>Hello world!</h1>");
    }
    {
        const Case = struct {
            fn generate(
                ctx: *anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                _ = ctx;
                _ = gpa;

                return manager.manage(
                    arena,
                    .div(&.{}, &.{
                        .h1(&.{.{ .id = "id" }}, &.{.raw("Hello world!")}),
                        .p(&.{.{ .class = "class" }}, &.{
                            .br(&.{.{ .clear = "" }}),
                        }),
                    }),
                );
            }
        };
        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const case = try manager.register(Case{}, Case.generate);

        try casePure(
            &manager,
            case,
            "<div><h1 id=\"id\">Hello world!</h1><p class=\"class\"><br clear=\"\"></p></div>",
        );
    }
}

test "state" {
    {
        const Case = struct {
            num: u8,

            fn generate(
                ctx: *anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx));
                _ = gpa;

                return manager.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{d}", .{case.num})),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        {
            const case = try manager.register(Case{ .num = 0 }, Case.generate);

            try casePure(&manager, case, "0");
        }
        {
            const case = try manager.register(Case{ .num = 69 }, Case.generate);

            try casePure(&manager, case, "69");
        }
    }
    {
        const Case = struct {
            count: u8,

            fn generate(
                ctx: *anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx));
                _ = gpa;

                defer case.count += 1;

                return manager.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{d}", .{case.count})),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        {
            const case = try manager.register(Case{ .count = 0 }, Case.generate);

            try caseImpure(&manager, case, "0", "1");
        }
        {
            const case = try manager.register(Case{ .count = 69 }, Case.generate);

            try caseImpure(&manager, case, "69", "70");
        }
    }
}

test "nested" {
    {
        const Nested = struct {
            num: u8,

            pub fn init(num: u8) !@This() {
                return .{ .num = num };
            }

            fn generate(
                ctx: *anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx));
                _ = gpa;

                return manager.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{d}", .{case.num})),
                );
            }
        };

        const Case = struct {
            index: SubTree.Index,

            pub fn init(manager: *Manager, num: u8) !@This() {
                return .{ .index = try manager.register(
                    Nested{ .num = num },
                    Nested.generate,
                ) };
            }

            fn generate(
                ctx: *anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx));
                _ = gpa;

                return manager.manage(
                    arena,
                    .dyn(case.index),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        {
            const case = try manager.register(Case.init(&manager, 10), Case.generate);

            try casePure(&manager, case, "10");
        }
        {
            const case = try manager.register(Case.init(&manager, 30), Case.generate);

            try casePure(&manager, case, "30");
        }
    }
}

test "callbacks" {
    {
        const Case = struct {
            fired: bool = false,
            event: Callback.Index,

            pub fn init(manager: *Manager) !struct { SubTree.Index, Callback.Index } {
                const cb = try manager.registerCallback(callback);

                return .{
                    try manager.register(@This(){ .event = cb }, generate),
                    cb,
                };
            }

            fn callback(st: *SubTree, gpa: Allocator, data: Callback.Data) !void {
                const case: *@This() = @alignCast(@ptrCast(st.ctx));
                st.dirty();
                _ = gpa;
                _ = data;

                case.fired = true;
            }

            fn generate(
                ctx: *anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx));
                _ = gpa;

                return manager.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{}", .{case.fired})),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const case, const cb = try Case.init(&manager);

        {
            const render = try manager.render(case);
            defer alloc.free(render);
            try std.testing.expectEqualStrings("false", render);
        }
        try manager.fireCallback(case, cb, .empty);
        {
            const render = try manager.render(case);
            defer alloc.free(render);
            try std.testing.expectEqualStrings("true", render);
        }
    }
}

const std = @import("std");
const drasil = @import("root.zig");

const assert = std.debug.assert;

const Tree = drasil.Tree;
const Manager = drasil.Manager;
const SubTree = Manager.SubTree;
const Allocator = std.mem.Allocator;
const Callback = Manager.Callback;
