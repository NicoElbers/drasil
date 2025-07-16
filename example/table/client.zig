pub const App = struct {
    create_1_000: Event,
    create_10_000: Event,
    append_1_000: Event,
    update_10: Event,
    swap: Event,
    clear: Event,

    id_counter: u32,

    highlighted: Reactive(?SubTree.Id(Row)),

    table: Reactive(ArrayListUnmanaged(SubTree.Id(Row))),

    prng: ?Random.DefaultPrng,

    pub fn init(m: *Manager) !SubTree.Id(App) {
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

        try sti.setContext(m, .{
            .create_1_000 = create_1_000,
            .create_10_000 = create_10_000,
            .append_1_000 = append_1_000,
            .update_10 = update_10,
            .clear = clear,
            .swap = swap,
            .highlighted = try .init(m, null),

            .id_counter = 1,

            .table = try .init(m, .empty),
            .prng = null,
        });

        try web.js.fetch.start("rand", .{ .sti = sti.generic() }, prngCallback);

        return sti;
    }

    fn initRow(m: *Manager, sti: SubTree.Id(App), text: []u8) !SubTree.Id(Row) {
        const ctx = sti.context(m).?;

        defer ctx.id_counter += 1;
        const id = ctx.id_counter;

        const row = try Row.init(m, id, text);

        const row_ctx = row.context(m).?;
        _ = try row_ctx.highlight.addListener(m, .{ .sti_and_int = .{ sti.generic(), id } }, highlightCallback);
        _ = try row_ctx.remove.addListener(m, .{ .sti_and_int = .{ sti.generic(), id } }, removeRowCallback);

        return row;
    }

    fn removeRowCallback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const sti, const id = context.sti_and_int;
        const ctx = sti.specific(@This()).context(m).?;

        std.log.info("Pre table", .{});
        const table = try ctx.table.getMut(m, sti);
        std.log.info("Post table", .{});

        for (table.items, 0..) |row, i| {
            std.log.info("Pre row {d}", .{i});
            const row_ctx = row.context(m).?;

            std.log.info("Looking for {d}; found {d}", .{ id, row_ctx.id });

            if (row_ctx.id != id) continue;

            std.log.info("Pre remove", .{});
            _ = table.orderedRemove(i);
            std.log.info("Post remove", .{});

            return;
        }
        unreachable; // Couldn't find row by this Id
    }

    fn highlightCallback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const sti, const int = context.sti_and_int;
        const ctx = sti.specific(@This()).context(m).?;

        const table = try ctx.table.get(m, sti);
        const highlighted = try ctx.highlighted.getMut(m, sti);
        for (table.items) |row| {
            const row_ctx = row.context(m).?;

            if (row_ctx.id != int) continue;

            if (highlighted.*) |h| {
                try h.context(m).?.highlighted.set(m, sti, false);
            }

            try row_ctx.highlighted.set(m, sti, true);
            highlighted.* = row;

            return;
        }
        unreachable; // We didn't find the row by this Id
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

    fn create_1_000Callback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const sti = context.sti.specific(@This());
        const ctx = sti.context(m).?;

        const table = try ctx.table.getMut(m, context.sti);
        const prng = if (ctx.prng) |*p| p else unreachable;

        for (table.items) |row| {
            Row.deinit(row, m);
        }

        table.clearRetainingCapacity();
        try table.ensureTotalCapacity(m.gpa, 1_000);
        ctx.id_counter = 0;

        const encoder = std.base64.standard.Encoder;
        var buf: [30]u8 = undefined;

        table.items.len = 1_000;
        for (table.items) |*item| {
            const random = prng.next();
            const out = encoder.encode(&buf, @ptrCast(&random));

            const text = try std.fmt.allocPrint(m.gpa, "{s}", .{out});

            item.* = try initRow(m, sti, text);
        }
    }

    fn create_10_000Callback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const sti = context.sti.specific(@This());
        const ctx = sti.context(m).?;

        const table = try ctx.table.getMut(m, context.sti);
        const prng = if (ctx.prng) |*p| p else unreachable;

        for (table.items) |row| {
            Row.deinit(row, m);
        }

        table.clearRetainingCapacity();
        try table.ensureTotalCapacity(m.gpa, 10_000);
        ctx.id_counter = 0;

        const encoder = std.base64.standard.Encoder;
        var buf: [30]u8 = undefined;

        table.items.len = 10_000;
        for (table.items) |*item| {
            const random = prng.next();
            const out = encoder.encode(&buf, @ptrCast(&random));

            const text = try std.fmt.allocPrint(m.gpa, "{s}", .{out});

            item.* = try initRow(m, sti, text);
        }
    }

    fn append_1_000Callback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const sti = context.sti.specific(@This());
        const ctx = sti.context(m).?;

        const table = try ctx.table.getMut(m, context.sti);
        const prng = if (ctx.prng) |*p| p else unreachable;

        const old_len = table.items.len;
        try table.ensureUnusedCapacity(m.gpa, 1_000);

        const encoder = std.base64.standard.Encoder;
        var buf: [30]u8 = undefined;

        table.items.len += 1_000;
        for (table.items[old_len..][0..1_000]) |*item| {
            const random = prng.next();
            const out = encoder.encode(&buf, @ptrCast(&random));

            const text = try std.fmt.allocPrint(m.gpa, "{s}", .{out});

            item.* = try initRow(m, sti, text);
        }
    }

    fn update_10Callback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const sti = context.sti.specific(@This());
        const ctx = sti.context(m).?;

        const table = try ctx.table.getMut(m, context.sti);

        var i: usize = 0;
        while (i < table.items.len) : (i += 10) {
            const item = table.items[i].context(m).?;

            const text = try item.text.getMut(m, sti);

            const new_text = try m.gpa.realloc(text.*, text.len + 2);
            new_text[text.len..][0..2].* = "!!".*;

            try item.text.set(m, sti, new_text);
        }
    }

    fn swapCallback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const ctx = context.sti.specific(@This()).context(m).?;

        const table = try ctx.table.getMut(m, context.sti);

        if (table.items.len < 2) return;

        std.mem.swap(SubTree.Id(Row), &table.items[table.items.len - 2], &table.items[1]);
    }

    fn clearCallback(context: Context, m: *Manager, data: Data) !void {
        _ = data;
        const ctx = context.sti.specific(@This()).context(m).?;

        ctx.id_counter = 1;

        const table = try ctx.table.getMut(m, context.sti);

        for (table.items) |row| {
            Row.deinit(row, m);
        }

        table.clearAndFree(m.gpa);
    }

    fn loadingGenerate(sti: SubTree.Id(App), m: *Manager, arena: Allocator) !SubTree.Managed {
        _ = sti;

        std.log.info("Generating loading tables", .{});

        return m.manage(arena, .h1(&.{}, &.{.raw("Loading data")}));
    }

    fn generate(sti: SubTree.Id(App), m: *Manager, arena: Allocator) !SubTree.Managed {
        std.log.info("Generating tables", .{});

        const ctx = sti.context(m).?;

        const table = try ctx.table.get(m, sti);

        const rows = try arena.alloc(Tree, table.items.len);
        for (rows, table.items) |*row, id| row.* = .dyn(id);

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

pub const Row = struct {
    highlight: Event,
    remove: Event,
    highlighted: Reactive(bool),
    id: u32,
    text: Reactive([]u8),

    // Assumes text is allocated using `m.gpa` and takes ownership of this information
    pub fn init(m: *Manager, id: u32, text: []u8) !SubTree.Id(Row) {
        const sti = try m.register(@This(), generate);

        const highlight = try m.registerEvent();
        const remove = try m.registerEvent();

        try sti.setContext(m, .{
            .highlight = highlight,
            .remove = remove,
            .highlighted = try .init(m, false),
            .id = id,
            .text = try .init(m, text),
        });

        return sti;
    }

    pub fn deinit(sti: SubTree.Id(@This()), m: *Manager) void {
        const ctx = sti.context(m).?;

        ctx.highlight.deregister(m);
        ctx.remove.deregister(m);
        _ = ctx.highlighted.deinit(m);

        const text = ctx.text.deinit(m);
        m.gpa.free(text);

        m.deregister(sti.generic());
    }

    fn generate(sti: SubTree.Id(@This()), m: *Manager, arena: Allocator) !SubTree.Managed {
        const ctx = sti.context(m).?;

        const highlighted = (try ctx.highlighted.get(m, sti)).*;

        const class = if (highlighted) "row highlight" else "row";

        return m.manage(arena, .tr(&.{ .{ .class = class }, .{ .onclick = ctx.highlight } }, &.{
            .td(&.{}, &.{
                .raw(try std.fmt.allocPrint(arena, "{d}", .{ctx.id})),
            }),
            .td(&.{}, &.{
                .raw((try ctx.text.get(m, sti)).*),
            }),
            .td(&.{}, &.{
                .button(&.{.{ .onclick = ctx.remove }}, &.{
                    .raw("X"),
                }),
            }),
        }));
    }
};

const std = @import("std");
const drasil = @import("drasil");
const web = drasil.web;

const assert = std.debug.assert;

const Manager = drasil.Manager;
const SubTree = drasil.SubTree;
const Reactive = drasil.Reactive;
const Tree = drasil.Tree;
const Event = drasil.Event;
const Context = Event.Context;
const Data = Event.Data;
const Allocator = std.mem.Allocator;
const Random = std.Random;
const ArrayListUnmanaged = std.ArrayListUnmanaged;
