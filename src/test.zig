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
                ctx: ?*anyopaque,
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

        const case = try manager.register(Case.generate);

        try casePure(&manager, case, "<h1>Hello world!</h1>");
    }
    {
        const Case = struct {
            fn generate(
                ctx: ?*anyopaque,
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
                            .br(&.{.{ .autocorrect = "" }}),
                        }),
                    }),
                );
            }
        };
        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const case = try manager.register(Case.generate);

        try casePure(
            &manager,
            case,
            "<div><h1 id=\"id\">Hello world!</h1><p class=\"class\"><br autocorrect=\"\"></p></div>",
        );
    }
}

test "state" {
    {
        const Case = struct {
            num: u8,

            fn generate(
                ctx: ?*anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx.?));
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
            const case = try manager.register(Case.generate);
            try case.setContext(&manager, Case{ .num = 0 });

            try casePure(&manager, case, "0");
        }
        {
            const case = try manager.register(Case.generate);
            try case.setContext(&manager, Case{ .num = 69 });

            try casePure(&manager, case, "69");
        }
    }
    {
        const Case = struct {
            count: u8,

            pub fn init(manager: *Manager, count: u8) !SubTree.Index {
                const sti = try manager.register(generate);

                try sti.setContext(manager, @This(){ .count = count });

                return sti;
            }

            fn generate(
                ctx: ?*anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx.?));
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
            const case = try Case.init(&manager, 0);

            try caseImpure(&manager, case, "0", "1");
        }
        {
            const case = try Case.init(&manager, 69);

            try caseImpure(&manager, case, "69", "70");
        }
    }
}

test "nested" {
    {
        const Nested = struct {
            num: u8,

            pub fn init(manager: *Manager, num: u8) !SubTree.Index {
                const sti = try manager.register(generate);

                try sti.setContext(manager, @This(){ .num = num });

                return sti;
            }

            fn generate(
                ctx: ?*anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx.?));
                _ = gpa;

                return manager.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{d}", .{case.num})),
                );
            }
        };

        const Case = struct {
            index: SubTree.Index,

            pub fn init(manager: *Manager, index: SubTree.Index) !SubTree.Index {
                const sti = try manager.register(generate);

                try sti.setContext(manager, @This(){ .index = index });

                return sti;
            }

            fn generate(
                ctx: ?*anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx.?));
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
            const nested = try Nested.init(&manager, 10);
            const case = try Case.init(&manager, nested);
            try casePure(&manager, case, "10");
        }
        {
            const nested = try Nested.init(&manager, 30);
            const case = try Case.init(&manager, nested);
            try casePure(&manager, case, "30");
        }
    }
}

test "callbacks" {
    {
        const Case = struct {
            fired: bool = false,
            event: Event,

            pub fn init(manager: *Manager, event: Event) !SubTree.Index {
                const sti = try manager.register(generate);

                try sti.setContext(manager, @This(){ .event = event });

                _ = try event.addListener(manager, sti, callback);

                return sti;
            }

            fn callback(st: *SubTree, _: Allocator, _: ?*anyopaque) !void {
                const case: *@This() = @alignCast(@ptrCast(st.ctx.?));
                st.dirty();

                case.fired = true;
            }

            fn generate(
                ctx: ?*anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx.?));
                _ = gpa;

                return manager.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{}", .{case.fired})),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const event = try manager.registerEvent();

        const case = try Case.init(&manager, event);

        {
            const render = try manager.render(case);
            defer alloc.free(render);
            try std.testing.expectEqualStrings("false", render);
        }
        try event.fire(&manager, null);
        {
            const render = try manager.render(case);
            defer alloc.free(render);
            try std.testing.expectEqualStrings("true", render);
        }
    }
}

test "nested callback" {
    { // NOTE: This is god awful code, do not copy this
        const NestedCallback = struct {
            event: Event,

            pub fn init(manager: *Manager, event: Event) !SubTree.Index {
                const sti = try manager.register(generate);

                sti.setContext(manager, @This(){ .event = event });

                return sti;
            }

            fn callback(_: *SubTree, _: Allocator, _: ?*anyopaque) !void {}

            fn generate(
                ctx: ?*anyopaque,
                manager: *Manager,
                _: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const data: *@This() = @alignCast(@ptrCast(ctx.?));

                return manager.manage(
                    arena,
                    .button(&.{.{ .onclick = data.event }}, &.{}),
                );
            }
        };

        const Case = struct {
            index: SubTree.Index,

            fn generate(
                ctx: ?*anyopaque,
                manager: *Manager,
                gpa: Allocator,
                arena: Allocator,
            ) !SubTree.Managed {
                const case: *@This() = @alignCast(@ptrCast(ctx.?));
                _ = gpa;

                return manager.manage(
                    arena,
                    .dyn(case.index),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const event = try manager.registerEvent();
        try std.testing.expectEqual(0, @intFromEnum(event));

        const nested = try manager.register(NestedCallback.generate);
        _ = try nested.setContext(&manager, NestedCallback{ .event = event });
        try std.testing.expectEqual(0, @intFromEnum(nested));

        _ = try event.addListener(&manager, nested, NestedCallback.callback);

        const case = try manager.register(Case.generate);
        try case.setContext(&manager, Case{ .index = nested });
        try std.testing.expectEqual(1, @intFromEnum(case));

        {
            const content = try manager.render(case);
            defer alloc.free(content);

            // @intFromEnum(@as(AttributeTag, .onclick)) == 9
            try std.testing.expectEqualStrings(
                "<button drasil-event=\"[9, 0]\"></button>",
                content,
            );
        }
    }
}

const std = @import("std");
const drasil = @import("root.zig");

const assert = std.debug.assert;

const Tree = drasil.Tree;
const Manager = drasil.Manager;
const Event = Manager.Event;
const SubTree = Manager.SubTree;
const Allocator = std.mem.Allocator;
