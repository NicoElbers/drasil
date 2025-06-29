const Manager = @import("Manager.zig");
const Callback = Manager.Callback;

// @GENERATED SECTION START

// generated - *DO NOT EDIT MANUALLY*

pub const Attribute = union(enum) {
    /// Event:
    /// spec: https://html.spec.whatwg.org/multipage/webappapis.html#event-handlers-on-elements,-document-objects,-and-window-objects
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/accesskey
    /// status: standard
    onclick: Callback.Index,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#the-accesskey-attribute
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/accesskey
    /// status: standard
    accesskey: []const u8,

    /// Global attribute:
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/anchor
    /// status: experimental
    anchor: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-autocapitalize
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/autocapitalize
    /// status: standard
    autocapitalize: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-autocorrect
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/autocorrect
    /// status: standard
    autocorrect: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#dom-fe-autofocus
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/autofocus
    /// status: standard
    autofocus: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#global-attributes:classes-2
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/class
    /// status: standard
    class: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-contenteditable
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/contenteditable
    /// status: standard
    contenteditable: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#attr-data-*
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/data-*
    /// status: standard
    data_attributes: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#the-dir-attribute
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/dir
    /// status: standard
    dir: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dnd.html#the-draggable-attribute
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/draggable
    /// status: standard
    draggable: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-enterkeyhint
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/enterkeyhint
    /// status: standard
    enterkeyhint: []const u8,

    /// Global attribute:
    /// spec: https://drafts.csswg.org/css-shadow-parts/#element-attrdef-html-global-exportparts
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/exportparts
    /// status: standard
    exportparts: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#the-hidden-attribute
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/hidden
    /// status: standard
    hidden: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#global-attributes:the-id-attribute-2
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/id
    /// status: standard
    id: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#the-inert-attribute
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/inert
    /// status: standard
    inert: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-inputmode
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/inputmode
    /// status: standard
    inputmode: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/custom-elements.html#attr-is
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/is
    /// status: standard
    is: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#attr-lang
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/lang
    /// status: standard
    lang: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/urls-and-fetching.html#attr-nonce
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/nonce
    /// status: standard
    nonce: []const u8,

    /// Global attribute:
    /// spec: https://drafts.csswg.org/css-shadow-parts/#part-attr
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/part
    /// status: standard
    part: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/popover.html#the-popover-attribute
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/popover
    /// status: standard
    popover: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#attr-slot
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/slot
    /// status: standard
    slot: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-spellcheck
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/spellcheck
    /// status: standard
    spellcheck: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#the-style-attribute
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/style
    /// status: standard
    style: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-tabindex
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/tabindex
    /// status: standard
    tabindex: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#the-title-attribute
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/title
    /// status: standard
    title: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/dom.html#attr-translate
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/translate
    /// status: standard
    translate: []const u8,

    /// Global attribute:
    /// spec: https://w3c.github.io/virtual-keyboard/#dom-elementcontenteditable-virtualkeyboardpolicy
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/virtualkeyboardpolicy
    /// status: experimental
    virtualkeyboardpolicy: []const u8,

    /// Global attribute:
    /// spec: https://html.spec.whatwg.org/multipage/interaction.html#writing-suggestions
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/writingsuggestions
    /// status: standard
    writingsuggestions: []const u8,

    /// td:
    /// status: deprecated
    ///
    /// th:
    /// status: standard
    abbr: []const u8,

    /// td:
    /// status: deprecated
    ///
    /// col:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-align
    /// status: deprecated
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-input-align
    /// status: deprecated
    ///
    /// th:
    /// status: deprecated
    ///
    /// legend:
    /// status: deprecated
    ///
    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-iframe-align
    /// status: deprecated
    ///
    /// tr:
    /// status: deprecated
    ///
    /// embed:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-embed-align
    /// status: deprecated
    ///
    /// thead:
    /// status: deprecated
    ///
    /// table:
    /// status: deprecated
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-img-align
    /// status: deprecated
    ///
    /// tfoot:
    /// status: deprecated
    ///
    /// colgroup:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-align
    /// status: deprecated
    ///
    /// caption:
    /// status: deprecated
    ///
    /// div:
    /// status: deprecated
    ///
    /// hr:
    /// status: deprecated
    ///
    /// tbody:
    /// status: deprecated
    @"align": []const u8,

    /// td:
    /// status: deprecated
    ///
    /// th:
    /// status: deprecated
    axis: []const u8,

    /// td:
    /// status: deprecated
    ///
    /// th:
    /// status: deprecated
    ///
    /// tr:
    /// status: deprecated
    ///
    /// thead:
    /// status: deprecated
    ///
    /// marquee:
    /// status: deprecated
    ///
    /// table:
    /// status: deprecated
    ///
    /// tfoot:
    /// status: deprecated
    ///
    /// body:
    /// status: deprecated
    ///
    /// tbody:
    /// status: deprecated
    bgcolor: []const u8,

    /// td:
    /// status: deprecated
    ///
    /// col:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-char
    /// status: deprecated
    ///
    /// th:
    /// status: deprecated
    ///
    /// tr:
    /// status: deprecated
    ///
    /// thead:
    /// status: deprecated
    ///
    /// tfoot:
    /// status: deprecated
    ///
    /// colgroup:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-char
    /// status: deprecated
    ///
    /// tbody:
    /// status: deprecated
    char: []const u8,

    /// td:
    /// status: deprecated
    ///
    /// col:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-charoff
    /// status: deprecated
    ///
    /// th:
    /// status: deprecated
    ///
    /// tr:
    /// status: deprecated
    ///
    /// thead:
    /// status: deprecated
    ///
    /// tfoot:
    /// status: deprecated
    ///
    /// colgroup:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-charoff
    /// status: deprecated
    ///
    /// tbody:
    /// status: deprecated
    charoff: []const u8,

    /// td:
    /// status: standard
    ///
    /// th:
    /// status: standard
    colspan: []const u8,

    /// td:
    /// status: standard
    ///
    /// th:
    /// status: standard
    headers: []const u8,

    /// td:
    /// status: standard
    ///
    /// th:
    /// status: standard
    rowspan: []const u8,

    /// td:
    /// status: deprecated
    ///
    /// th:
    /// status: standard
    scope: []const u8,

    /// td:
    /// status: deprecated
    ///
    /// col:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-valign
    /// status: deprecated
    ///
    /// th:
    /// status: deprecated
    ///
    /// tr:
    /// status: deprecated
    ///
    /// thead:
    /// status: deprecated
    ///
    /// tfoot:
    /// status: deprecated
    ///
    /// colgroup:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-valign
    /// status: deprecated
    ///
    /// tbody:
    /// status: deprecated
    valign: []const u8,

    /// td:
    /// status: deprecated
    ///
    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-width
    /// status: standard
    ///
    /// col:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-width
    /// status: deprecated
    ///
    /// fencedframe:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-width
    /// status: experimental
    ///
    /// th:
    /// status: deprecated
    ///
    /// source:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-width
    /// status: standard
    ///
    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-width
    /// status: standard
    ///
    /// embed:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-width
    /// status: standard
    ///
    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-width
    /// status: standard
    ///
    /// canvas:
    /// spec: https://html.spec.whatwg.org/multipage/canvas.html#attr-canvas-width
    /// status: standard
    ///
    /// marquee:
    /// status: deprecated
    ///
    /// table:
    /// status: deprecated
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-width
    /// status: standard
    ///
    /// colgroup:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-col-width
    /// status: deprecated
    ///
    /// pre:
    /// status: deprecated
    ///
    /// hr:
    /// status: deprecated
    width: []const u8,

    /// meter:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-high
    /// status: standard
    high: []const u8,

    /// meter:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-low
    /// status: standard
    low: []const u8,

    /// meter:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-max
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/max
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-max
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/max
    /// status: standard
    ///
    /// progress:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-progress-max
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/max
    /// status: standard
    max: []const u8,

    /// meter:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-max
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/min
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-min
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/min
    /// status: standard
    min: []const u8,

    /// meter:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-optimum
    /// status: standard
    optimum: []const u8,

    /// meter:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-value
    /// status: standard
    ///
    /// data:
    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#attr-data-value
    /// status: standard
    ///
    /// option:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-option-value
    /// status: standard
    ///
    /// button:
    /// status: standard
    ///
    /// param:
    /// status: deprecated
    ///
    /// progress:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-progress-value
    /// status: standard
    ///
    /// li:
    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#attr-li-value
    /// status: standard
    value: []const u8,

    /// select:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-autocomplete
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/select#autocomplete
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-autocomplete
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/autocomplete
    /// status: standard
    ///
    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/forms.html#attr-form-autocomplete
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/autocomplete
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-autocomplete
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/autocomplete
    /// status: standard
    autocomplete: []const u8,

    /// select:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-disabled
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled
    /// status: standard
    ///
    /// option:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-option-disabled
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled
    /// status: standard
    ///
    /// button:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-disabled
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-disabled
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled
    /// status: standard
    ///
    /// optgroup:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-optgroup-disabled
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled
    /// status: standard
    ///
    /// fieldset:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-disabled
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-disabled
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-disabled
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled
    /// status: standard
    disabled: []const u8,

    /// select:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fae-form
    /// status: standard
    ///
    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fae-form
    /// status: standard
    ///
    /// button:
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fae-form
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#form
    /// status: standard
    ///
    /// output:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fae-form
    /// status: standard
    ///
    /// fieldset:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fae-form
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fae-form
    /// status: standard
    form: []const u8,

    /// select:
    /// status: standard
    ///
    /// hr:
    /// status: standard
    hr_in_select: []const u8,

    /// select:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-select-multiple
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/multiple
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-multiple
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/multiple
    /// status: standard
    multiple: []const u8,

    /// select:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-name
    /// status: standard
    ///
    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-object-name
    /// status: standard
    ///
    /// slot:
    /// status: standard
    ///
    /// map:
    /// status: standard
    ///
    /// button:
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-name
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#name
    /// status: standard
    ///
    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-name
    /// status: standard
    ///
    /// output:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-name
    /// status: standard
    ///
    /// meta:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#standard-metadata-names
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta/name
    /// status: standard
    ///
    /// param:
    /// status: deprecated
    ///
    /// embed:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-embed-name
    /// status: deprecated
    ///
    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-a-name
    /// status: deprecated
    ///
    /// fieldset:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-name
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-img-name
    /// status: deprecated
    ///
    /// details:
    /// status: standard
    ///
    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/forms.html#attr-form-name
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-name
    /// status: standard
    ///
    /// frame:
    /// status: deprecated
    name: []const u8,

    /// select:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-select-required
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/required
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-required
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#required
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-required
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/required
    /// status: standard
    required: []const u8,

    /// select:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-select-size
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/size
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-size
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/size
    /// status: standard
    ///
    /// font:
    /// status: deprecated
    ///
    /// hr:
    /// status: deprecated
    size: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-object-archive
    /// status: deprecated
    archive: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-object-border
    /// status: deprecated
    ///
    /// table:
    /// status: deprecated
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-img-border
    /// status: deprecated
    border: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-object-classid
    /// status: deprecated
    classid: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-object-codebase
    /// status: deprecated
    codebase: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-object-codetype
    /// status: deprecated
    codetype: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-object-data
    /// status: standard
    data: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-object-declare
    /// status: deprecated
    declare: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-height
    /// status: standard
    ///
    /// fencedframe:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-height
    /// status: experimental
    ///
    /// source:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-height
    /// status: standard
    ///
    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-height
    /// status: standard
    ///
    /// embed:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-height
    /// status: standard
    ///
    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-height
    /// status: standard
    ///
    /// canvas:
    /// spec: https://html.spec.whatwg.org/multipage/canvas.html#attr-canvas-height
    /// status: standard
    ///
    /// marquee:
    /// status: deprecated
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-height
    /// status: standard
    height: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-object-standby
    /// status: deprecated
    standby: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-object-type
    /// status: standard
    ///
    /// button:
    /// status: standard
    ///
    /// ul:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-ul-type
    /// status: deprecated
    ///
    /// source:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-source-type
    /// status: standard
    ///
    /// param:
    /// status: deprecated
    ///
    /// embed:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-embed-type
    /// status: standard
    ///
    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-type
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script/type
    /// status: standard
    ///
    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-type
    /// status: standard
    ///
    /// style:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-style-type
    /// status: deprecated
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-type
    /// status: standard
    ///
    /// ol:
    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#attr-ol-type
    /// status: standard
    ///
    /// li:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-li-type
    /// status: deprecated
    type: []const u8,

    /// object:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-object-usemap
    /// status: deprecated
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-input-usemap
    /// status: deprecated
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/image-maps.html#attr-hyperlink-usemap
    /// status: standard
    usemap: []const u8,

    /// col:
    /// spec: https://html.spec.whatwg.org/multipage/tables.html#attr-col-span
    /// status: standard
    ///
    /// colgroup:
    /// spec: https://html.spec.whatwg.org/multipage/tables.html#attr-colgroup-span
    /// status: standard
    span: []const u8,

    /// h1:
    /// spec: https://html.spec.whatwg.org/multipage/rendering.html#sections-and-headings
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements#specifying_a_uniform_font_size_for_h1
    /// status: standard
    no_ua_styles_in_article_aside_nav_section: []const u8,

    /// option:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-option-label
    /// status: standard
    ///
    /// track:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-track-label
    /// status: standard
    ///
    /// optgroup:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-optgroup-label
    /// status: standard
    label: []const u8,

    /// option:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-option-selected
    /// status: standard
    selected: []const u8,

    /// fencedframe:
    /// spec: https://wicg.github.io/fenced-frame/#element-attrdef-fencedframe-allow
    /// status: experimental
    ///
    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-allow
    /// status: standard
    allow: []const u8,

    /// button:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-button-command
    /// status: standard
    command: []const u8,

    /// button:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-button-commandfor
    /// status: standard
    commandfor: []const u8,

    /// button:
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formaction
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formaction
    /// status: standard
    formaction: []const u8,

    /// button:
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formenctype
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formenctype
    /// status: standard
    formenctype: []const u8,

    /// button:
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formmethod
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formmethod
    /// status: standard
    formmethod: []const u8,

    /// button:
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formnovalidate
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formnovalidate
    /// status: standard
    formnovalidate: []const u8,

    /// button:
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formtarget
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formtarget
    /// status: standard
    formtarget: []const u8,

    /// button:
    /// spec: https://html.spec.whatwg.org/multipage/popover.html#attr-popovertarget
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#popovertarget
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/popover.html#attr-popovertarget
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#popovertarget
    /// status: standard
    popovertarget: []const u8,

    /// button:
    /// spec: https://html.spec.whatwg.org/multipage/popover.html#attr-popovertargetaction
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#popovertargetaction
    /// status: standard
    ///
    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/popover.html#attr-popovertargetaction
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#popovertargetaction
    /// status: standard
    popovertargetaction: []const u8,

    /// ul:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-ul-compact
    /// status: deprecated
    ///
    /// dir:
    /// status: deprecated
    ///
    /// ol:
    /// status: deprecated
    compact: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-accept
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/accept
    /// status: standard
    accept: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-alpha
    /// status: experimental
    alpha: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-alt
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#alt
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-alt
    /// status: standard
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/image-maps.html#attr-area-alt
    /// status: standard
    alt: []const u8,

    /// input:
    /// spec: https://w3c.github.io/html-media-capture/#dfn-capture
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/capture
    /// status: standard
    capture: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-checked
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#checked
    /// status: standard
    checked: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-colorspace
    /// status: experimental
    colorspace: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-dirname
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#dirname
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-dirname
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/dirname
    /// status: standard
    dirname: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-list
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#list
    /// status: standard
    list: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-maxlength
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/maxlength
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-maxlength
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/maxlength
    /// status: standard
    maxlength: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-minlength
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/minlength
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-minlength
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/minlength
    /// status: standard
    minlength: []const u8,

    /// input:
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#non-standard_attributes
    /// status: deprecated
    mozactionhint: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-pattern
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/pattern
    /// status: standard
    pattern: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-placeholder
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#placeholder
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-placeholder
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/placeholder
    /// status: standard
    placeholder: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-readonly
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/readonly
    /// status: standard
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-readonly
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/readonly
    /// status: standard
    readonly: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-src
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#src
    /// status: standard
    ///
    /// source:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-source-src
    /// status: standard
    ///
    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-src
    /// status: standard
    ///
    /// track:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-track-src
    /// status: standard
    ///
    /// embed:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-embed-src
    /// status: standard
    ///
    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-src
    /// status: standard
    ///
    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-src
    /// status: standard
    ///
    /// audio:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-src
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-src
    /// status: standard
    ///
    /// frame:
    /// status: deprecated
    src: []const u8,

    /// input:
    /// spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-step
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/step
    /// status: standard
    step: []const u8,

    /// input:
    /// status: unknown
    webkitdirectory: []const u8,

    /// source:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-source-media
    /// status: standard
    ///
    /// style:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-style-media
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-media
    /// status: standard
    media: []const u8,

    /// source:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-source-sizes
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-sizes
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-sizes
    /// status: standard
    sizes: []const u8,

    /// source:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-source-srcset
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-srcset
    /// status: standard
    srcset: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-allowfullscreen
    /// status: standard
    allowfullscreen: []const u8,

    /// iframe:
    /// status: deprecated
    allowpaymentrequest: []const u8,

    /// iframe:
    /// status: experimental
    browsingtopics: []const u8,

    /// iframe:
    /// spec: https://wicg.github.io/anonymous-iframe/#attr-iframe-credentialless
    /// mdn: https://developer.mozilla.org/docs/Web/Security/IFrame_credentialless
    /// status: experimental
    credentialless: []const u8,

    /// iframe:
    /// spec: https://w3c.github.io/webappsec-cspee/#element-attrdef-iframe-csp
    /// status: experimental
    csp: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-iframe-frameborder
    /// status: deprecated
    ///
    /// frame:
    /// status: deprecated
    frameborder: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-loading
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-loading
    /// status: standard
    loading: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-iframe-longdesc
    /// status: deprecated
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-img-longdesc
    /// status: deprecated
    longdesc: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-iframe-marginheight
    /// status: deprecated
    ///
    /// frame:
    /// status: deprecated
    marginheight: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-iframe-marginwidth
    /// status: deprecated
    ///
    /// frame:
    /// status: deprecated
    marginwidth: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-referrerpolicy
    /// status: standard
    ///
    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-referrerpolicy
    /// status: standard
    ///
    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-referrerpolicy
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-referrerpolicy
    /// status: standard
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-referrerpolicy
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-referrerpolicy
    /// status: standard
    referrerpolicy: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-sandbox
    /// status: standard
    sandbox: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-iframe-scrolling
    /// status: deprecated
    ///
    /// frame:
    /// status: deprecated
    scrolling: []const u8,

    /// iframe:
    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-srcdoc
    /// status: standard
    srcdoc: []const u8,

    /// output:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-output-for
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/for
    /// status: standard
    ///
    /// label:
    /// spec: https://html.spec.whatwg.org/multipage/forms.html#attr-label-for
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/for
    /// status: standard
    @"for": []const u8,

    /// meta:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-charset
    /// status: standard
    ///
    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-a-charset
    /// status: deprecated
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-link-charset
    /// status: deprecated
    charset: []const u8,

    /// meta:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-content
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/content
    /// status: standard
    content: []const u8,

    /// meta:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-http-equiv
    /// status: standard
    @"http-equiv": []const u8,

    /// meta:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-meta-scheme
    /// status: deprecated
    scheme: []const u8,

    /// param:
    /// status: deprecated
    valuetype: []const u8,

    /// track:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-track-default
    /// status: standard
    default: []const u8,

    /// track:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-track-kind
    /// status: standard
    kind: []const u8,

    /// track:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-track-srclang
    /// status: standard
    srclang: []const u8,

    /// base:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-base-href
    /// status: standard
    ///
    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-href
    /// status: standard
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-href
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-href
    /// status: standard
    href: []const u8,

    /// base:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-base-target
    /// status: standard
    ///
    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-target
    /// status: standard
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-target
    /// status: standard
    ///
    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-target
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-link-target
    /// status: deprecated
    target: []const u8,

    /// html:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-html-version
    /// status: deprecated
    version: []const u8,

    /// html:
    /// status: standard
    xmlns: []const u8,

    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-async
    /// status: standard
    @"async": []const u8,

    /// script:
    /// spec: https://wicg.github.io/attribution-reporting-api/#element-attrdef-script-attributionsrc
    /// status: experimental
    ///
    /// a:
    /// spec: https://wicg.github.io/attribution-reporting-api/#element-attrdef-a-attributionsrc
    /// status: experimental
    ///
    /// img:
    /// spec: https://wicg.github.io/attribution-reporting-api/#element-attrdef-img-attributionsrc
    /// status: experimental
    ///
    /// area:
    /// spec: https://wicg.github.io/attribution-reporting-api/#element-attrdef-area-attributionsrc
    /// status: experimental
    attributionsrc: []const u8,

    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-blocking
    /// status: standard
    ///
    /// style:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-style-blocking
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-blocking
    /// status: standard
    blocking: []const u8,

    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-crossorigin
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/crossorigin
    /// status: standard
    ///
    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-crossorigin
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/crossorigin
    /// status: standard
    ///
    /// audio:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-crossorigin
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/crossorigin
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-crossorigin
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/crossorigin
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-crossorigin
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/crossorigin
    /// status: standard
    crossorigin: []const u8,

    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-defer
    /// status: standard
    @"defer": []const u8,

    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-fetchpriority
    /// status: standard
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-fetchpriority
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-fetchpriority
    /// status: standard
    fetchpriority: []const u8,

    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-integrity
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-integrity
    /// mdn: https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity
    /// status: standard
    integrity: []const u8,

    /// script:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-nomodule
    /// status: standard
    nomodule: []const u8,

    /// a:
    /// spec: https://privacycg.github.io/private-click-measurement/#dom-htmlanchorelement-attributionsourceid
    /// status: experimental
    attributionsourceid: []const u8,

    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-a-coords
    /// status: deprecated
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/image-maps.html#attr-area-coords
    /// status: standard
    coords: []const u8,

    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-download
    /// status: standard
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-download
    /// status: standard
    download: []const u8,

    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-hreflang
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-hreflang
    /// status: standard
    hreflang: []const u8,

    /// a:
    /// status: experimental
    hreftranslate: []const u8,

    /// a:
    /// status: standard
    ///
    /// area:
    /// status: standard
    implicit_noopener: []const u8,

    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#ping
    /// status: standard
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#ping
    /// status: standard
    ping: []const u8,

    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-rel
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/rel
    /// status: standard
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-rel
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/rel
    /// status: standard
    ///
    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/forms.html#attr-form-rel
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/rel
    /// status: standard
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/links.html#linkTypes
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/rel
    /// status: standard
    rel: []const u8,

    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-a-rev
    /// status: deprecated
    ///
    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-link-rev
    /// status: deprecated
    rev: []const u8,

    /// a:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-a-shape
    /// status: deprecated
    ///
    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/image-maps.html#attr-area-shape
    /// status: standard
    shape: []const u8,

    /// a:
    /// status: standard
    text_fragments: []const u8,

    /// template:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-template-shadowrootclonable
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template#shadowrootclonable
    /// status: standard
    shadowrootclonable: []const u8,

    /// template:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-template-shadowrootdelegatesfocus
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template#shadowrootdelegatesfocus
    /// status: standard
    shadowrootdelegatesfocus: []const u8,

    /// template:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-template-shadowrootmode
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template#shadowrootmode
    /// status: standard
    shadowrootmode: []const u8,

    /// template:
    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-template-shadowrootserializable
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template#shadowrootserializable
    /// status: experimental
    shadowrootserializable: []const u8,

    /// font:
    /// status: deprecated
    ///
    /// hr:
    /// status: deprecated
    color: []const u8,

    /// font:
    /// status: deprecated
    face: []const u8,

    /// video:
    /// status: standard
    ///
    /// img:
    /// status: standard
    aspect_ratio_computed_from_attributes: []const u8,

    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-autoplay
    /// status: standard
    ///
    /// audio:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-autoplay
    /// status: standard
    autoplay: []const u8,

    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-controls
    /// status: standard
    ///
    /// audio:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-controls
    /// status: standard
    controls: []const u8,

    /// video:
    /// spec: https://wicg.github.io/controls-list/#solution-outline
    /// status: standard
    ///
    /// audio:
    /// spec: https://wicg.github.io/controls-list/#solution-outline
    /// status: standard
    controlslist: []const u8,

    /// video:
    /// spec: https://w3c.github.io/picture-in-picture/#dom-htmlvideoelement-disablepictureinpicture
    /// status: standard
    disablepictureinpicture: []const u8,

    /// video:
    /// spec: https://w3c.github.io/remote-playback/#the-disableremoteplayback-attribute
    /// status: standard
    ///
    /// audio:
    /// spec: https://w3c.github.io/remote-playback/#the-disableremoteplayback-attribute
    /// status: standard
    disableremoteplayback: []const u8,

    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-loop
    /// status: standard
    ///
    /// marquee:
    /// status: deprecated
    ///
    /// audio:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-loop
    /// status: standard
    loop: []const u8,

    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-muted
    /// status: standard
    ///
    /// audio:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-muted
    /// status: standard
    muted: []const u8,

    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-video-playsinline
    /// status: standard
    playsinline: []const u8,

    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-video-poster
    /// status: standard
    poster: []const u8,

    /// video:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-preload
    /// status: standard
    ///
    /// audio:
    /// spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-preload
    /// status: standard
    preload: []const u8,

    /// canvas:
    /// status: deprecated
    @"moz-opaque": []const u8,

    /// marquee:
    /// status: deprecated
    behavior: []const u8,

    /// marquee:
    /// status: deprecated
    direction: []const u8,

    /// marquee:
    /// status: deprecated
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-img-hspace
    /// status: deprecated
    hspace: []const u8,

    /// marquee:
    /// status: deprecated
    scrollamount: []const u8,

    /// marquee:
    /// status: deprecated
    scrolldelay: []const u8,

    /// marquee:
    /// status: deprecated
    truespeed: []const u8,

    /// marquee:
    /// status: deprecated
    ///
    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-img-vspace
    /// status: deprecated
    vspace: []const u8,

    /// time:
    /// status: standard
    ///
    /// ins:
    /// status: standard
    ///
    /// del:
    /// status: standard
    datetime: []const u8,

    /// br:
    /// status: deprecated
    clear: []const u8,

    /// frameset:
    /// status: deprecated
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-cols
    /// status: standard
    cols: []const u8,

    /// frameset:
    /// status: deprecated
    ///
    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-rows
    /// status: standard
    rows: []const u8,

    /// table:
    /// status: deprecated
    cellpadding: []const u8,

    /// table:
    /// status: deprecated
    cellspacing: []const u8,

    /// table:
    /// status: deprecated
    frame: []const u8,

    /// table:
    /// status: deprecated
    rules: []const u8,

    /// table:
    /// status: deprecated
    summary: []const u8,

    /// ins:
    /// status: standard
    ///
    /// del:
    /// status: standard
    ///
    /// blockquote:
    /// status: standard
    ///
    /// q:
    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#attr-q-cite
    /// status: standard
    cite: []const u8,

    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-decoding
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#decoding
    /// status: standard
    decoding: []const u8,

    /// img:
    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-ismap
    /// status: standard
    ismap: []const u8,

    /// details:
    /// status: standard
    ///
    /// dialog:
    /// status: standard
    open: []const u8,

    /// dialog:
    /// spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#attr-dialog-closedby
    /// status: standard
    closedby: []const u8,

    /// body:
    /// status: deprecated
    alink: []const u8,

    /// body:
    /// status: deprecated
    background: []const u8,

    /// body:
    /// status: deprecated
    bottommargin: []const u8,

    /// body:
    /// status: deprecated
    leftmargin: []const u8,

    /// body:
    /// status: deprecated
    link: []const u8,

    /// body:
    /// status: deprecated
    rightmargin: []const u8,

    /// body:
    /// status: deprecated
    text: []const u8,

    /// body:
    /// status: deprecated
    topmargin: []const u8,

    /// body:
    /// status: deprecated
    vlink: []const u8,

    /// area:
    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-area-nohref
    /// status: deprecated
    nohref: []const u8,

    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/forms.html#attr-form-accept-charset
    /// status: standard
    @"accept-charset": []const u8,

    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-action
    /// status: standard
    action: []const u8,

    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-enctype
    /// status: standard
    enctype: []const u8,

    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-method
    /// status: standard
    method: []const u8,

    /// form:
    /// spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-novalidate
    /// status: standard
    novalidate: []const u8,

    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-as
    /// status: standard
    as: []const u8,

    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-imagesizes
    /// status: standard
    imagesizes: []const u8,

    /// link:
    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-imagesrcset
    /// status: standard
    imagesrcset: []const u8,

    /// summary:
    /// status: standard
    display_list_item: []const u8,

    /// textarea:
    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-wrap
    /// status: standard
    wrap: []const u8,

    /// hr:
    /// status: deprecated
    noshade: []const u8,

    /// ol:
    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#attr-ol-reversed
    /// status: standard
    reversed: []const u8,

    /// ol:
    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#attr-ol-start
    /// status: standard
    start: []const u8,

    /// frame:
    /// status: deprecated
    noresize: []const u8,
};
pub const ElementTag = enum {
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
    td,

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
    meter,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-kbd-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/kbd
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    kbd,

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
    select,

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
    object,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-cite-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/cite
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    cite,

    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#the-slot-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/slot
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   name
    slot,

    /// spec: https://html.spec.whatwg.org/multipage/tables.html#the-col-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/col
    /// status: standard
    /// is a void element
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   align
    ///   char
    ///   charoff
    ///   span
    ///   valign
    ///   width
    col,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-hgroup-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/hgroup
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    hgroup,

    /// spec: https://html.spec.whatwg.org/multipage/image-maps.html#the-map-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/map
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   name
    map,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-data-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/data
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   value
    data,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   no_ua_styles_in_article_aside_nav_section
    h1,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    h3,

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
    option,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#rb
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rb
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    rb,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-figure-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/figure
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    figure,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rt-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rt
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    rt,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdi-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/bdi
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    bdi,

    /// spec: https://wicg.github.io/fenced-frame/#the-fencedframe-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/fencedframe
    /// status: experimental
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   allow
    ///   height
    ///   width
    fencedframe,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-header-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/header
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    header,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#big
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/big
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    big,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-aside-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/aside
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    aside,

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
    button,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    h2,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-span-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/span
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    span,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-ul-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ul
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   compact
    ///   type
    ul,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#center
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/center
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    center,

    /// spec: https://html.spec.whatwg.org/multipage/input.html#the-input-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input
    /// status: standard
    /// is a void element
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
    input,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-footer-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/footer
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    footer,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#nobr
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/nobr
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    nobr,

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
    th,

    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-source-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/source
    /// status: standard
    /// is a void element
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
    source,

    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-legend-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/legend
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   align
    legend,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dd-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dd
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    dd,

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
    iframe,

    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-output-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/output
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   for
    ///   form
    ///   name
    output,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-var-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/var
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    @"var",

    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-meta-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta
    /// status: standard
    /// is a void element
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   charset
    ///   content
    ///   http-equiv
    ///   name
    ///   scheme
    meta,

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
    tr,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    h6,

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
    param,

    /// spec: https://html.spec.whatwg.org/multipage/forms.html#the-label-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/label
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   for
    label,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-menu-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/menu
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    menu,

    /// spec: https://html.spec.whatwg.org/multipage/media.html#the-track-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/track
    /// status: standard
    /// is a void element
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   default
    ///   kind
    ///   label
    ///   src
    ///   srclang
    track,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-dfn-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dfn
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    dfn,

    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-base-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/base
    /// status: standard
    /// is a void element
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   href
    ///   target
    base,

    /// spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-embed-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/embed
    /// status: standard
    /// is a void element
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   align
    ///   height
    ///   name
    ///   src
    ///   type
    ///   width
    embed,

    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-datalist-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/datalist
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    datalist,

    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-html-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/html
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   version
    ///   xmlns
    html,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdo-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/bdo
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    bdo,

    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-optgroup-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/optgroup
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   disabled
    ///   label
    optgroup,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-section-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/section
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    section,

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
    thead,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-p-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/p
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    p,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#acronym
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/acronym
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    acronym,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rp-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rp
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    rp,

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
    script,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-em-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/em
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    em,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-main-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/main
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    main,

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
    a,

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
    template,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-code-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/code
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    code,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#font
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/font
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   color
    ///   face
    ///   size
    font,

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
    video,

    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/selectedcontent
    /// status: experimental
    ///
    /// Allowed attributes:
    ///   Global attributes
    selectedcontent,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-u-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/u
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    u,

    /// spec: https://html.spec.whatwg.org/multipage/canvas.html#the-canvas-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/canvas
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   height
    ///   moz-opaque
    ///   width
    canvas,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#rtc
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rtc
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    rtc,

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
    marquee,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-i-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/i
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    i,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-ruby-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ruby
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ruby,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    h4,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-time-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/time
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   datetime
    time,

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
    audio,

    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-fieldset-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/fieldset
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   disabled
    ///   form
    ///   name
    fieldset,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-br-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/br
    /// status: standard
    /// is a void element
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   clear
    br,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#frameset
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/frameset
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   cols
    ///   rows
    frameset,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#dir
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dir
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   compact
    dir,

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
    table,

    /// spec: https://html.spec.whatwg.org/multipage/edits.html#the-ins-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ins
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   cite
    ///   datetime
    ins,

    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-img-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img
    /// status: standard
    /// is a void element
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
    img,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-nav-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/nav
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    nav,

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
    tfoot,

    /// spec: https://html.spec.whatwg.org/multipage/scripting.html#the-noscript-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/noscript
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    noscript,

    /// spec: https://html.spec.whatwg.org/multipage/embedded-content.html#the-picture-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/picture
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    picture,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#strike
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/strike
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    strike,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dl-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dl
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    dl,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-sub-and-sup-elements
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/sup
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    sup,

    /// spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-details-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/details
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   name
    ///   open
    details,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-search-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/search
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    search,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#tt
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tt
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    tt,

    /// spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-dialog-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dialog
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   closedby
    ///   open
    dialog,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-sub-and-sup-elements
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/sub
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    sub,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-strong-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/strong
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    strong,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-samp-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/samp
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    samp,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-address-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/address
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    address,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#xmp
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/xmp
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    xmp,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-s-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/s
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    s,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#plaintext
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/plaintext
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    plaintext,

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
    body,

    /// spec: https://html.spec.whatwg.org/multipage/form-elements.html#the-progress-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/progress
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   max
    ///   value
    progress,

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
    colgroup,

    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-title-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/title
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    title,

    /// spec: https://html.spec.whatwg.org/multipage/image-maps.html#the-area-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/area
    /// status: standard
    /// is a void element
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
    area,

    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-style-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/style
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   blocking
    ///   media
    ///   type
    style,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-dt-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dt
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    dt,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-small-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/small
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    small,

    /// spec: https://html.spec.whatwg.org/multipage/tables.html#the-caption-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/caption
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   align
    caption,

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
    form,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-wbr-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/wbr
    /// status: standard
    /// is a void element
    ///
    /// Allowed attributes:
    ///   Global attributes
    wbr,

    /// spec: https://html.spec.whatwg.org/multipage/edits.html#the-del-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/del
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   cite
    ///   datetime
    del,

    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-link-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/link
    /// status: standard
    /// is a void element
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
    link,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-blockquote-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/blockquote
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   cite
    blockquote,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-abbr-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/abbr
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    abbr,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-q-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/q
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   cite
    q,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-div-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/div
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   align
    div,

    /// spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#the-summary-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/summary
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   display_list_item
    summary,

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
    textarea,

    /// spec: https://html.spec.whatwg.org/multipage/semantics.html#the-head-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/head
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    head,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-article-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/article
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    article,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-pre-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/pre
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   width
    pre,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-b-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/b
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    b,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-hr-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/hr
    /// status: standard
    /// is a void element
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   align
    ///   color
    ///   hr_in_select
    ///   noshade
    ///   size
    ///   width
    hr,

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
    ol,

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
    frame,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#noembed
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/noembed
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    noembed,

    /// spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-mark-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/mark
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    mark,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-li-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/li
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    ///   type
    ///   value
    li,

    /// spec: https://html.spec.whatwg.org/multipage/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    h5,

    /// spec: https://html.spec.whatwg.org/multipage/grouping-content.html#the-figcaption-element
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/figcaption
    /// status: standard
    ///
    /// Allowed attributes:
    ///   Global attributes
    figcaption,

    /// spec: https://html.spec.whatwg.org/multipage/obsolete.html#noframes
    /// mdn: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/noframes
    /// status: deprecated
    ///
    /// Allowed attributes:
    ///   Global attributes
    noframes,

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
    tbody,
};

// @GENERATED SECTION END
