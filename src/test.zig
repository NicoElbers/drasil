const alloc = std.testing.allocator;

fn casePure(m: *Manager, stgi: SubTree.GenericIndex, expected: []const u8) !void {
    const out = try stgi.render(m);
    defer alloc.free(out);
    try std.testing.expectEqualStrings(expected, out);

    // Should be cached, and thus guaranteed to be equal
    const rerender = try stgi.render(m);
    defer alloc.free(rerender);
    try std.testing.expectEqualStrings(expected, rerender);

    m.subTree(stgi).dirty();

    // Should be pure, and thus guaranteed to be equal
    const pure_rerender = try stgi.render(m);
    defer alloc.free(pure_rerender);
    try std.testing.expectEqualStrings(expected, pure_rerender);
}

fn caseImpure(m: *Manager, stgi: SubTree.GenericIndex, expected1: []const u8, expected2: []const u8) !void {
    const out = try stgi.render(m);
    defer alloc.free(out);
    try std.testing.expectEqualStrings(expected1, out);

    // Should be cached, and thus guaranteed to be equal
    const rerender = try stgi.render(m);
    defer alloc.free(rerender);
    try std.testing.expectEqualStrings(expected1, rerender);

    m.subTree(stgi).dirty();

    const impure = try stgi.render(m);
    defer alloc.free(impure);
    try std.testing.expectEqualStrings(expected2, impure);

    // Should be cached, and thus guaranteed to be equal
    const impure_rerender = try stgi.render(m);
    defer alloc.free(impure_rerender);
    try std.testing.expectEqualStrings(expected2, impure_rerender);
}

test "sanity" {
    {
        const Case = struct {
            fn generate(
                sti: SubTree.Index(@This()),
                m: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                _ = sti;

                return m.manage(
                    arena,
                    .h1(&.{}, &.{.raw("Hello world!")}),
                );
            }
        };
        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const case = try manager.register(Case, Case.generate);

        try casePure(&manager, case.generic(), "<h1>Hello world!</h1>");
    }
    {
        const Case = struct {
            fn generate(
                sti: SubTree.Index(@This()),
                manager: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                _ = sti;

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

        const case = try manager.register(Case, Case.generate);

        try casePure(
            &manager,
            case.generic(),
            "<div><h1 id=\"id\">Hello world!</h1><p class=\"class\"><br autocorrect=\"\"></p></div>",
        );
    }
}

test "state" {
    {
        const Case = struct {
            num: u8,

            fn generate(
                sti: SubTree.Index(@This()),
                m: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                const case = sti.context(m).?;

                return m.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{d}", .{case.num})),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        {
            const case = try manager.register(Case, Case.generate);
            try case.setContext(&manager, Case{ .num = 0 });

            try casePure(&manager, case.generic(), "0");
        }
        {
            const case = try manager.register(Case, Case.generate);
            try case.setContext(&manager, Case{ .num = 69 });

            try casePure(&manager, case.generic(), "69");
        }
    }
    {
        const Case = struct {
            count: u8,

            pub fn init(manager: *Manager, count: u8) !SubTree.Index(@This()) {
                const sti = try manager.register(@This(), generate);

                try sti.setContext(manager, .{ .count = count });

                return sti;
            }

            fn generate(
                sti: SubTree.Index(@This()),
                m: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                const case = sti.context(m).?;

                defer case.count += 1;

                return m.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{d}", .{case.count})),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        {
            const case = try Case.init(&manager, 0);

            try caseImpure(&manager, case.generic(), "0", "1");
        }
        {
            const case = try Case.init(&manager, 69);

            try caseImpure(&manager, case.generic(), "69", "70");
        }
    }
}

test "nested" {
    {
        const Nested = struct {
            num: u8,

            pub fn init(manager: *Manager, num: u8) !SubTree.Index(@This()) {
                const sti = try manager.register(@This(), generate);

                try sti.setContext(manager, @This(){ .num = num });

                return sti;
            }

            fn generate(
                sti: SubTree.Index(@This()),
                m: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                const case = sti.context(m).?;

                return m.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{d}", .{case.num})),
                );
            }
        };

        const Case = struct {
            index: SubTree.Index(Nested),

            pub fn init(manager: *Manager, index: SubTree.Index(Nested)) !SubTree.Index(@This()) {
                const sti = try manager.register(@This(), generate);

                try sti.setContext(manager, .{ .index = index });

                return sti;
            }

            fn generate(
                sti: SubTree.Index(@This()),
                m: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                const case = sti.context(m).?;

                return m.manage(
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
            try casePure(&manager, case.generic(), "10");
        }
        {
            const nested = try Nested.init(&manager, 30);
            const case = try Case.init(&manager, nested);
            try casePure(&manager, case.generic(), "30");
        }
    }
}

test "callbacks" {
    {
        const Case = struct {
            fired: Reactive(bool),
            event: Event,

            pub fn init(m: *Manager, event: Event) !SubTree.Index(@This()) {
                const sti = try m.register(@This(), generate);

                try sti.setContext(m, @This(){
                    .fired = try .init(m, false),
                    .event = event,
                });

                _ = try event.addListener(m, .{ .sti = sti.generic() }, callback);

                return sti;
            }

            fn callback(ctx: Context, m: *Manager, _: ?*anyopaque) !void {
                const case = ctx.sti.specific(@This()).context(m).?;
                case.fired.getMut(m).* = true;
            }

            fn generate(
                sti: SubTree.Index(@This()),
                m: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                const case = sti.context(m).?;

                const fired = try case.fired.get(m, sti.generic());
                return m.manage(
                    arena,
                    .raw(try std.fmt.allocPrint(arena, "{}", .{fired.*})),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const event = try manager.registerEvent();

        const case = try Case.init(&manager, event);

        {
            const render = try case.render(&manager);
            defer alloc.free(render);
            try std.testing.expectEqualStrings("false", render);
        }
        try event.fire(&manager, null);
        {
            const render = try case.render(&manager);
            defer alloc.free(render);
            try std.testing.expectEqualStrings("true", render);
        }
    }
}

test "nested callback" {
    { // NOTE: This is god awful code, do not copy this
        const NestedCallback = struct {
            event: Event,

            pub fn init(manager: *Manager, event: Event) !SubTree.Index(@This()) {
                const sti = try manager.register(@This(), generate);

                sti.setContext(manager, @This(){ .event = event });

                return sti;
            }

            fn callback(_: Context, _: *Manager, _: ?*anyopaque) !void {}

            fn generate(
                sti: SubTree.Index(@This()),
                m: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                const data = sti.context(m).?;

                return m.manage(
                    arena,
                    .button(&.{.{ .onclick = data.event }}, &.{}),
                );
            }
        };

        const Case = struct {
            index: SubTree.Index(NestedCallback),

            fn generate(
                sti: SubTree.Index(@This()),
                m: *Manager,
                arena: Allocator,
            ) !SubTree.Managed {
                const case = sti.context(m).?;

                return m.manage(
                    arena,
                    .dyn(case.index),
                );
            }
        };

        var manager: Manager = .init(alloc);
        defer manager.deinit();

        const event = try manager.registerEvent();
        try std.testing.expectEqual(0, @intFromEnum(event));

        const nested = try manager.register(NestedCallback, NestedCallback.generate);
        _ = try nested.setContext(&manager, NestedCallback{ .event = event });
        try std.testing.expectEqual(0, @intFromEnum(nested));

        _ = try event.addListener(&manager, .none, NestedCallback.callback);

        const case = try manager.register(Case, Case.generate);
        try case.setContext(&manager, Case{ .index = nested });
        try std.testing.expectEqual(1, @intFromEnum(case));

        {
            const content = try case.render(&manager);
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
const Context = Event.Context;
const SubTree = Manager.SubTree;
const Allocator = std.mem.Allocator;
const Reactive = Manager.Reactive;
