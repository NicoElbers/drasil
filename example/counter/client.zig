// A simple app component. It's a little contrived for this demo.
pub const App = struct {
    // We have references to other components or `SubTree`s. Since we don't
    // want to accidentally invalidate a pointer, we pass around indices
    // instead.
    header: SubTree.Index(Header),
    button: SubTree.Index(AlternatingButton),

    // A function we use to setup all state
    pub fn init(manager: *Manager) !SubTree.Index(App) {
        // Registering an event which can be called either internally or via
        // browser events
        const click_event = try manager.registerEvent();
        const reset_event = try manager.registerEvent();

        // `sti`, stands for `SubTree Index`
        const sti = try manager.register(App, generate);

        const button = try AlternatingButton.init(manager, click_event, reset_event);

        const counter = &button.context(manager).?.counter;

        const header = try Header.init(manager, counter);

        // We can give the sti we created earlier some context we can use while
        // generating or while handling an event callback
        try sti.setContext(manager, .{
            .header = header,
            .button = button,
        });

        return sti;
    }

    fn generate(
        sti: SubTree.Index(App),
        m: *Manager,
        arena: Allocator,
    ) !SubTree.Managed {
        std.log.info("Generating counter app", .{});
        const ctx = sti.context(m).?;

        // Create the resulting HTML
        return m.manage(
            arena,
            .main(&.{}, &.{
                .dyn(ctx.header),
                .dyn(ctx.button),
            }),
        );
    }
};

const AlternatingButton = struct {
    click_event: Event,
    reset_event: Event,
    counter: Reactive(u32),
    prng: Reactive(?Random.DefaultPrng),

    pub fn init(m: *Manager, click_event: Event, reset_event: Event) !SubTree.Index(AlternatingButton) {
        const sti = try m.register(AlternatingButton, generate);

        // Add a callback to both of these events
        _ = try click_event.addListener(m, .{ .sti = sti.generic() }, click);
        _ = try reset_event.addListener(m, .{ .sti = sti.generic() }, reset);

        _ = try sti.listen(m, click_event);
        _ = try sti.listen(m, reset_event);

        try sti.setContext(m, .{
            .click_event = click_event,
            .reset_event = reset_event,
            .counter = try .init(m, 0),
            .prng = try .init(m, null),
        });

        const fetch_ctx = try m.gpa.create(FetchState);
        fetch_ctx.* = .{
            .m = m,
            .sti = sti,
        };
        try web.js.fetch.start("rand", fetch_ctx, prngCallback);

        return sti;
    }

    const FetchState = struct {
        m: *Manager,
        sti: SubTree.Index(AlternatingButton),
    };

    fn prngCallback(ctx: ?*anyopaque, data: ?[]const u8) !void {
        const state: *FetchState = @alignCast(@ptrCast(ctx.?));
        defer state.m.gpa.destroy(state);
        defer if (data) |d| state.m.gpa.free(d);

        std.log.info("Recieved data {x}", .{data.?});

        const value: u64 = std.mem.readInt(u64, data.?[0..@sizeOf(u64)], .little);
        std.log.info("Recieved prng seed {x}", .{value});

        const context = state.sti.context(state.m) orelse @panic("context");
        try context.prng.set(state.m, state.sti, .init(value));
    }

    fn reset(context: Context, m: *Manager, data: ?*anyopaque) !void {
        _ = data;
        std.log.info("Reset callback called", .{});
        const ctx = context.sti.specific(@This()).context(m).?;

        try ctx.counter.set(m, context.sti, 0);
    }

    fn click(context: Context, m: *Manager, data: ?*anyopaque) !void {
        _ = data;

        std.log.info("Click callback called", .{});
        const ctx = context.sti.specific(@This()).context(m).?;

        // TODO: Find a way to make this better
        (try ctx.counter.getMut(m, context.sti)).* += 1;
    }

    fn generate(
        sti: SubTree.Index(AlternatingButton),
        m: *Manager,
        arena: Allocator,
    ) !SubTree.Managed {
        std.log.info("Generating counter buttons", .{});
        const ctx = sti.context(m).?;

        // TODO: Find a way to do this that doesn't suck ass
        const prng = blk: {
            const prng = try ctx.prng.getMut(m, sti);

            if (prng.*) |*p| break :blk p;

            return m.manage(arena, .h1(&.{}, &.{.raw("Loading random number")}));
        };

        const button_a: Tree = .button(&.{.{ .onclick = ctx.click_event }}, &.{
            .raw("Click me!"),
        });
        const button_b: Tree = .button(&.{.{ .onclick = ctx.reset_event }}, &.{
            .raw("Don't click me >:("),
        });

        return m.manage(
            arena,
            .div(
                &.{},
                if (prng.random().boolean())
                    &.{ button_a, button_b }
                else
                    &.{ button_b, button_a },
            ),
        );
    }
};

const Header = struct {
    counter: *Reactive(u32),

    pub fn init(manager: *Manager, counter: *Reactive(u32)) !SubTree.Index(Header) {
        const sti = try manager.register(Header, generate);
        try sti.setContext(manager, .{ .counter = counter });

        return sti;
    }

    fn generate(
        sti: SubTree.Index(Header),
        m: *Manager,
        arena: Allocator,
    ) !SubTree.Managed {
        std.log.info("Generating counter header", .{});
        const ctx = sti.context(m).?;

        const counter = try ctx.counter.get(m, sti.generic());

        const suffix = switch (counter.*) {
            0...5 => "",
            6...10 => "!",
            11...15 => "!!",
            16...20 => "!!!",
            21...25 => "!!! WOW",
            26...30 => ".",
            31...35 => "..",
            36...40 => "...",
            41...45 => "... You gotta stop",
            46...49 => "... You won't make it to 50",
            else => blk: {
                (try ctx.counter.getMut(m, sti)).* = 0;
                break :blk " Told you";
            },
        };

        const score_text = try std.fmt.allocPrint(arena, "Score: {d}", .{counter.*});

        return m.manage(
            arena,
            .h1(&.{.{ .contenteditable = "false" }}, &.{
                .raw(score_text), .raw(suffix),
            }),
        );
    }
};

const std = @import("std");
const drasil = @import("drasil");
const web = drasil.web;

const assert = std.debug.assert;

const Manager = drasil.Manager;
const SubTree = Manager.SubTree;
const Tree = drasil.Tree;
const Event = Manager.Event;
const Context = Event.Context;
const Allocator = std.mem.Allocator;
const Element = web.Element;
const Random = std.Random;
const Reactive = Manager.Reactive;
