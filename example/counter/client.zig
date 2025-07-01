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
        return try manager.register(
            App{
                .header = try Header.init(manager),
                .button = try Button.init(manager),
            },
            generate,
        );
    }

    fn generate(
        ctx: *anyopaque,
        manager: *Manager,
        gpa: Allocator,
        arena: Allocator,
    ) !SubTree.Managed {
        _ = gpa;

        const data: *@This() = @alignCast(@ptrCast(ctx));

        std.log.info("Generating app", .{});

        return manager.manage(
            arena,
            .main(&.{}, &.{
                .dyn(data.header),
                .dyn(data.button),
            }),
        );
    }
};

const Button = struct {
    cb: Callback.Index,
    count: u32 = 0,

    pub fn init(manager: *Manager) !SubTree.Index {
        return try manager.register(
            Button{ .cb = try manager.registerCallback(callback) },
            generate,
        );
    }

    fn callback(st: *SubTree, gpa: Allocator, data: Callback.Data) !void {
        _ = gpa;
        _ = data;
        const ctx: *Button = @alignCast(@ptrCast(st.ctx));

        std.log.info("Running callback", .{});

        st.dirty();
        ctx.count += 1;
    }

    fn generate(
        ctx: *anyopaque,
        manager: *Manager,
        gpa: Allocator,
        arena: Allocator,
    ) !SubTree.Managed {
        const data: *Button = @alignCast(@ptrCast(ctx));
        _ = gpa;

        std.log.info("Generating button", .{});

        return manager.manage(arena, .button(
            &.{.{ .onclick = data.cb }},
            &.{
                .raw(try std.fmt.allocPrint(arena, "Clicked {d} times!", .{data.count})),
            },
        ));
    }
};

const Header = struct {
    pub fn init(manager: *Manager) !SubTree.Index {
        return try manager.register(Header{}, generate);
    }

    fn generate(
        ctx: *anyopaque,
        manager: *Manager,
        gpa: Allocator,
        arena: Allocator,
    ) !SubTree.Managed {
        _ = ctx;
        _ = gpa;

        std.log.info("Generating header", .{});

        return manager.manage(
            arena,
            .h1(&.{}, &.{.raw("Hello world!")}),
        );
    }
};

const std = @import("std");
const drasil = @import("drasil");
const web = drasil.web;

const assert = std.debug.assert;

const Manager = drasil.Manager;
const SubTree = Manager.SubTree;
const Callback = Manager.Callback;
const Allocator = std.mem.Allocator;
const Ref = web.js.Ref;
