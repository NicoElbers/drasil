pub const std_options: std.Options = .{
    .logFn = web.logFn,
};

pub const panic = web.panic;

const global = struct {
    var dbg_inst = std.heap.DebugAllocator(.{}).init;
    pub const gpa = dbg_inst.allocator();
};

comptime {
    web.exports;
}

const Screen = enum {
    none,
    counter,
    table,
};

const State = struct {
    manager: Manager,

    screen: Screen,

    browser_app: SubTree.Id(App),
    counter_app: SubTree.Id(counter.App),
    table_app: SubTree.Id(table.App),
};
var state: State = undefined;

pub fn setup() !void {
    // FIXME: I really dislike this style of initialization. Perhaps let the manager live in web.
    state.manager = .init(global.gpa);
    web.setup(&state.manager, global.gpa);

    state.browser_app = try App.init(&state.manager);
    state.counter_app = try counter.App.init(&state.manager);
    state.table_app = try table.App.init(&state.manager);

    state.screen = .none;

    std.log.info("After web setup", .{});

    try setupStatic();
}

fn setupStatic() !void {
    {
        const browser_ref = Element.byId("browser").?;
        defer browser_ref.unref();

        const content = try state.browser_app.render(&state.manager);
        defer global.gpa.free(content);

        try browser_ref.setInnerHtml(global.gpa, content);
    }
}

pub fn render() !void {
    std.log.info("Rendering screen {s}", .{@tagName(state.screen)});

    // A reference to the DOM element with id "app"
    const app_ref = Element.byId("app").?;
    defer app_ref.unref();

    const index = switch (state.screen) {
        .none => {
            try app_ref.setInnerHtml(global.gpa, "");
            return;
        },
        .counter => state.counter_app.generic(),
        .table => state.table_app.generic(),
    };

    // Generating the content, this is the string of HTML
    const content = try index.render(&state.manager);
    defer global.gpa.free(content);

    // Set the HTML!
    try app_ref.setInnerHtml(global.gpa, content);
}

const App = struct {
    examples: []const Example,

    const Example = struct { click_event: Event, name: []const u8 };

    // A function we use to setup all state
    pub fn init(m: *Manager) !SubTree.Id(App) {
        const values = std.enums.values(Screen);

        const examples = try m.gpa.alloc(Example, values.len);

        for (examples, values) |*example, value| {
            const event = try m.registerEvent();

            _ = try event.addListener(m, .{ .int = @intFromEnum(value) }, callback);

            example.name = @tagName(value);
            example.click_event = event;
        }

        // `sti`, stands for `SubTree Id`
        const sti = try m.register(App, generate);

        try sti.setContext(m, .{ .examples = examples });

        return sti;
    }

    const main_css =
        \\display: flex;
        \\gap: 1rem;
        \\flex-wrap: wrap;
        \\justify-content: center;
        \\padding: 1rem;
    ;

    const button_css =
        \\padding: 0.5rem 1rem;
        \\font-size: 1rem;
        \\background-color: #4a90e2;
        \\color: white;
        \\border: none;
        \\border-radius: 4px;
        \\cursor: pointer;
    ;

    fn callback(ctx: Context, m: *Manager, data: Data) !void {
        _ = data;
        _ = m;

        state.screen = @enumFromInt(ctx.int);
    }

    fn generate(
        sti: SubTree.Id(App),
        m: *Manager,
        arena: Allocator,
    ) !SubTree.Managed {
        std.log.info("Generating example browser", .{});
        const ctx = sti.context(m).?;

        const buttons = try arena.alloc(Tree, ctx.examples.len);

        for (buttons, ctx.examples) |*button, example| {
            // TODO: Make this integrate better
            const managed = try m.manage(arena, .button(&.{
                .{ .style = button_css },
                .{ .onclick = example.click_event },
            }, &.{
                .raw(example.name),
            }));

            button.* = managed.tree;
        }

        // Create the resulting HTML
        return m.manage(
            arena,
            .main(&.{.{ .style = main_css }}, buttons),
        );
    }
};

const std = @import("std");
const drasil = @import("drasil");
const web = drasil.web;

const counter = @import("counter/client.zig");
const table = @import("table/client.zig");

const assert = std.debug.assert;

const Manager = drasil.Manager;
const SubTree = drasil.SubTree;
const Tree = drasil.Tree;
const Event = drasil.Event;
const Context = Event.Context;
const Data = Event.Data;
const Allocator = std.mem.Allocator;
const Element = web.Element;
