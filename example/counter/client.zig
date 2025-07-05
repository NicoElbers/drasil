pub const std_options: std.Options = .{
    .logFn = web.logFn,
};
pub const panic = web.panic;

pub const drasil_options: web.Options = .{
    .init = init,
    .render = render,
    .manager = &global.manager_inst,
};

const global = struct {
    var dbg_inst = std.heap.DebugAllocator(.{}).init;
    pub var gpa = dbg_inst.allocator();

    pub var manager_inst: Manager = undefined;
    pub var manager: *Manager = &manager_inst;

    pub var app: SubTree.Index = undefined;
};

fn init() !void {
    global.manager_inst = .init(global.gpa);

    std.log.info("Hello world!", .{});
    std.log.debug("Hello world!", .{});
    std.log.warn("Hello world!", .{});
    std.log.err("Hello world!", .{});

    global.app = try App.init(global.manager);

    try render();
}

fn render() !void {
    std.log.info("Render", .{});

    const content = try global.manager.render(global.app);
    defer global.gpa.free(content);

    const app_ref = Ref.byId("app").?;
    defer app_ref.unref();

    app_ref.setInnerHtml(content);
}

const App = struct {
    header: SubTree.Index,
    button: SubTree.Index,

    pub fn init(manager: *Manager) !SubTree.Index {
        const click_event = try manager.registerEvent();
        const reset_event = try manager.registerEvent();

        const sti = try manager.register(generate);

        const button = try AlternatingButton.init(manager, click_event, reset_event);
        const counter: *u32 = blk: {
            const ctx: *AlternatingButton = @alignCast(@ptrCast(button.tree(manager).ctx));
            break :blk &ctx.counter;
        };

        const header = try Header.init(manager, counter, click_event, reset_event);

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

        const data: *@This() = @alignCast(@ptrCast(ctx.?));

        std.log.info("Generating app", .{});

        manager.subTree(data.header).dirty();

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

        // Never intend to deregister this listener
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
const Callback = Manager.Callback;
const Event = Manager.Event;
const Allocator = std.mem.Allocator;
const Ref = web.js.Ref;
const Random = std.Random;
