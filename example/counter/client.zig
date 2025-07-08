//! TODO: Add more explanation to things when we're closer to done

// Initialize logging for wasm
pub const std_options: std.Options = .{
    .logFn = web.logFn,
};

// Initialize the panic handler for wasm
pub const panic = web.panic;

// Setup an allocator to be accessed globally
const global = struct {
    var dbg_inst = std.heap.DebugAllocator(.{}).init;
    pub const gpa = dbg_inst.allocator();
};

// Ensure the correct functions are exported
comptime {
    web.exports;
}

// Our own program state
const State = struct {
    app: SubTree.Index(App),
    manager: Manager,
};
var state: State = undefined;

// The setup function that is called once when the wasm blob is loaded.
// This is referenced by `web` and must thus be public
pub fn setup() !void {
    std.log.info("Hello world!", .{});
    std.log.debug("Hello world!", .{});
    std.log.warn("Hello world!", .{});
    std.log.err("Hello world!", .{});

    var manager: Manager = .init(global.gpa);
    errdefer manager.deinit();

    const app = try App.init(&manager);

    state = .{
        .app = app,
        .manager = manager,
    };

    // This tells `web` which allocator we want it to use for communication
    // with wasm, and tells it where to send events from the browser to
    web.setup(&state.manager, global.gpa);
}

// The render function is called every time the browser sends an event.
// TODO: do we need to call it more often than that?
pub fn render() !void {
    std.log.info("Render", .{});

    // Generating the content, this is the string of HTML
    const content = try state.app.render(&state.manager);
    defer global.gpa.free(content);

    // A reference to the DOM element with id "app"
    const app_ref = Element.byId("app").?;
    defer app_ref.unref();

    // Set the HTML!
    try app_ref.setInnerHtml(global.gpa, content);
}

// A simple app component. It's a little contrived for this demo.
const App = struct {
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

        // Get the pointer to the counter in the button
        // TODO: make this not shit

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
        std.log.info("Generating app", .{});
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
    prng: Random.DefaultPrng,

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
            .prng = Random.DefaultPrng.init(0xdeadbeef),
        });

        return sti;
    }

    fn reset(context: Context, m: *Manager, data: ?*anyopaque) !void {
        _ = data;
        std.log.info("Reset callback called", .{});
        const ctx = context.sti.specific(@This()).context(m).?;

        ctx.counter.getMut(m).* = 0;
    }

    fn click(context: Context, m: *Manager, data: ?*anyopaque) !void {
        _ = data;

        std.log.info("Click callback called", .{});
        const ctx = context.sti.specific(@This()).context(m).?;

        // const ctx: *@This() = @alignCast(@ptrCast(context.sti.contextPtr(m).?));

        ctx.counter.getMut(m).* += 1;
    }

    fn generate(
        sti: SubTree.Index(AlternatingButton),
        m: *Manager,
        arena: Allocator,
    ) !SubTree.Managed {
        std.log.info("Generating button", .{});
        const ctx = sti.context(m).?;

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
                if (ctx.prng.random().boolean())
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
        std.log.info("Generating header", .{});
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
                ctx.counter.getMut(m).* = 0;
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
