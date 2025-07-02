pub const EventName = []const u8;
pub const ElementTag = []const u8;
pub const AttributeTag = []const u8;
pub const Interface = []const u8;

pub const Value = union(enum) {
    string,
    items: []const []const u8,
    boolean,
    void,
};

pub const Meta = struct {
    pub const default: Meta = .{
        .spec_url = &.{},
        .mdn_url = &.{},
        .state = .unknown,
    };

    spec_url: []const []const u8,
    mdn_url: []const []const u8,
    state: enum { experimental, standard, deprecated, unknown },
};

pub const AttributeDetails = struct {
    elements: []const ElementTag,
    description: []const u8,
    meta: Meta,
};

pub const Attribute = struct {
    tag: AttributeTag,
    global: bool,
    value: Value,
    details: []AttributeDetails,
};

pub const Element = struct {
    tag: ElementTag,
    value: Value,
    /// Is the element a void element, by extension, is it 'self closing'
    void_element: bool,
    interface: Interface = "",
    attributes: []const AttributeTag,
    description: []const u8 = "",
    meta: Meta,
};

pub const Event = struct {
    name: EventName,
    interface: Interface,
};
