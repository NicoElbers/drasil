//! A singular node in the HTML5 tree

const HtmlNode = @This();

tag: ElementTag,
attributes: []const Attribute,
children: []const HtmlNode,

// @GENERATED SECTION START

// generated - *DO NOT EDIT MANUALLY*

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-td-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/td
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   abbr
///   align
///   axis
///   bgcolor
///   char
///   charoff
///   colspan
///   headers
///   rowspan
///   scope
///   valign
///   width
pub fn td(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .td,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-meter-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meter
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   high
///   low
///   max
///   min
///   optimum
///   value
pub fn meter(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .meter,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-kbd-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/kbd
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn kbd(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .kbd,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-select-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/select
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   autocomplete
///   disabled
///   form
///   hr_in_select
///   multiple
///   name
///   required
///   size
pub fn select(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .select,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-object-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/object
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   archive
///   border
///   classid
///   codebase
///   codetype
///   data
///   declare
///   form
///   height
///   name
///   standby
///   type
///   usemap
///   width
pub fn object(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .object,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-cite-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/cite
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn cite(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .cite,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/scripting.html#the-slot-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/slot
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   name
pub fn slot(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .slot,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-col-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/col
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   char
///   charoff
///   span
///   valign
///   width
pub fn col(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .col,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-hgroup-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/hgroup
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn hgroup(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .hgroup,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/image-maps.html#the-map-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/map
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   name
pub fn map(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .map,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-data-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/data
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   value
pub fn data(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .data,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   no_ua_styles_in_article_aside_nav_section
pub fn h1(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .h1,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn h3(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .h3,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-option-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/option
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   disabled
///   label
///   selected
///   value
pub fn option(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .option,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#rb
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rb
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn rb(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .rb,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-figure-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/figure
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn figure(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .figure,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rt-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rt
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn rt(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .rt,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdi-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/bdi
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn bdi(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .bdi,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://wicg.github.io/fenced-frame/#the-fencedframe-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/fencedframe
/// status: experimental
///
/// Allowed attributes:
///   Global attributes
///   allow
///   height
///   width
pub fn fencedframe(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .fencedframe,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-header-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/header
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn header(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .header,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#big
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/big
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn big(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .big,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-aside-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/aside
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn aside(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .aside,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-button-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   command
///   commandfor
///   disabled
///   form
///   formaction
///   formenctype
///   formmethod
///   formnovalidate
///   formtarget
///   name
///   popovertarget
///   popovertargetaction
///   type
///   value
pub fn button(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .button,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn h2(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .h2,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-span-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/span
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn span(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .span,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-ul-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ul
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   compact
///   type
pub fn ul(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .ul,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#center
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/center
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn center(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .center,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/input.html#the-input-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   accept
///   align
///   alpha
///   alt
///   autocomplete
///   capture
///   checked
///   colorspace
///   dirname
///   disabled
///   form
///   formaction
///   formenctype
///   formmethod
///   formnovalidate
///   formtarget
///   list
///   max
///   maxlength
///   min
///   minlength
///   mozactionhint
///   multiple
///   name
///   pattern
///   placeholder
///   popovertarget
///   popovertargetaction
///   readonly
///   required
///   size
///   src
///   step
///   usemap
///   webkitdirectory
pub fn input(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .input,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-footer-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/footer
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn footer(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .footer,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#nobr
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/nobr
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn nobr(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .nobr,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-th-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/th
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   abbr
///   align
///   axis
///   bgcolor
///   char
///   charoff
///   colspan
///   headers
///   rowspan
///   scope
///   valign
///   width
pub fn th(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .th,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-source-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/source
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   height
///   media
///   sizes
///   src
///   srcset
///   type
///   width
pub fn source(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .source,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-legend-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/legend
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
pub fn legend(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .legend,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dd-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dd
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn dd(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .dd,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-iframe-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   allow
///   allowfullscreen
///   allowpaymentrequest
///   browsingtopics
///   credentialless
///   csp
///   frameborder
///   height
///   loading
///   longdesc
///   marginheight
///   marginwidth
///   name
///   referrerpolicy
///   sandbox
///   scrolling
///   src
///   srcdoc
///   width
pub fn iframe(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .iframe,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-output-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/output
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   for
///   form
///   name
pub fn output(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .output,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-var-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/var
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn @"var"(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .@"var",
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-meta-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   charset
///   content
///   http-equiv
///   name
///   scheme
pub fn meta(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .meta,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-tr-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tr
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   bgcolor
///   char
///   charoff
///   valign
pub fn tr(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .tr,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn h6(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .h6,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#the-param-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/param
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
///   name
///   type
///   value
///   valuetype
pub fn param(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .param,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/forms.html#the-label-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/label
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   for
pub fn label(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .label,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-menu-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/menu
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn menu(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .menu,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/media.html#the-track-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/track
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   default
///   kind
///   label
///   src
///   srclang
pub fn track(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .track,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-dfn-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dfn
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn dfn(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .dfn,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-base-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/base
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   href
///   target
pub fn base(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .base,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-embed-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/embed
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   height
///   name
///   src
///   type
///   width
pub fn embed(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .embed,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-datalist-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/datalist
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn datalist(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .datalist,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-html-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/html
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   version
///   xmlns
pub fn html(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .html,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdo-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/bdo
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn bdo(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .bdo,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-optgroup-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/optgroup
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   disabled
///   label
pub fn optgroup(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .optgroup,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-section-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/section
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn section(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .section,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-thead-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/thead
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   bgcolor
///   char
///   charoff
///   valign
pub fn thead(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .thead,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-p-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/p
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn p(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .p,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#acronym
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/acronym
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn acronym(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .acronym,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rp-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rp
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn rp(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .rp,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/scripting.html#the-script-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   async
///   attributionsrc
///   blocking
///   crossorigin
///   defer
///   fetchpriority
///   integrity
///   nomodule
///   referrerpolicy
///   src
///   type
pub fn script(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .script,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-em-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/em
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn em(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .em,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-main-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/main
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn main(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .main,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-a-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   attributionsourceid
///   attributionsrc
///   charset
///   coords
///   download
///   href
///   hreflang
///   hreftranslate
///   implicit_noopener
///   name
///   ping
///   referrerpolicy
///   rel
///   rev
///   shape
///   target
///   text_fragments
///   type
pub fn a(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .a,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/scripting.html#the-template-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   shadowrootclonable
///   shadowrootdelegatesfocus
///   shadowrootmode
///   shadowrootserializable
pub fn template(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .template,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-code-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/code
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn code(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .code,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#font
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/font
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
///   color
///   face
///   size
pub fn font(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .font,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/media.html#the-video-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   aspect_ratio_computed_from_attributes
///   autoplay
///   controls
///   controlslist
///   crossorigin
///   disablepictureinpicture
///   disableremoteplayback
///   height
///   loop
///   muted
///   playsinline
///   poster
///   preload
///   src
///   width
pub fn video(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .video,
        .attributes = attributes,
        .children = children,
    };
}

/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/selectedcontent
/// status: experimental
///
/// Allowed attributes:
///   Global attributes
pub fn selectedcontent(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .selectedcontent,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-u-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/u
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn u(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .u,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/canvas.html#the-canvas-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/canvas
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   height
///   moz-opaque
///   width
pub fn canvas(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .canvas,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#rtc
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rtc
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn rtc(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .rtc,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/rendering.html#the-marquee-element-2
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/marquee
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
///   behavior
///   bgcolor
///   direction
///   height
///   hspace
///   loop
///   scrollamount
///   scrolldelay
///   truespeed
///   vspace
///   width
pub fn marquee(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .marquee,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-i-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/i
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn i(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .i,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-ruby-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ruby
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn ruby(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .ruby,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn h4(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .h4,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-time-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/time
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   datetime
pub fn time(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .time,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/media.html#the-audio-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/audio
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   autoplay
///   controls
///   controlslist
///   crossorigin
///   disableremoteplayback
///   loop
///   muted
///   preload
///   src
pub fn audio(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .audio,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-fieldset-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/fieldset
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   disabled
///   form
///   name
pub fn fieldset(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .fieldset,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-br-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/br
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   clear
pub fn br(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .br,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#frameset
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/frameset
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
///   cols
///   rows
pub fn frameset(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .frameset,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#dir
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dir
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
///   compact
pub fn dir(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .dir,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-table-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/table
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   bgcolor
///   border
///   cellpadding
///   cellspacing
///   frame
///   rules
///   summary
///   width
pub fn table(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .table,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/edits.html#the-ins-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ins
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   cite
///   datetime
pub fn ins(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .ins,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-img-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   alt
///   aspect_ratio_computed_from_attributes
///   attributionsrc
///   border
///   crossorigin
///   decoding
///   fetchpriority
///   height
///   hspace
///   ismap
///   loading
///   longdesc
///   name
///   referrerpolicy
///   sizes
///   src
///   srcset
///   usemap
///   vspace
///   width
pub fn img(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .img,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-nav-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/nav
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn nav(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .nav,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-tfoot-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tfoot
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   bgcolor
///   char
///   charoff
///   valign
pub fn tfoot(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .tfoot,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/scripting.html#the-noscript-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/noscript
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn noscript(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .noscript,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-picture-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/picture
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn picture(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .picture,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#strike
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/strike
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn strike(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .strike,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dl-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dl
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn dl(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .dl,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-sub-and-sup-elements
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/sup
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn sup(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .sup,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-details-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/details
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   name
///   open
pub fn details(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .details,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-search-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/search
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn search(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .search,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#tt
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tt
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn tt(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .tt,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-dialog-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dialog
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   closedby
///   open
pub fn dialog(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .dialog,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-sub-and-sup-elements
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/sub
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn sub(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .sub,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-strong-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/strong
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn strong(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .strong,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-samp-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/samp
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn samp(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .samp,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-address-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/address
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn address(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .address,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#xmp
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/xmp
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn xmp(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .xmp,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-s-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/s
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn s(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .s,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#plaintext
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/plaintext
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn plaintext(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .plaintext,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-body-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/body
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   alink
///   background
///   bgcolor
///   bottommargin
///   leftmargin
///   link
///   rightmargin
///   text
///   topmargin
///   vlink
pub fn body(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .body,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-progress-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/progress
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   max
///   value
pub fn progress(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .progress,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-colgroup-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/colgroup
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   char
///   charoff
///   span
///   valign
///   width
pub fn colgroup(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .colgroup,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-title-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/title
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn title(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .title,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/image-maps.html#the-area-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/area
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   alt
///   attributionsrc
///   coords
///   download
///   href
///   implicit_noopener
///   nohref
///   ping
///   referrerpolicy
///   rel
///   shape
///   target
pub fn area(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .area,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-style-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/style
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   blocking
///   media
///   type
pub fn style(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .style,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dt-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dt
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn dt(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .dt,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-small-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/small
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn small(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .small,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-caption-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/caption
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
pub fn caption(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .caption,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/forms.html#the-form-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/form
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   accept-charset
///   action
///   autocomplete
///   enctype
///   method
///   name
///   novalidate
///   rel
///   target
pub fn form(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .form,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-wbr-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/wbr
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn wbr(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .wbr,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/edits.html#the-del-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/del
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   cite
///   datetime
pub fn del(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .del,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-link-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/link
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   as
///   blocking
///   charset
///   crossorigin
///   disabled
///   fetchpriority
///   href
///   hreflang
///   imagesizes
///   imagesrcset
///   integrity
///   media
///   referrerpolicy
///   rel
///   rev
///   sizes
///   target
///   type
pub fn link(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .link,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-blockquote-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/blockquote
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   cite
pub fn blockquote(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .blockquote,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-abbr-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/abbr
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn abbr(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .abbr,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-q-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/q
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   cite
pub fn q(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .q,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-div-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/div
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
pub fn div(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .div,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-summary-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/summary
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   display_list_item
pub fn summary(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .summary,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-textarea-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/textarea
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   autocomplete
///   cols
///   dirname
///   disabled
///   form
///   maxlength
///   minlength
///   name
///   placeholder
///   readonly
///   required
///   rows
///   wrap
pub fn textarea(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .textarea,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-head-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/head
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn head(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .head,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-article-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/article
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn article(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .article,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-pre-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/pre
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   width
pub fn pre(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .pre,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-b-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/b
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn b(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .b,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-hr-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/hr
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   color
///   hr_in_select
///   noshade
///   size
///   width
pub fn hr(attributes: []const Attribute) HtmlNode {
    return .{
        .tag = .hr,
        .attributes = attributes,
        .children = &.{},
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-ol-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ol
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   compact
///   reversed
///   start
///   type
pub fn ol(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .ol,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#frame
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/frame
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
///   frameborder
///   marginheight
///   marginwidth
///   name
///   noresize
///   scrolling
///   src
pub fn frame(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .frame,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#noembed
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/noembed
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn noembed(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .noembed,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-mark-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/mark
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn mark(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .mark,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-li-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/li
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   type
///   value
pub fn li(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .li,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn h5(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .h5,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-figcaption-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/figcaption
/// status: standard
///
/// Allowed attributes:
///   Global attributes
pub fn figcaption(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .figcaption,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/obsolete.html#noframes
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/noframes
/// status: deprecated
///
/// Allowed attributes:
///   Global attributes
pub fn noframes(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .noframes,
        .attributes = attributes,
        .children = children,
    };
}

/// spec: https://html.spec.whatwg.org/multipage/tables.html#the-tbody-element
/// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tbody
/// status: standard
///
/// Allowed attributes:
///   Global attributes
///   align
///   bgcolor
///   char
///   charoff
///   valign
pub fn tbody(attributes: []const Attribute, children: []const HtmlNode) HtmlNode {
    return .{
        .tag = .tbody,
        .attributes = attributes,
        .children = children,
    };
}

// @GENERATED SECTION END

test "sanity" {
    const tree: HtmlNode = .body(&.{}, &.{
        .h1(&.{ .{ .id = "foo" }, .{ .class = "bar" } }, &.{
            .p(&.{}, &.{}),
            .input(&.{.{ .list = "nya" }}, &.{}),
        }),
    });
    _ = tree;

    // const gpa = std.testing.allocator;
    //
    // var arr: std.ArrayList(u8) = .init(gpa);
    // defer arr.deinit();
    //
    // try tree.render(&arr);
    //
    // std.debug.print("{s}\n", .{arr.items});
}

const std = @import("std");
const html_data = @import("html_data.zig");

const Attribute = html_data.Attribute;
const ElementTag = html_data.ElementTag;
const Allocator = std.mem.Allocator;
