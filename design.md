# API usage

## Basic Templating Syntax

```zig
const html_node: HtmlNode = .div(.{ .id = "ids" .class="and classes"}, &.{
        .p(.{}, "Regular text or"),
        .pExt(.{}, &.{
            .text("More expressive form with "),
            .a(.{ .href = "example.com" }, "links"),
            .text(" inside it (or any other valid element)"),
        }),
    });
```

## Event Passing

```zig
const FooData = struct { event: HtmlTree.OnClickEvent };
const BarData = struct { event: HtmlTree.OnClickEvent, count: u32 };

fn incrementData(ctx: *anyopaque, self: HtmlTree.Ref, event: OnClickEventData) !void {
    const data: *BarData = @alignCast(@ptrCast(ctx));
    _ = event;

    // Update the data
    data.count += 1;

    // Mark self as dirty, and require a regeneration
    self.dirty();
}

// Generation function called every time we need to regenerate Foo
fn generateFoo(ctx: *anyopaque, ref: HtmlTree.Ref, arena: Allocator) !HtmlTree {
    const data: *FooData = @alignCast(@ptrCast(ctx));

    // Return a button which emits a `foo_event` on click
    return .button( .{ .onclick = foo_event }, "Click me!");
}

// Generation function called every time we need to regenerate Bar
fn generateBar(ctx: *anyopaque, ref: HtmlTree.Ref, arena: Allocator) !HtmlTree {
    const data: *BarData = @alignCast(@ptrCast(ctx));

    // Listen to the foo_event
    ref.listen(foo_event, &incrementData);

    // Simply display our data
    return .p(.{}, try std.fmt.allocPrint(arena, "foo count: {d}", .{data.count}));
}

pub fn main() !void {
    // ...
    const tree: HtmlTree = .init(gpa);
    defer tree.deinit();

    const document = js.getDocument();
    const main_div = document.getElementById("main");
    const button_div = document.getElementById("button");

    // Register a new event in the tree. This is basically just a marker
    const foo_event = tree.onClickEvent();

    // Pass along the foo event, and a way to generate foo
    const foo_tree = try tree.register(FooData{ .event = foo_event }, &generateFoo);

    // Pass along the foo event, and a way to generate bar
    const bar_tree = try tree.register(BarData{ .event = foo_event, .count = 0 }, &generateBar);

    try tree.set(button_div, foo_tree);
    try tree.set(main_div, bar_tree);
}

```

## Sample App

Problems:

- Currently the idea is that each regeneration has its own arena, so how do
  we handle persistent data in a reasonable manner?

```zig
const Button = struct {
    button_event: OnClickEvent,

    pub fn init(tree: *HtmlTree) !struct{ SubTree, OnClickEvent } {
        const event = tree.onClickEvent();
        const subtree = try tree.register(Button{ .button_event = event }, &generate);

        return .{ subtree, event };
    }

    fn generate(ctx: *anyopaque, arena: Allocator) !HtmlNode {
        const data: *Button = @alignCast(@ptrCast(ctx));

        // Return a button which emits the provided event on click
        return .button( .{ .onclick = data.button_event }, "Click me!");
    }
};

const Text = struct {
    button_event: OnClickEvent,
    count: u32,

    pub fn init(tree: *HtmlTree, event: OnClickEvent) !SubTree {
        const subtree = try tree.register(Text{ .button_event = event, .count = 0 }, &generate);

        // Not suuper happy subtree can listen, but a great improvement
        try subtree.listen(event, &eventHandle);

        return subtree;
    }

    fn eventHandle(ctx: *anyopaque, self: SubTree, event: OnClickEventData) !void {
        // Mark subtree for regeneration
        defer self.dirty();

        const text: Text = @alignCast(@ptrCast(ctx));
        text.count += 1;
    };

    fn generate(ctx: *anyopaque, ref: Ref, arena: Allocator) !HtmlNode {
        const data: *Text = @alignCast(@ptrCast(ctx));

        // Simply display our data
        return .p(.{}, try std.fmt.allocPrint(arena, "foo count: {d}", .{data.count}));
    }
};

const App = struct {
    button: SubTree,
    text: SubTree,


    pub fn init(tree: *HtmlTree) !SubTree {
        const button, const button_event = try Button.init(tree);
        const text = try Text.init(tree, button_event);

        return try tree.register(App{
            .button = button,
            .text = text,
        }, &generate);
    }

    fn generate(ctx: *anyopaque, ref: Ref, arena: Allocator) !HtmlNode {
        const data: *App = @alignCast(@ptrCast(ctx));

        // Simply display our data
        return .div(.{}, &.{ ref.render(data.text), ref.render(data.button) });
    }
};



pub fn main() !void {
    // ...
    var tree = .init();
    defer tree.deinit();

    const app = try App.init(tree);

    try tree.mount("#app", app);
}
```

## Callbacks

Currently, there is quite a problem I found with callbacks. When you have
multiple instances of a `SubTree`, a callback applies to all those instances
indescrimiately. This is not the behavior I want. If I have 2 counter, they
should count individually. I think the correct solution to this problem is to
not have multiple instances of the same subtree if they are not supposed to
show the same data.

To that end, I feel like the struct in the code (as shown by the usage above)
would be the 'template' so to say, and then a registry would be an instance. I
might need to rename `register` then. I also feel that with this change
deregistering becomes a more sane usecase? I think for now deregistering will
be a TODO.

I should also move html rendering to the `SubTree` namespace. There I can more
easily justify passing in a `SubTree.Index` so I can generate proper code for
callbacks. Maybe just move it to manager, that might make most sense.

Finally, consider moving most callback related logic to `SubTree` and making
callbacks local to the current subtree. That way I would get 'automatic'
deregistering of callbacks with a potential future deregister impl. Maybe leave
this until that happens
