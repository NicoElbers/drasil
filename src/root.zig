pub const Tree = @import("Tree.zig");
pub const Manager = @import("Manager.zig");
pub const SubTree = @import("SubTree.zig");
pub const Event = @import("event.zig").Event;
pub const Reactive = @import("reactive.zig").Reactive;

pub const web = @import("web.zig");

comptime {
    _ = @import("test.zig");

    _ = Tree;
    _ = Manager;
    _ = SubTree;
    _ = Event;
    _ = Reactive;
}
