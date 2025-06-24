pub const ElementTag = []const u8;
pub const AttributeTag = []const u8;

pub const Value = union(enum) {
    string,
    items: []const []const u8,
    boolean,
    void,
};

pub const Meta = struct {
    origin: []const u8,
    spec_url: []const []const u8,
    mdn_url: []const []const u8,
    state: enum { experimental, standard, deprecated, unknown },
};

pub const Attribute = struct {
    tag: AttributeTag,
    global: bool,
    value: Value,
    meta: []const Meta,
};

pub const Element = struct {
    tag: ElementTag,
    value: Value,
    /// Is the element a void element, by extension, is it 'self closing'
    void_element: bool,
    attributes: []const AttributeTag,
    meta: Meta,
};
