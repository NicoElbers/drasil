pub fn main() !void {
    var dbg_inst = std.heap.DebugAllocator(.{}).init;
    defer _ = dbg_inst.deinit();
    var arena_inst = std.heap.ArenaAllocator.init(dbg_inst.allocator());
    defer arena_inst.deinit();
    const arena = arena_inst.allocator();

    const args = try std.process.argsAlloc(arena);
    assert(args.len == 3); // {self} {html dir} {tools dir}

    var tools_dir = try fs.cwd().openDir(args[2], .{});
    defer tools_dir.close();

    const compat_elems, const compat_attrs = try compatData(arena, args[1]);

    const json_events = try jsonEvents(arena, tools_dir);
    const json_attrs = try jsonAttrs(arena, tools_dir);
    const json_elems = try jsonElems(arena, tools_dir);

    const found_elems = try foundElems(arena, tools_dir);
    const found_attrs = try foundAttrs(arena, tools_dir);
    const found_events = try foundEvents(arena, tools_dir);

    const final_elems = try combineElems(arena, found_elems, json_elems, compat_elems);
    const final_attrs = try combineAttrs(arena, found_attrs, json_attrs, compat_attrs);
    const final_events = try combineEvents(arena, found_events, json_events);

    std.log.info("final elements len: {d}", .{final_elems.len});
    std.log.info("final attributes len: {d}", .{final_attrs.len});
    std.log.info("final events len: {d}", .{final_events.len});

    {
        const elements_file = try tools_dir.openFile("html_elements.zon", .{ .mode = .write_only });
        defer elements_file.close();

        try std.zon.stringify.serialize(final_elems, .{}, elements_file.deprecatedWriter());

        try elements_file.setEndPos(try elements_file.getPos());
    }

    {
        const attributes_file = try tools_dir.openFile("html_attributes.zon", .{ .mode = .write_only });
        defer attributes_file.close();

        try std.zon.stringify.serialize(final_attrs, .{}, attributes_file.deprecatedWriter());

        try attributes_file.setEndPos(try attributes_file.getPos());
    }

    {
        const events_file = try tools_dir.openFile("html_events.zon", .{ .mode = .write_only });
        defer events_file.close();

        try std.zon.stringify.serialize(final_events, .{}, events_file.deprecatedWriter());

        try events_file.setEndPos(try events_file.getPos());
    }
}

fn jsonEvents(arena: Allocator, tools_dir: fs.Dir) ![]Event {
    const GeneralSchema = struct {
        name: []const u8,
        interface: []const u8,
    };
    const MediaSchema = struct {
        name: []const u8,
        interface: []const u8,
    };
    const DragSchema = struct {
        name: []const u8,
    };
    const Schema = struct {
        general_events: []GeneralSchema,
        media_events: []MediaSchema,
        drag_and_drop_events: []DragSchema,
    };

    const file = try tools_dir.openFile("html_events.json", .{});
    defer file.close();

    const bytes = try file.readToEndAlloc(arena, 1 << 25);

    const json = try std.json.parseFromSlice(Schema, arena, bytes, .{});
    const value: Schema = json.value;

    const events = try arena.alloc(Event, value.general_events.len +
        value.media_events.len +
        value.drag_and_drop_events.len);

    var i: usize = 0;
    for (value.general_events) |e| {
        defer i += 1;

        events[i] = .{
            .name = e.name,
            .interface = e.interface,
        };
    }
    for (value.media_events) |e| {
        defer i += 1;

        events[i] = .{
            .name = e.name,
            .interface = e.interface,
        };
    }
    for (value.drag_and_drop_events) |e| {
        defer i += 1;

        events[i] = .{
            .name = e.name,
            .interface = "DragEvent",
        };
    }

    assert(events.len == i);
    return events;
}

const JsonAttribute = struct {
    pub const Details = struct {
        elements: []const []const u8,
        description: []const u8,
    };

    attribute_name: []const u8,
    details: []const Details,
};

fn jsonAttrs(arena: Allocator, tools_dir: fs.Dir) ![]JsonAttribute {
    const file = try tools_dir.openFile("html_attributes.json", .{});
    defer file.close();

    const bytes = try file.readToEndAlloc(arena, 1 << 25);

    const json = try std.json.parseFromSlice([]JsonAttribute, arena, bytes, .{});
    return json.value;
}

const JsonElement = struct {
    name: []const u8,
    description: []const u8,
    attributes: []const []const u8,
    interface: []const u8,
};

fn jsonElems(arena: Allocator, tools_dir: fs.Dir) ![]JsonElement {
    const file = try tools_dir.openFile("html_elements.json", .{});
    defer file.close();

    const bytes = try file.readToEndAlloc(arena, 1 << 25);

    const json = try std.json.parseFromSlice([]JsonElement, arena, bytes, .{});
    return json.value;
}

fn combineElems(arena: Allocator, found: []Element, json: []JsonElement, compat: []CompatElement) ![]Element {
    var arr: std.ArrayListUnmanaged(Element) = .{ .capacity = found.len, .items = found };

    loop: for (json) |elem| {
        check: for (arr.items) |*e| {
            if (!std.mem.eql(u8, elem.name, e.tag))
                continue :check;

            e.attributes = elem.attributes;
            e.description = elem.description;
            e.interface = elem.interface;

            continue :loop;
        }

        // New element
        try arr.append(arena, .{
            .tag = elem.name,
            .void_element = false,
            .description = elem.description,
            .attributes = elem.attributes,
            .interface = elem.interface,
            .value = .string,
            .meta = .default,
        });
    }

    loop: for (compat) |elem| {
        check: for (arr.items) |*e| {
            if (!std.mem.eql(u8, elem.tag, e.tag))
                continue :check;

            // Stay up to date with browser compat
            e.meta = elem.meta;

            // We found a matching element, so no need to add it to the list
            continue :loop;
        }

        // New element
        if (elem.meta.state != .deprecated)
            std.log.warn("Element {s} in compat data but not found", .{elem.tag});
    }

    return arr.toOwnedSlice(arena);
}

fn combineAttrs(arena: Allocator, found: []Attribute, json: []JsonAttribute, compat: []CompatAttribute) ![]const Attribute {
    var arr: std.ArrayListUnmanaged(Attribute) = .{ .capacity = found.len, .items = found };

    loop: for (json) |attr| {
        check: for (arr.items) |*a| {
            if (!std.mem.eql(u8, attr.attribute_name, a.tag))
                continue :check;

            var details: std.ArrayListUnmanaged(AttributeDetails) = .empty;
            for (a.details) |d| try details.append(arena, d);
            defer a.details = details.items;

            details: for (attr.details) |attr_d| {
                for (details.items) |*d| {
                    var relevant = false;
                    for (attr_d.elements) |a_e| {
                        for (d.elements) |e|
                            relevant = relevant or std.mem.indexOf(u8, e, a_e) != null;
                    }

                    if (!relevant)
                        continue :details;

                    d.description = attr_d.description;
                    d.elements = attr_d.elements;

                    continue :loop;
                }

                // New details
                try details.append(arena, .{
                    .description = attr_d.description,
                    .elements = attr_d.elements,
                    .meta = .default,
                });
            }
        }

        var details: std.ArrayListUnmanaged(AttributeDetails) = .empty;
        for (attr.details) |d|
            try details.append(arena, .{
                .description = d.description,
                .elements = d.elements,
                .meta = .default,
            });

        try arr.append(arena, .{
            .tag = attr.attribute_name,
            .global = false,
            .value = .string,
            .details = details.items,
        });
    }

    loop: for (compat) |attr| {
        check: for (arr.items) |*a| {
            if (!std.mem.eql(u8, attr.attr_tag, a.tag))
                continue :check;

            for (a.details) |*d| {
                var relevant = false;
                for (d.elements) |e|
                    relevant = relevant or std.mem.indexOf(u8, e, attr.elem_tag) != null;

                if (!relevant)
                    continue :check;

                d.meta = attr.meta;
            }

            // We found a matching element, so no need to add it to the list
            continue :loop;
        }

        // New element
        if (attr.meta.state != .deprecated)
            std.log.warn("Attribute {s} for {s} in compat data but not found", .{ attr.attr_tag, attr.elem_tag });
    }

    return arr.toOwnedSlice(arena);
}

fn combineEvents(arena: Allocator, found: []Event, json: []Event) ![]const Event {
    // var set: std.StringHashMapUnmanaged(Event) = .empty;
    //
    // // dedupe :(
    // for (found) |e| try set.put(arena, e.name, e);

    var arr: std.ArrayListUnmanaged(Event) = .{ .capacity = found.len, .items = found };

    loop: for (json) |event| {
        check: for (arr.items) |*e| {
            if (!std.mem.eql(u8, event.name, e.name))
                continue :check;

            // We want to leave the defined specified interface

            continue :loop;
        }

        try arr.append(arena, .{
            .name = event.name,
            .interface = event.interface,
        });
    }

    return arr.toOwnedSlice(arena);
}

const CompatElement = struct {
    tag: []const u8,
    meta: Meta,
};

const CompatAttribute = struct {
    attr_tag: []const u8,
    elem_tag: []const u8,
    meta: Meta,
};

fn compatData(arena: Allocator, html_dir_path: []const u8) !struct { []CompatElement, []CompatAttribute } {
    var html_dir = try fs.openDirAbsolute(html_dir_path, .{ .iterate = true });
    defer html_dir.close();

    const parsed_elements = try parse_compat.parseElements(html_dir, arena);

    const parsed_global_attributes = try parse_compat.parseGlobalAttributes(html_dir, arena);

    var attrs: std.ArrayListUnmanaged(CompatAttribute) = .empty;

    for (parsed_global_attributes) |ga| {
        const spec_url: []const []const u8 = if (ga.compat.spec) |s| blk: {
            const slice = try arena.alloc([]const u8, 1);
            slice[0] = try arena.dupe(u8, s);
            break :blk slice;
        } else &.{};

        const mdn_url: []const []const u8 = if (ga.compat.mdn) |s| blk: {
            const slice = try arena.alloc([]const u8, 1);
            slice[0] = try arena.dupe(u8, s);
            break :blk slice;
        } else &.{};

        try attrs.append(arena, .{
            .attr_tag = ga.name,
            .elem_tag = "global",
            .meta = .{
                .spec_url = spec_url,
                .mdn_url = mdn_url,
                .state = if (ga.compat.deprecated and !ga.compat.experimental)
                    .deprecated
                else if (ga.compat.experimental and !ga.compat.deprecated)
                    .experimental
                else if (ga.compat.standard and !ga.compat.deprecated and !ga.compat.experimental)
                    .standard
                else
                    @panic("Weird compat combo"),
            },
        });
    }

    var elements: std.ArrayListUnmanaged(CompatElement) = .empty;

    for (parsed_elements) |parsed| {
        const spec_url: []const []const u8 = if (parsed.compat.spec) |s| blk: {
            const slice = try arena.alloc([]const u8, 1);
            slice[0] = try arena.dupe(u8, s);
            break :blk slice;
        } else &.{};

        const mdn_url: []const []const u8 = if (parsed.compat.mdn) |s| blk: {
            const slice = try arena.alloc([]const u8, 1);
            slice[0] = try arena.dupe(u8, s);
            break :blk slice;
        } else &.{};

        try elements.append(arena, .{
            .tag = parsed.tag,
            .meta = .{
                .spec_url = spec_url,
                .mdn_url = mdn_url,
                .state = if (parsed.compat.deprecated and !parsed.compat.experimental)
                    .deprecated
                else if (parsed.compat.experimental and !parsed.compat.deprecated)
                    .experimental
                else if (parsed.compat.standard and !parsed.compat.deprecated and !parsed.compat.experimental)
                    .standard
                else
                    .unknown,
            },
        });

        for (parsed.extra_attributes) |attr| {
            const attr_spec_url: []const []const u8 = if (attr.compat.spec) |s| blk: {
                const slice = try arena.alloc([]const u8, 1);
                slice[0] = try arena.dupe(u8, s);
                break :blk slice;
            } else &.{};

            const attr_mdn_url: []const []const u8 = if (attr.compat.mdn) |s| blk: {
                const slice = try arena.alloc([]const u8, 1);
                slice[0] = try arena.dupe(u8, s);
                break :blk slice;
            } else &.{};

            try attrs.append(arena, .{
                .attr_tag = attr.name,
                .elem_tag = parsed.tag,
                .meta = .{
                    .spec_url = attr_spec_url,
                    .mdn_url = attr_mdn_url,
                    .state = if (attr.compat.deprecated and !attr.compat.experimental)
                        .deprecated
                    else if (attr.compat.experimental and !attr.compat.deprecated)
                        .experimental
                    else if (attr.compat.standard and !attr.compat.deprecated and !attr.compat.experimental)
                        .standard
                    else
                        .unknown,
                },
            });
        }
    }

    return .{ try elements.toOwnedSlice(arena), try attrs.toOwnedSlice(arena) };
}

fn foundElems(gpa: Allocator, tools_dir: fs.Dir) ![]Element {
    const elements_zon_file = try tools_dir.openFile("html_elements.zon", .{});

    const bytes = try elements_zon_file.readToEndAllocOptions(gpa, 1 << 25, null, .of(u8), 0);

    return try std.zon.parse.fromSlice([]Element, gpa, bytes, null, .{});
}

fn foundAttrs(gpa: Allocator, tools_dir: fs.Dir) ![]Attribute {
    const attributes_zon_file = try tools_dir.openFile("html_attributes.zon", .{});

    const bytes = try attributes_zon_file.readToEndAllocOptions(gpa, 1 << 25, null, .of(u8), 0);

    return try std.zon.parse.fromSlice([]Attribute, gpa, bytes, null, .{});
}

fn foundEvents(gpa: Allocator, tools_dir: fs.Dir) ![]Event {
    const attributes_zon_file = try tools_dir.openFile("html_events.zon", .{});

    const bytes = try attributes_zon_file.readToEndAllocOptions(gpa, 1 << 25, null, .of(u8), 0);

    return try std.zon.parse.fromSlice([]Event, gpa, bytes, null, .{});
}

const std = @import("std");
const fs = std.fs;
const schemas = @import("schemas.zig");
const parse_compat = @import("parse_compat.zig");

const assert = std.debug.assert;

const Allocator = std.mem.Allocator;

const Element = schemas.Element;
const Event = schemas.Event;
const Attribute = schemas.Attribute;
const AttributeDetails = schemas.AttributeDetails;
const Meta = schemas.Meta;
