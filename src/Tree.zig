//! Represents a HTML5 tree, this can be used with a `Manager` to render
//! dynamic content.

const Tree = @This();

pub const Node = union(enum) {
    element: struct {
        tag: ElementTag,
        attributes: []const Attribute,
        sub_trees: []const Tree,
    },
    void: struct {
        tag: ElementTag,
        attributes: []const Attribute,
    },
    text: []const u8,
    dynamic: SubTree.Index,
    static: *const Tree,
};

node: Node,

/// ---------------
/// WARNING:
/// This function injects unescaped bytes into the tree, be wary
/// that this can and will be abused when passing in user provided data.
/// ---------------
pub fn raw(text: []const u8) Tree {
    return .{ .node = .{ .text = text } };
}

pub fn dyn(sub_tree_index: SubTree.Index) Tree {
    return .{ .node = .{ .dynamic = sub_tree_index } };
}

// @GENERATED SECTION START

// generated - *DO NOT EDIT MANUALLY*

/// Hyperlink
///
/// Element with interface HTMLAnchorElement
///
/// Allowed attributes:
///   globals
///   .href
///   .target
///   .download
///   .ping
///   .rel
///   .hreflang
///   .type
///   .referrerpolicy
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-a-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a
/// status: standard
pub fn a(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .a,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Abbreviation
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-abbr-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/abbr
/// status: standard
pub fn abbr(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .abbr,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Contact information for a page or article element
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-address-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/address
/// status: standard
pub fn address(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .address,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Hyperlink or dead area on an image map
///
/// Is a void element
///
/// Element with interface HTMLAreaElement
///
/// Allowed attributes:
///   globals
///   .alt
///   .coords
///   .shape
///   .href
///   .target
///   .download
///   .ping
///   .rel
///   .referrerpolicy
///
/// Spec: https://html.spec.whatwg.org/multipage/image-maps.html#the-area-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/area
/// status: standard
pub fn area(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .area,
        .attributes = attributes,
    } } };
}
/// Self-contained syndicatable or reusable composition
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-article-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/article
/// status: standard
pub fn article(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .article,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Sidebar for tangentially related content
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-aside-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/aside
/// status: standard
pub fn aside(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .aside,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Audio player
///
/// Element with interface HTMLAudioElement
///
/// Allowed attributes:
///   globals
///   .src
///   .crossorigin
///   .preload
///   .autoplay
///   .loop
///   .muted
///   .controls
///
/// Spec: https://html.spec.whatwg.org/multipage/media.html#the-audio-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/audio
/// status: standard
pub fn audio(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .audio,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Keywords
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-b-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/b
/// status: standard
pub fn b(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .b,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Base URL and default target navigable for hyperlinks and forms
///
/// Is a void element
///
/// Element with interface HTMLBaseElement
///
/// Allowed attributes:
///   globals
///   .href
///   .target
///
/// Spec: https://html.spec.whatwg.org/multipage/semantics.html#the-base-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/base
/// status: standard
pub fn base(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .base,
        .attributes = attributes,
    } } };
}
/// Text directionality isolation
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdi-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/bdi
/// status: standard
pub fn bdi(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .bdi,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Text directionality formatting
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdo-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/bdo
/// status: standard
pub fn bdo(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .bdo,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// A section quoted from another source
///
/// Element with interface HTMLQuoteElement
///
/// Allowed attributes:
///   globals
///   .cite
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-blockquote-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/blockquote
/// status: standard
pub fn blockquote(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .blockquote,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Document body
///
/// Element with interface HTMLBodyElement
///
/// Allowed attributes:
///   globals
///   .onafterprint
///   .onbeforeprint
///   .onbeforeunload
///   .onhashchange
///   .onlanguagechange
///   .onmessage
///   .onmessageerror
///   .onoffline
///   .ononline
///   .onpageswap
///   .onpagehide
///   .onpagereveal
///   .onpageshow
///   .onpopstate
///   .onrejectionhandled
///   .onstorage
///   .onunhandledrejection
///   .onunload
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-body-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/body
/// status: standard
pub fn body(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .body,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Line break, e.g. in poem or postal address
///
/// Is a void element
///
/// Element with interface HTMLBRElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-br-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/br
/// status: standard
pub fn br(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .br,
        .attributes = attributes,
    } } };
}
/// Button control
///
/// Element with interface HTMLButtonElement
///
/// Allowed attributes:
///   globals
///   .command
///   .commandfor
///   .disabled
///   .form
///   .formaction
///   .formenctype
///   .formmethod
///   .formnovalidate
///   .formtarget
///   .name
///   .popovertarget
///   .popovertargetaction
///   .type
///   .value
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-button-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button
/// status: standard
pub fn button(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .button,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Scriptable bitmap canvas
///
/// Element with interface HTMLCanvasElement
///
/// Allowed attributes:
///   globals
///   .width
///   .height
///
/// Spec: https://html.spec.whatwg.org/multipage/canvas.html#the-canvas-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/canvas
/// status: standard
pub fn canvas(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .canvas,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Table caption
///
/// Element with interface HTMLTableCaptionElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-caption-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/caption
/// status: standard
pub fn caption(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .caption,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Title of a work
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-cite-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/cite
/// status: standard
pub fn cite(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .cite,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Computer code
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-code-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/code
/// status: standard
pub fn code(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .code,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Table column
///
/// Is a void element
///
/// Element with interface HTMLTableColElement
///
/// Allowed attributes:
///   globals
///   .span
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-col-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/col
/// status: standard
pub fn col(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .col,
        .attributes = attributes,
    } } };
}
/// Group of columns in a table
///
/// Element with interface HTMLTableColElement
///
/// Allowed attributes:
///   globals
///   .span
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-colgroup-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/colgroup
/// status: standard
pub fn colgroup(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .colgroup,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Machine-readable equivalent
///
/// Element with interface HTMLDataElement
///
/// Allowed attributes:
///   globals
///   .value
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-data-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/data
/// status: standard
pub fn data(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .data,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Container for options for combo box control
///
/// Element with interface HTMLDataListElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-datalist-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/datalist
/// status: standard
pub fn datalist(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .datalist,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Content for corresponding dt element(s)
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dd-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dd
/// status: standard
pub fn dd(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .dd,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// A removal from the document
///
/// Element with interface HTMLModElement
///
/// Allowed attributes:
///   globals
///   .cite
///   .datetime
///
/// Spec: https://html.spec.whatwg.org/multipage/edits.html#the-del-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/del
/// status: standard
pub fn del(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .del,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Disclosure control for hiding details
///
/// Element with interface HTMLDetailsElement
///
/// Allowed attributes:
///   globals
///   .name
///   .open
///
/// Spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-details-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/details
/// status: standard
pub fn details(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .details,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Defining instance
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-dfn-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dfn
/// status: standard
pub fn dfn(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .dfn,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Dialog box or window
///
/// Element with interface HTMLDialogElement
///
/// Allowed attributes:
///   globals
///   .open
///
/// Spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-dialog-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dialog
/// status: standard
pub fn dialog(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .dialog,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Generic flow container, or container for name-value groups in dl elements
///
/// Element with interface HTMLDivElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-div-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/div
/// status: standard
pub fn div(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .div,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Association list consisting of zero or more name-value groups
///
/// Element with interface HTMLDListElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dl-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dl
/// status: standard
pub fn dl(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .dl,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Legend for corresponding dd element(s)
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dt-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dt
/// status: standard
pub fn dt(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .dt,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Stress emphasis
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-em-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/em
/// status: standard
pub fn em(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .em,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Plugin
///
/// Is a void element
///
/// Element with interface HTMLEmbedElement
///
/// Allowed attributes:
///   globals
///   .src
///   .type
///   .width
///   .height
///
/// Spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-embed-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/embed
/// status: standard
pub fn embed(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .embed,
        .attributes = attributes,
    } } };
}
/// Group of form controls
///
/// Element with interface HTMLFieldSetElement
///
/// Allowed attributes:
///   globals
///   .disabled
///   .form
///   .name
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-fieldset-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/fieldset
/// status: standard
pub fn fieldset(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .fieldset,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Caption for figure
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-figcaption-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/figcaption
/// status: standard
pub fn figcaption(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .figcaption,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Figure with optional caption
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-figure-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/figure
/// status: standard
pub fn figure(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .figure,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Footer for a page or section
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-footer-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/footer
/// status: standard
pub fn footer(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .footer,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// User-submittable form
///
/// Element with interface HTMLFormElement
///
/// Allowed attributes:
///   globals
///   .@"accept-charset"
///   .action
///   .autocomplete
///   .enctype
///   .method
///   .name
///   .novalidate
///   .rel
///   .target
///
/// Spec: https://html.spec.whatwg.org/multipage/forms.html#the-form-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/form
/// status: standard
pub fn form(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .form,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Heading
///
/// Element with interface HTMLHeadingElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
pub fn h1(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .h1,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Heading
///
/// Element with interface HTMLHeadingElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
pub fn h2(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .h2,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Heading
///
/// Element with interface HTMLHeadingElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
pub fn h3(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .h3,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Heading
///
/// Element with interface HTMLHeadingElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
pub fn h4(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .h4,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Heading
///
/// Element with interface HTMLHeadingElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
pub fn h5(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .h5,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Heading
///
/// Element with interface HTMLHeadingElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
pub fn h6(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .h6,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Container for document metadata
///
/// Element with interface HTMLHeadElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/semantics.html#the-head-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/head
/// status: standard
pub fn head(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .head,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Introductory or navigational aids for a page or section
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-header-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/header
/// status: standard
pub fn header(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .header,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Heading container
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-hgroup-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/hgroup
/// status: standard
pub fn hgroup(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .hgroup,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Thematic break
///
/// Is a void element
///
/// Element with interface HTMLHRElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-hr-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/hr
/// status: standard
pub fn hr(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .hr,
        .attributes = attributes,
    } } };
}
/// Root element
///
/// Element with interface HTMLHtmlElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/semantics.html#the-html-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/html
/// status: standard
pub fn html(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .html,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Alternate voice
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-i-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/i
/// status: standard
pub fn i(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .i,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Child navigable
///
/// Element with interface HTMLIFrameElement
///
/// Allowed attributes:
///   globals
///   .src
///   .srcdoc
///   .name
///   .sandbox
///   .allow
///   .allowfullscreen
///   .width
///   .height
///   .referrerpolicy
///   .loading
///
/// Spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-iframe-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe
/// status: standard
pub fn iframe(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .iframe,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Image
///
/// Is a void element
///
/// Element with interface HTMLImageElement
///
/// Allowed attributes:
///   globals
///   .alt
///   .src
///   .srcset
///   .sizes
///   .crossorigin
///   .usemap
///   .ismap
///   .width
///   .height
///   .referrerpolicy
///   .decoding
///   .loading
///   .fetchpriority
///
/// Spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-img-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img
/// status: standard
pub fn img(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .img,
        .attributes = attributes,
    } } };
}
/// Form control
///
/// Is a void element
///
/// Element with interface HTMLInputElement
///
/// Allowed attributes:
///   globals
///   .accept
///   .alpha
///   .alt
///   .autocomplete
///   .checked
///   .colorspace
///   .dirname
///   .disabled
///   .form
///   .formaction
///   .formenctype
///   .formmethod
///   .formnovalidate
///   .formtarget
///   .height
///   .list
///   .max
///   .maxlength
///   .min
///   .minlength
///   .multiple
///   .name
///   .pattern
///   .placeholder
///   .popovertarget
///   .popovertargetaction
///   .readonly
///   .required
///   .size
///   .src
///   .step
///   .type
///   .value
///   .width
///
/// Spec: https://html.spec.whatwg.org/multipage/input.html#the-input-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input
/// status: standard
pub fn input(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .input,
        .attributes = attributes,
    } } };
}
/// An addition to the document
///
/// Element with interface HTMLModElement
///
/// Allowed attributes:
///   globals
///   .cite
///   .datetime
///
/// Spec: https://html.spec.whatwg.org/multipage/edits.html#the-ins-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ins
/// status: standard
pub fn ins(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .ins,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// User input
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-kbd-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/kbd
/// status: standard
pub fn kbd(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .kbd,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Caption for a form control
///
/// Element with interface HTMLLabelElement
///
/// Allowed attributes:
///   globals
///   .@"for"
///
/// Spec: https://html.spec.whatwg.org/multipage/forms.html#the-label-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/label
/// status: standard
pub fn label(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .label,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Caption for fieldset
///
/// Element with interface HTMLLegendElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-legend-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/legend
/// status: standard
pub fn legend(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .legend,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// List item
///
/// Element with interface HTMLLIElement
///
/// Allowed attributes:
///   globals
///   .value
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-li-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/li
/// status: standard
pub fn li(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .li,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Link metadata
///
/// Is a void element
///
/// Element with interface HTMLLinkElement
///
/// Allowed attributes:
///   globals
///   .href
///   .crossorigin
///   .rel
///   .as
///   .media
///   .hreflang
///   .type
///   .sizes
///   .imagesrcset
///   .imagesizes
///   .referrerpolicy
///   .integrity
///   .blocking
///   .color
///   .disabled
///   .fetchpriority
///
/// Spec: https://html.spec.whatwg.org/multipage/semantics.html#the-link-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/link
/// status: standard
pub fn link(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .link,
        .attributes = attributes,
    } } };
}
/// Container for the dominant contents of the document
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-main-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/main
/// status: standard
pub fn main(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .main,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Image map
///
/// Element with interface HTMLMapElement
///
/// Allowed attributes:
///   globals
///   .name
///
/// Spec: https://html.spec.whatwg.org/multipage/image-maps.html#the-map-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/map
/// status: standard
pub fn map(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .map,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Highlight
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-mark-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/mark
/// status: standard
pub fn mark(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .mark,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// MathML root
///
/// Element with interface Element
///
/// Allowed attributes:
///
/// status: unknown
pub fn math(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .math,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Menu of commands
///
/// Element with interface HTMLMenuElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-menu-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/menu
/// status: standard
pub fn menu(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .menu,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Text metadata
///
/// Is a void element
///
/// Element with interface HTMLMetaElement
///
/// Allowed attributes:
///   globals
///   .name
///   .@"http-equiv"
///   .content
///   .charset
///   .media
///
/// Spec: https://html.spec.whatwg.org/multipage/semantics.html#the-meta-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta
/// status: standard
pub fn meta(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .meta,
        .attributes = attributes,
    } } };
}
/// Gauge
///
/// Element with interface HTMLMeterElement
///
/// Allowed attributes:
///   globals
///   .value
///   .min
///   .max
///   .low
///   .high
///   .optimum
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-meter-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meter
/// status: standard
pub fn meter(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .meter,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Section with navigational links
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-nav-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/nav
/// status: standard
pub fn nav(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .nav,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Fallback content for script
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/scripting.html#the-noscript-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/noscript
/// status: standard
pub fn noscript(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .noscript,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Image, child navigable, or plugin
///
/// Element with interface HTMLObjectElement
///
/// Allowed attributes:
///   globals
///   .data
///   .type
///   .name
///   .form
///   .width
///   .height
///
/// Spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-object-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/object
/// status: standard
pub fn object(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .object,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Ordered list
///
/// Element with interface HTMLOListElement
///
/// Allowed attributes:
///   globals
///   .reversed
///   .start
///   .type
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-ol-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ol
/// status: standard
pub fn ol(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .ol,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Group of options in a list box
///
/// Element with interface HTMLOptGroupElement
///
/// Allowed attributes:
///   globals
///   .disabled
///   .label
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-optgroup-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/optgroup
/// status: standard
pub fn optgroup(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .optgroup,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Option in a list box or combo box control
///
/// Element with interface HTMLOptionElement
///
/// Allowed attributes:
///   globals
///   .disabled
///   .label
///   .selected
///   .value
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-option-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/option
/// status: standard
pub fn option(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .option,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Calculated output value
///
/// Element with interface HTMLOutputElement
///
/// Allowed attributes:
///   globals
///   .@"for"
///   .form
///   .name
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-output-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/output
/// status: standard
pub fn output(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .output,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Paragraph
///
/// Element with interface HTMLParagraphElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-p-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/p
/// status: standard
pub fn p(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .p,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Image
///
/// Element with interface HTMLPictureElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-picture-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/picture
/// status: standard
pub fn picture(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .picture,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Block of preformatted text
///
/// Element with interface HTMLPreElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-pre-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/pre
/// status: standard
pub fn pre(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .pre,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Progress bar
///
/// Element with interface HTMLProgressElement
///
/// Allowed attributes:
///   globals
///   .value
///   .max
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-progress-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/progress
/// status: standard
pub fn progress(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .progress,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Quotation
///
/// Element with interface HTMLQuoteElement
///
/// Allowed attributes:
///   globals
///   .cite
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-q-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/q
/// status: standard
pub fn q(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .q,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Parenthesis for ruby annotation text
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rp-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rp
/// status: standard
pub fn rp(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .rp,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Ruby annotation text
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rt-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rt
/// status: standard
pub fn rt(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .rt,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Ruby annotation(s)
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-ruby-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ruby
/// status: standard
pub fn ruby(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .ruby,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Inaccurate text
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-s-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/s
/// status: standard
pub fn s(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .s,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Computer output
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-samp-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/samp
/// status: standard
pub fn samp(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .samp,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Embedded script
///
/// Element with interface HTMLScriptElement
///
/// Allowed attributes:
///   globals
///   .src
///   .type
///   .nomodule
///   .@"async"
///   .@"defer"
///   .crossorigin
///   .integrity
///   .referrerpolicy
///   .blocking
///   .fetchpriority
///
/// Spec: https://html.spec.whatwg.org/multipage/scripting.html#the-script-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script
/// status: standard
pub fn script(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .script,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Container for search controls
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-search-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/search
/// status: standard
pub fn search(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .search,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Generic document or application section
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/sections.html#the-section-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/section
/// status: standard
pub fn section(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .section,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// List box control
///
/// Element with interface HTMLSelectElement
///
/// Allowed attributes:
///   globals
///   .autocomplete
///   .disabled
///   .form
///   .multiple
///   .name
///   .required
///   .size
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-select-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/select
/// status: standard
pub fn select(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .select,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Shadow tree slot
///
/// Element with interface HTMLSlotElement
///
/// Allowed attributes:
///   globals
///   .name
///
/// Spec: https://html.spec.whatwg.org/multipage/scripting.html#the-slot-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/slot
/// status: standard
pub fn slot(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .slot,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Side comment
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-small-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/small
/// status: standard
pub fn small(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .small,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Image source for img or media source for video or audio
///
/// Is a void element
///
/// Element with interface HTMLSourceElement
///
/// Allowed attributes:
///   globals
///   .type
///   .media
///   .src
///   .srcset
///   .sizes
///   .width
///   .height
///
/// Spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-source-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/source
/// status: standard
pub fn source(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .source,
        .attributes = attributes,
    } } };
}
/// Generic phrasing container
///
/// Element with interface HTMLSpanElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-span-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/span
/// status: standard
pub fn span(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .span,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Importance
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-strong-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/strong
/// status: standard
pub fn strong(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .strong,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Embedded styling information
///
/// Element with interface HTMLStyleElement
///
/// Allowed attributes:
///   globals
///   .media
///   .blocking
///
/// Spec: https://html.spec.whatwg.org/multipage/semantics.html#the-style-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/style
/// status: standard
pub fn style(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .style,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Subscript
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-sub-and-sup-elements
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/sub
/// status: standard
pub fn sub(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .sub,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Caption for details
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-summary-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/summary
/// status: standard
pub fn summary(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .summary,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Superscript
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-sub-and-sup-elements
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/sup
/// status: standard
pub fn sup(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .sup,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// SVG root
///
/// Element with interface SVGSVGElement
///
/// Allowed attributes:
///
/// status: unknown
pub fn svg(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .svg,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Table
///
/// Element with interface HTMLTableElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-table-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/table
/// status: standard
pub fn table(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .table,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Group of rows in a table
///
/// Element with interface HTMLTableSectionElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-tbody-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tbody
/// status: standard
pub fn tbody(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .tbody,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Table cell
///
/// Element with interface HTMLTableCellElement
///
/// Allowed attributes:
///   globals
///   .colspan
///   .rowspan
///   .headers
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-td-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/td
/// status: standard
pub fn td(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .td,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Template
///
/// Element with interface HTMLTemplateElement
///
/// Allowed attributes:
///   globals
///   .shadowrootmode
///   .shadowrootdelegatesfocus
///   .shadowrootclonable
///   .shadowrootserializable
///   .shadowrootcustomelementregistry
///
/// Spec: https://html.spec.whatwg.org/multipage/scripting.html#the-template-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template
/// status: standard
pub fn template(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .template,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Multiline text controls
///
/// Element with interface HTMLTextAreaElement
///
/// Allowed attributes:
///   globals
///   .autocomplete
///   .cols
///   .dirname
///   .disabled
///   .form
///   .maxlength
///   .minlength
///   .name
///   .placeholder
///   .readonly
///   .required
///   .rows
///   .wrap
///
/// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-textarea-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/textarea
/// status: standard
pub fn textarea(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .textarea,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Group of footer rows in a table
///
/// Element with interface HTMLTableSectionElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-tfoot-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tfoot
/// status: standard
pub fn tfoot(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .tfoot,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Table header cell
///
/// Element with interface HTMLTableCellElement
///
/// Allowed attributes:
///   globals
///   .colspan
///   .rowspan
///   .headers
///   .scope
///   .abbr
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-th-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/th
/// status: standard
pub fn th(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .th,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Group of heading rows in a table
///
/// Element with interface HTMLTableSectionElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-thead-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/thead
/// status: standard
pub fn thead(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .thead,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Machine-readable equivalent of date- or time-related data
///
/// Element with interface HTMLTimeElement
///
/// Allowed attributes:
///   globals
///   .datetime
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-time-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/time
/// status: standard
pub fn time(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .time,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Document title
///
/// Element with interface HTMLTitleElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/semantics.html#the-title-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/title
/// status: standard
pub fn title(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .title,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Table row
///
/// Element with interface HTMLTableRowElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/tables.html#the-tr-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tr
/// status: standard
pub fn tr(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .tr,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Timed text track
///
/// Is a void element
///
/// Element with interface HTMLTrackElement
///
/// Allowed attributes:
///   globals
///   .default
///   .kind
///   .label
///   .src
///   .srclang
///
/// Spec: https://html.spec.whatwg.org/multipage/media.html#the-track-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/track
/// status: standard
pub fn track(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .track,
        .attributes = attributes,
    } } };
}
/// Unarticulated annotation
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-u-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/u
/// status: standard
pub fn u(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .u,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// List
///
/// Element with interface HTMLUListElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-ul-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ul
/// status: standard
pub fn ul(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .ul,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Variable
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-var-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/var
/// status: standard
pub fn @"var"(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .@"var",
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Video player
///
/// Element with interface HTMLVideoElement
///
/// Allowed attributes:
///   globals
///   .src
///   .crossorigin
///   .poster
///   .preload
///   .autoplay
///   .playsinline
///   .loop
///   .muted
///   .controls
///   .width
///   .height
///
/// Spec: https://html.spec.whatwg.org/multipage/media.html#the-video-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video
/// status: standard
pub fn video(attributes: []const Attribute, sub_trees: []const Tree) Tree {
    return .{ .node = .{ .element = .{
        .tag = .video,
        .attributes = attributes,
        .sub_trees = sub_trees,
    } } };
}
/// Line breaking opportunity
///
/// Is a void element
///
/// Element with interface HTMLElement
///
/// Allowed attributes:
///   globals
///
/// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-wbr-element
/// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/wbr
/// status: standard
pub fn wbr(attributes: []const Attribute) Tree {
    return .{ .node = .{ .void = .{
        .tag = .wbr,
        .attributes = attributes,
    } } };
}
// @GENERATED SECTION END

const std = @import("std");
const html_data = @import("html_data.zig");

const Attribute = html_data.Attribute;
const ElementTag = html_data.ElementTag;
const Allocator = std.mem.Allocator;
const Manager = @import("Manager.zig");
const SubTree = Manager.SubTree;
const Callback = Manager.Callback;
