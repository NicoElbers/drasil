pub const App = struct {
    create_1_000: Event,
    create_10_000: Event,
    append_1_000: Event,
    update_10: Event,
    swap: Event,
    clear: Event,

    click: Event,
    highlighted: Reactive(?usize),

    table: Reactive([]Item),

    prng: ?Random.DefaultPrng,

    const Item = struct { text: []u8 };

    pub fn init(m: *Manager) !SubTree.Index(App) {
        const sti = try m.register(App, loadingGenerate);

        const create_1_000 = try m.registerEvent();
        _ = try create_1_000.addListener(m, .{ .sti = sti.generic() }, create_1_000Callback);

        const create_10_000 = try m.registerEvent();
        _ = try create_10_000.addListener(m, .{ .sti = sti.generic() }, create_10_000Callback);

        const append_1_000 = try m.registerEvent();
        _ = try append_1_000.addListener(m, .{ .sti = sti.generic() }, append_1_000Callback);

        const update_10 = try m.registerEvent();
        _ = try update_10.addListener(m, .{ .sti = sti.generic() }, update_10Callback);

        const clear = try m.registerEvent();
        _ = try clear.addListener(m, .{ .sti = sti.generic() }, clearCallback);

        const swap = try m.registerEvent();
        _ = try swap.addListener(m, .{ .sti = sti.generic() }, swapCallback);

        const click = try m.registerEvent();
        _ = try click.addListener(m, .{ .sti = sti.generic() }, clickCallback);

        try sti.setContext(m, .{
            .create_1_000 = create_1_000,
            .create_10_000 = create_10_000,
            .append_1_000 = append_1_000,
            .update_10 = update_10,
            .clear = clear,
            .swap = swap,

            .click = click,
            .highlighted = try .init(m, null),

            .table = try .init(m, &.{}),
            .prng = null,
        });

        try web.js.fetch.start("rand", .{ .sti = sti.generic() }, prngCallback);

        return sti;
    }

    fn prngCallback(ctx: Context, m: *Manager, data: Data) !void {
        const bytes = switch (data) {
            .bytes => |b| b,
            .none => {
                // TODO: Error handling
                unreachable;
            },
            else => unreachable,
        };
        defer m.gpa.free(bytes);

        const sti = ctx.sti.specific(@This());

        const value: u64 = std.mem.readInt(u64, bytes[0..@sizeOf(u64)], .little);
        std.log.info("Recieved prng seed {x}", .{value});

        const context = sti.context(m) orelse @panic("context");
        context.prng = .init(value);

        sti.updateGenerator(m, generate);
    }

    fn clickCallback(context: Context, m: *Manager, data: Data) !void {
        const ctx = context.sti.specific(@This()).context(m).?;

        const event: *web.PointerEvent = @alignCast(@ptrCast(data.ptr));

        const target = event.ref.getRef("target").?;
        defer target.unref();

        const tr = (try target.call(m.gpa, "closest", .{"tr"})).?;
        defer tr.unref();

        const row_str = try tr.get("rowIndex");
        defer m.gpa.free(row_str);

        const row = try std.fmt.parseInt(usize, row_str, 10);

        const highlight = try ctx.highlighted.getMut(m, context.sti);

        if (highlight.* != null and highlight.*.? == row)
            highlight.* = null
        else
            highlight.* = row;
    }

    fn create_1_000Callback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const ctx = context.sti.specific(@This()).context(m).?;

        const table = try ctx.table.getMut(m, context.sti);
        const prng = if (ctx.prng) |*p| p else unreachable;

        for (table.*) |item| {
            m.gpa.free(item.text);
        }

        m.gpa.free(table.*);
        table.* = try m.gpa.alloc(Item, 1_000);

        const encoder = std.base64.standard.Encoder;
        var buf: [30]u8 = undefined;
        for (table.*) |*item| {
            const random = prng.next();
            const out = encoder.encode(&buf, @ptrCast(&random));
            item.text = try std.fmt.allocPrint(m.gpa, "{s}", .{out});
        }
    }

    fn create_10_000Callback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const ctx = context.sti.specific(@This()).context(m).?;

        const table = try ctx.table.getMut(m, context.sti);
        const prng = if (ctx.prng) |*p| p else unreachable;

        for (table.*) |item| {
            m.gpa.free(item.text);
        }

        m.gpa.free(table.*);
        table.* = try m.gpa.alloc(Item, 10_000);

        const encoder = std.base64.standard.Encoder;
        var buf: [30]u8 = undefined;
        for (table.*) |*item| {
            const random = prng.next();
            const out = encoder.encode(&buf, @ptrCast(&random));
            item.text = try std.fmt.allocPrint(m.gpa, "{s}", .{out});
        }
    }

    fn append_1_000Callback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const ctx = context.sti.specific(@This()).context(m).?;

        const table = try ctx.table.getMut(m, context.sti);
        const prng = if (ctx.prng) |*p| p else unreachable;

        const old_len = table.len;
        table.* = try m.gpa.realloc(table.*, old_len + 1_000);

        const encoder = std.base64.standard.Encoder;
        var buf: [30]u8 = undefined;
        for (table.*[old_len..][0..1_000]) |*item| {
            const random = prng.next();
            const out = encoder.encode(&buf, @ptrCast(&random));
            item.text = try std.fmt.allocPrint(m.gpa, "{s}", .{out});
        }
    }

    fn update_10Callback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const ctx = context.sti.specific(@This()).context(m).?;

        const table = try ctx.table.getMut(m, context.sti);

        var i: usize = 0;
        while (i < table.len) : (i += 10) {
            const item = &table.*[i];

            item.text = try m.gpa.realloc(item.text, item.text.len + 2);
            item.text[item.text.len - 2 ..][0..2].* = "!!".*;
        }
    }

    fn swapCallback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const ctx = context.sti.specific(@This()).context(m).?;

        const table = try ctx.table.getMut(m, context.sti);

        if (table.len < 2) return;

        std.mem.swap(Item, &table.*[table.len - 2], &table.*[1]);
    }

    fn clearCallback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const ctx = context.sti.specific(@This()).context(m).?;

        const table = try ctx.table.getMut(m, context.sti);

        for (table.*) |item| {
            m.gpa.free(item.text);
        }

        m.gpa.free(table.*);
        table.* = &.{};
    }

    fn loadingGenerate(sti: SubTree.Index(App), m: *Manager, arena: Allocator) !SubTree.Managed {
        _ = sti;

        std.log.info("Generating loading tables", .{});

        return m.manage(arena, .h1(&.{}, &.{.raw("Loading data")}));
    }

    fn generate(sti: SubTree.Index(App), m: *Manager, arena: Allocator) !SubTree.Managed {
        std.log.info("Generating tables", .{});

        const ctx = sti.context(m).?;

        const table = try ctx.table.get(m, sti);

        const rows = try arena.alloc(Tree, table.len);

        // TODO: Not a fan of how this is done
        const highlight_ptr = try ctx.highlighted.get(m, sti);
        const highlight = highlight_ptr.* orelse std.math.maxInt(usize);

        for (rows, table.*, 1..) |*row, item, i| {
            const class = if (i - 1 == highlight)
                "row highlight"
            else
                "row";

            // TODO: Make this usecase less shit
            const managed = try m.manage(arena, .tr(&.{.{ .class = class }}, &.{
                .td(&.{.{ .onclick = ctx.click }}, &.{.raw(try std.fmt.allocPrint(arena, "{d}", .{i}))}),
                .td(&.{.{ .onclick = ctx.click }}, &.{.raw(item.text)}),
            }));

            row.* = managed.tree;
        }

        return m.manage(
            arena,
            .div(&.{}, &.{
                .h1(&.{}, &.{.raw("js-framework-benchmark for drasil")}),
                .div(&.{.{ .id = "buttons" }}, &.{
                    .button(&.{.{ .onclick = ctx.create_1_000 }}, &.{.raw("Create 1,000 rows")}),
                    .button(&.{.{ .onclick = ctx.create_10_000 }}, &.{.raw("Create 10,000 rows")}),
                    .button(&.{.{ .onclick = ctx.append_1_000 }}, &.{.raw("Append 1,000 rows")}),
                    .button(&.{.{ .onclick = ctx.update_10 }}, &.{.raw("Update every 10th row")}),
                    .button(&.{.{ .onclick = ctx.swap }}, &.{.raw("Swap rows")}),
                    .button(&.{.{ .onclick = ctx.clear }}, &.{.raw("Clear")}),
                }),
                .table(&.{}, rows),
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
const Data = Event.Data;
const Allocator = std.mem.Allocator;
const Random = std.Random;
const Reactive = Manager.Reactive;
