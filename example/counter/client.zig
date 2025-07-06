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
    app: SubTree.Index,
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
    const content = try state.manager.render(state.app);
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
    header: SubTree.Index,
    button: SubTree.Index,

    // A function we use to setup all state
    pub fn init(manager: *Manager) !SubTree.Index {
        // Registering an event which can be called either internally or via
        // browser events
        const click_event = try manager.registerEvent();
        const reset_event = try manager.registerEvent();

        // `sti`, stands for `SubTree Index`
        const sti = try manager.register(generate);

        const button = try AlternatingButton.init(manager, click_event, reset_event);

        // Get the pointer to the counter in the button
        // TODO: make this not shit
        const counter: *u32 = blk: {
            const ctx: *AlternatingButton = @alignCast(@ptrCast(button.tree(manager).ctx));
            break :blk &ctx.counter;
        };

        const header = try Header.init(manager, counter, click_event, reset_event);

        // We can give the sti we created earlier some context we can use while
        // generating or while handling an event callback
        try sti.setContext(manager, App{
            .header = header,
            .button = button,
        });

        return sti;
    }

    fn generate(
        ctx: ?*anyopaque,
        manager: *Manager,
        gpa: Allocator,
        arena: Allocator,
    ) !SubTree.Managed {
        _ = gpa;
        std.log.info("Generating app", .{});

        const data: *@This() = @alignCast(@ptrCast(ctx.?));

        // Create the resulting HTML
        return manager.manage(
            arena,
            .main(&.{}, &.{
                .dyn(data.header),
                .dyn(data.button),
            }),
        );
    }
};

const AlternatingButton = struct {
    click_event: Event,
    reset_event: Event,
    counter: u32 = 0,
    prng: Random.DefaultPrng,

    pub fn init(manager: *Manager, click_event: Event, reset_event: Event) !SubTree.Index {
        const sti = try manager.register(generate);

        // Add a callback to both of these events
        // TODO: Do everything you can to remove passing in sti here
        _ = try click_event.addListener(manager, sti, click);
        _ = try reset_event.addListener(manager, sti, reset);

        try sti.setContext(manager, @This(){
            .click_event = click_event,
            .reset_event = reset_event,
            .prng = Random.DefaultPrng.init(0xdeadbeef),
        });

        return sti;
    }

    fn reset(st: *SubTree, gpa: Allocator, data: ?*anyopaque) !void {
        _ = gpa;
        _ = data;
        const ctx: *@This() = @alignCast(@ptrCast(st.ctx));

        std.log.info("Reset callback called", .{});

        st.dirty();
        ctx.counter = 0;
    }

    fn click(st: *SubTree, gpa: Allocator, data: ?*anyopaque) !void {
        _ = gpa;
        _ = data;
        const ctx: *@This() = @alignCast(@ptrCast(st.ctx.?));

        std.log.info("Click callback called", .{});

        st.dirty();
        ctx.counter += 1;
    }

    fn generate(
        ctx: ?*anyopaque,
        manager: *Manager,
        gpa: Allocator,
        arena: Allocator,
    ) !SubTree.Managed {
        const data: *@This() = @alignCast(@ptrCast(ctx.?));
        _ = gpa;

        std.log.info("Generating button", .{});

        const button_a: Tree = .button(&.{.{ .onclick = data.click_event }}, &.{.raw("Click me!")});
        const button_b: Tree = .button(&.{.{ .onclick = data.reset_event }}, &.{.raw("Don't click me >:(")});

        return manager.manage(
            arena,
            .div(
                &.{},
                if (data.prng.random().boolean())
                    &.{ button_a, button_b }
                else
                    &.{ button_b, button_a },
            ),
        );
    }
};

const Header = struct {
    counter: *u32,

    pub fn init(manager: *Manager, counter: *u32, click_event: Event, reset_event: Event) !SubTree.Index {
        const sti = try manager.register(generate);
        try sti.setContext(manager, Header{ .counter = counter });

        _ = try click_event.addListener(manager, sti, callback);
        _ = try reset_event.addListener(manager, sti, callback);

        return sti;
    }

    pub fn callback(st: *SubTree, gpa: Allocator, data: ?*anyopaque) !void {
        _ = gpa;
        _ = data;
        st.dirty();
    }

    fn generate(
        ctx: ?*anyopaque,
        manager: *Manager,
        gpa: Allocator,
        arena: Allocator,
    ) !SubTree.Managed {
        const data: *Header = @alignCast(@ptrCast(ctx.?));
        _ = gpa;

        std.log.info("Generating header", .{});

        const suffix = switch (data.counter.*) {
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
                data.counter.* = 0;
                break :blk " Told you";
            },
        };

        const score_text = try std.fmt.allocPrint(arena, "Score: {d}", .{data.counter.*});

        return manager.manage(
            arena,
            .h1(&.{}, &.{ .raw(score_text), .raw(suffix) }),
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
const Allocator = std.mem.Allocator;
const Element = web.Element;
const Random = std.Random;
