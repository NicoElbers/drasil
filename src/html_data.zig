const Manager = @import("Manager.zig");
const Callback = Manager.Callback;

// @GENERATED SECTION START

// generated - *DO NOT EDIT MANUALLY*

pub const Attribute = union(enum) {
    // Events

    /// Event with interface Event
    onDOMContentLoaded: Callback.Index,

    /// Event with interface Event
    onafterprint: Callback.Index,

    /// Event with interface Event
    onbeforematch: Callback.Index,

    /// Event with interface Event
    onbeforeprint: Callback.Index,

    /// Event with interface ToggleEvent
    onbeforetoggle: Callback.Index,

    /// Event with interface BeforeUnloadEvent
    onbeforeunload: Callback.Index,

    /// Event with interface Event
    onblur: Callback.Index,

    /// Event with interface Event
    oncancel: Callback.Index,

    /// Event with interface Event
    onchange: Callback.Index,

    /// Event with interface PointerEvent
    onclick: Callback.Index,

    /// Event with interface Event
    onclose: Callback.Index,

    /// Event with interface CommandEvent
    oncommand: Callback.Index,

    /// Event with interface MessageEvent
    onconnect: Callback.Index,

    /// Event with interface Event
    oncontextlost: Callback.Index,

    /// Event with interface Event
    oncontextrestored: Callback.Index,

    /// Event with interface NavigationCurrentEntryChangeEvent
    oncurrententrychange: Callback.Index,

    /// Event with interface Event
    ondispose: Callback.Index,

    /// Event with interface Event
    onerror: Callback.Index,

    /// Event with interface Event
    onfocus: Callback.Index,

    /// Event with interface FormDataEvent
    onformdata: Callback.Index,

    /// Event with interface HashChangeEvent
    onhashchange: Callback.Index,

    /// Event with interface Event
    oninput: Callback.Index,

    /// Event with interface Event
    oninvalid: Callback.Index,

    /// Event with interface Event
    onlanguagechange: Callback.Index,

    /// Event with interface Event
    onload: Callback.Index,

    /// Event with interface MessageEvent
    onmessage: Callback.Index,

    /// Event with interface MessageEvent
    onmessageerror: Callback.Index,

    /// Event with interface NavigateEvent
    onnavigate: Callback.Index,

    /// Event with interface ErrorEvent
    onnavigateerror: Callback.Index,

    /// Event with interface Event
    onnavigatesuccess: Callback.Index,

    /// Event with interface Event
    onoffline: Callback.Index,

    /// Event with interface Event
    ononline: Callback.Index,

    /// Event with interface Event
    onopen: Callback.Index,

    /// Event with interface PageTransitionEvent
    onpagehide: Callback.Index,

    /// Event with interface PageRevealEvent
    onpagereveal: Callback.Index,

    /// Event with interface PageTransitionEvent
    onpageshow: Callback.Index,

    /// Event with interface PageSwapEvent
    onpageswap: Callback.Index,

    /// Event with interface PointerEvent
    onpointercancel: Callback.Index,

    /// Event with interface PopStateEvent
    onpopstate: Callback.Index,

    /// Event with interface Event
    onreadystatechange: Callback.Index,

    /// Event with interface PromiseRejectionEvent
    onrejectionhandled: Callback.Index,

    /// Event with interface Event
    onreset: Callback.Index,

    /// Event with interface Event
    onselect: Callback.Index,

    /// Event with interface StorageEvent
    onstorage: Callback.Index,

    /// Event with interface SubmitEvent
    onsubmit: Callback.Index,

    /// Event with interface ToggleEvent
    ontoggle: Callback.Index,

    /// Event with interface PromiseRejectionEvent
    onunhandledrejection: Callback.Index,

    /// Event with interface Event
    onunload: Callback.Index,

    /// Event with interface Event
    onvisibilitychange: Callback.Index,

    /// Event with interface Event
    onabort: Callback.Index,

    /// Event with interface Event
    oncanplay: Callback.Index,

    /// Event with interface Event
    oncanplaythrough: Callback.Index,

    /// Event with interface Event
    ondurationchange: Callback.Index,

    /// Event with interface Event
    onemptied: Callback.Index,

    /// Event with interface Event
    onended: Callback.Index,

    /// Event with interface Event
    onloadeddata: Callback.Index,

    /// Event with interface Event
    onloadedmetadata: Callback.Index,

    /// Event with interface Event
    onloadstart: Callback.Index,

    /// Event with interface Event
    onpause: Callback.Index,

    /// Event with interface Event
    onplay: Callback.Index,

    /// Event with interface Event
    onplaying: Callback.Index,

    /// Event with interface Event
    onprogress: Callback.Index,

    /// Event with interface Event
    onratechange: Callback.Index,

    /// Event with interface Event
    onresize: Callback.Index,

    /// Event with interface Event
    onseeked: Callback.Index,

    /// Event with interface Event
    onseeking: Callback.Index,

    /// Event with interface Event
    onstalled: Callback.Index,

    /// Event with interface Event
    onsuspend: Callback.Index,

    /// Event with interface Event
    ontimeupdate: Callback.Index,

    /// Event with interface Event
    onvolumechange: Callback.Index,

    /// Event with interface Event
    onwaiting: Callback.Index,

    /// Event with interface DragEvent
    ondrag: Callback.Index,

    /// Event with interface DragEvent
    ondragend: Callback.Index,

    /// Event with interface DragEvent
    ondragenter: Callback.Index,

    /// Event with interface DragEvent
    ondragleave: Callback.Index,

    /// Event with interface DragEvent
    ondragover: Callback.Index,

    /// Event with interface DragEvent
    ondragstart: Callback.Index,

    /// Event with interface DragEvent
    ondrop: Callback.Index,

    // Attributes

    /// For .th:
    ///
    /// Alternative label to use for the header cell when referencing the cell in other contexts
    ///
    /// status: standard
    abbr: []const u8,

    /// For .input:
    ///
    /// Hint for expected file type in file upload controls
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-accept
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/accept
    /// status: standard
    accept: []const u8,

    /// For .form:
    ///
    /// Character encodings to use for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/forms.html#attr-form-accept-charset
    /// status: standard
    @"accept-charset": []const u8,

    /// Keyboard shortcut to activate or focus element
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#the-accesskey-attribute
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/accesskey
    /// status: standard
    accesskey: []const u8,

    /// For .form:
    ///
    /// URL to use for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-action
    /// status: standard
    action: []const u8,

    /// For .iframe:
    ///
    /// Permissions policy to be applied to the iframe's contents
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-allow
    /// status: standard
    allow: []const u8,

    /// For .iframe:
    ///
    /// Whether to allow the iframe's contents to use requestFullscreen()
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-allowfullscreen
    /// status: standard
    allowfullscreen: []const u8,

    /// For .input:
    ///
    /// Allow the color's alpha component to be set
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-alpha
    /// status: experimental
    alpha: []const u8,

    /// For:
    ///   .area
    ///   .img
    ///   .input
    ///
    /// Replacement text for use when images are not available
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/image-maps.html#attr-area-alt
    /// status: standard
    alt: []const u8,

    /// For .link:
    ///
    /// Potential destination for a preload request (for rel="preload" and rel="modulepreload")
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-as
    /// status: standard
    as: []const u8,

    /// For .script:
    ///
    /// Execute script when available, without blocking while fetching
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-async
    /// status: standard
    @"async": []const u8,

    /// Recommended autocapitalization behavior (for supported input methods)
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-autocapitalize
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/autocapitalize
    /// status: standard
    autocapitalize: []const u8,

    /// For .form:
    ///
    /// Default setting for autofill feature for controls in the form
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/forms.html#attr-form-autocomplete
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/autocomplete
    /// status: standard
    /// For:
    ///   .input
    ///   .select
    ///   .textarea
    ///
    /// Hint for form autofill feature
    ///
    /// status: unknown
    autocomplete: []const u8,

    /// Recommended autocorrection behavior (for supported input methods)
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-autocorrect
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/autocorrect
    /// status: standard
    autocorrect: []const u8,

    /// Automatically focus the element when the page is loaded
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#dom-fe-autofocus
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/autofocus
    /// status: standard
    autofocus: []const u8,

    /// For:
    ///   .audio
    ///   .video
    ///
    /// Hint that the media resource can be started automatically when the page is loaded
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-autoplay
    /// status: standard
    autoplay: []const u8,

    /// For:
    ///   .link
    ///   .script
    ///   .style
    ///
    /// Whether the element is potentially render-blocking
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-blocking
    /// status: standard
    blocking: []const u8,

    /// For .meta:
    ///
    /// Character encoding declaration
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-a-charset
    /// status: deprecated
    charset: []const u8,

    /// For .input:
    ///
    /// Whether the control is checked
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-checked
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#checked
    /// status: standard
    checked: []const u8,

    /// For:
    ///   .blockquote
    ///   .del
    ///   .ins
    ///   .q
    ///
    /// Link to the source of the quotation or more information about the edit
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/text-level-semantics.html#attr-q-cite
    /// status: standard
    cite: []const u8,

    /// For .global:
    ///
    /// Classes to which the element belongs
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/dom.html#global-attributes:classes-2
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/class
    /// status: standard
    class: []const u8,

    /// For .dialog:
    ///
    /// Which user actions will close the dialog
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interactive-elements.html#attr-dialog-closedby
    /// status: standard
    closedby: []const u8,

    /// For .link:
    ///
    /// Color to use when customizing a site's icon (for rel="mask-icon")
    ///
    /// status: unknown
    color: []const u8,

    /// For .input:
    ///
    /// The color space of the serialized color
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-colorspace
    /// status: experimental
    colorspace: []const u8,

    /// For .textarea:
    ///
    /// Maximum number of characters per line
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-cols
    /// status: standard
    cols: []const u8,

    /// For:
    ///   .td
    ///   .th
    ///
    /// Number of columns that the cell is to span
    ///
    /// status: standard
    colspan: []const u8,

    /// For .button:
    ///
    /// Indicates to the targeted element which action to take.
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-button-command
    /// status: standard
    command: []const u8,

    /// For .button:
    ///
    /// Targets another element to be invoked.
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-button-commandfor
    /// status: standard
    commandfor: []const u8,

    /// For .meta:
    ///
    /// Value of the element
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-content
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/content
    /// status: standard
    content: []const u8,

    /// Whether the element is editable
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-contenteditable
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/contenteditable
    /// status: standard
    contenteditable: []const u8,

    /// For:
    ///   .audio
    ///   .video
    ///
    /// Show user agent controls
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-controls
    /// status: standard
    controls: []const u8,

    /// For .area:
    ///
    /// Coordinates for the shape to be created in an image map
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/image-maps.html#attr-area-coords
    /// status: standard
    coords: []const u8,

    /// For:
    ///   .audio
    ///   .img
    ///   .link
    ///   .script
    ///   .video
    ///
    /// How the element handles crossorigin requests
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-crossorigin
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/crossorigin
    /// status: standard
    crossorigin: []const u8,

    /// For .object:
    ///
    /// Address of the resource
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-object-data
    /// status: standard
    data: []const u8,

    /// For:
    ///   .del
    ///   .ins
    ///
    /// Date and (optionally) time of the change
    ///
    /// status: standard
    /// For .time:
    ///
    /// Machine-readable value
    ///
    /// status: unknown
    datetime: []const u8,

    /// For .img:
    ///
    /// Decoding hint to use when processing this image for presentation
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-decoding
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#decoding
    /// status: standard
    decoding: []const u8,

    /// For .track:
    ///
    /// Enable the track if no other text track is more suitable
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-track-default
    /// status: standard
    default: []const u8,

    /// For .script:
    ///
    /// Defer script execution
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-defer
    /// status: standard
    @"defer": []const u8,

    /// The text directionality of the element
    ///
    /// Is a global attribute
    ///
    /// status: unknown
    dir: []const u8,

    /// For:
    ///   .input
    ///   .textarea
    ///
    /// Name of form control to use for sending the element's directionality in form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-dirname
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/dirname
    /// status: standard
    dirname: []const u8,

    /// For:
    ///   .button
    ///   .@"form-associated custom elements"
    ///   .input
    ///   .optgroup
    ///   .option
    ///   .select
    ///   .textarea
    ///
    /// Whether the form control is disabled
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-disabled
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled
    /// status: standard
    /// For .fieldset:
    ///
    /// Whether the descendant form controls, except any inside legend, are disabled
    ///
    /// status: unknown
    /// For .link:
    ///
    /// Whether the link is disabled
    ///
    /// status: unknown
    disabled: []const u8,

    /// For:
    ///   .a
    ///   .area
    ///
    /// Whether to download the resource instead of navigating to it, and its filename if so
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-download
    /// status: standard
    download: []const u8,

    /// Whether the element is draggable
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/dnd.html#the-draggable-attribute
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/draggable
    /// status: standard
    draggable: []const u8,

    /// For .form:
    ///
    /// Entry list encoding type to use for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-enctype
    /// status: standard
    enctype: []const u8,

    /// Hint for selecting an enter key action
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-enterkeyhint
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/enterkeyhint
    /// status: standard
    enterkeyhint: []const u8,

    /// For:
    ///   .img
    ///   .link
    ///   .script
    ///
    /// Sets the priority for fetches initiated by the element
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-fetchpriority
    /// status: standard
    fetchpriority: []const u8,

    /// For .label:
    ///
    /// Associate the label with form control
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/forms.html#attr-label-for
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/for
    /// status: standard
    /// For .output:
    ///
    /// Specifies controls from which the output was calculated
    ///
    /// status: unknown
    @"for": []const u8,

    /// For:
    ///   .button
    ///   .fieldset
    ///   .@"form-associated custom elements"
    ///   .input
    ///   .object
    ///   .output
    ///   .select
    ///   .textarea
    ///
    /// Associates the element with a form element
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fae-form
    /// status: standard
    form: []const u8,

    /// For:
    ///   .button
    ///   .input
    ///
    /// URL to use for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formaction
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formaction
    /// status: standard
    formaction: []const u8,

    /// For:
    ///   .button
    ///   .input
    ///
    /// Entry list encoding type to use for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formenctype
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formenctype
    /// status: standard
    formenctype: []const u8,

    /// For:
    ///   .button
    ///   .input
    ///
    /// Variant to use for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formmethod
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formmethod
    /// status: standard
    formmethod: []const u8,

    /// For:
    ///   .button
    ///   .input
    ///
    /// Bypass form control validation for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formnovalidate
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formnovalidate
    /// status: standard
    formnovalidate: []const u8,

    /// For:
    ///   .button
    ///   .input
    ///
    /// Navigable for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-formtarget
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#formtarget
    /// status: standard
    formtarget: []const u8,

    /// For:
    ///   .td
    ///   .th
    ///
    /// The header cells for this cell
    ///
    /// status: standard
    headers: []const u8,

    /// For:
    ///   .canvas
    ///   .embed
    ///   .iframe
    ///   .img
    ///   .input
    ///   .object
    ///   .@"source (in picture)"
    ///   .video
    ///
    /// Vertical dimension
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-height
    /// status: standard
    height: []const u8,

    /// Whether the element is relevant
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#the-hidden-attribute
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/hidden
    /// status: standard
    hidden: []const u8,

    /// For .meter:
    ///
    /// Low limit of high range
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-high
    /// status: standard
    high: []const u8,

    /// For:
    ///   .a
    ///   .area
    ///
    /// Address of the hyperlink
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-href
    /// status: standard
    /// For .base:
    ///
    /// Document base URL
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-href
    /// status: standard
    /// For .link:
    ///
    /// Address of the hyperlink
    ///
    /// status: unknown
    href: []const u8,

    /// For:
    ///   .a
    ///   .link
    ///
    /// Language of the linked resource
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-hreflang
    /// status: standard
    hreflang: []const u8,

    /// For .meta:
    ///
    /// Pragma directive
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-http-equiv
    /// status: standard
    @"http-equiv": []const u8,

    /// For .global:
    ///
    /// The element's ID
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/dom.html#global-attributes:the-id-attribute-2
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/id
    /// status: standard
    id: []const u8,

    /// For .link:
    ///
    /// Image sizes for different page layouts (for rel="preload")
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-imagesizes
    /// status: standard
    imagesizes: []const u8,

    /// For .link:
    ///
    /// Images to use in different situations, e.g., high-resolution displays, small monitors, etc. (for rel="preload")
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-imagesrcset
    /// status: standard
    imagesrcset: []const u8,

    /// Whether the element is inert.
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#the-inert-attribute
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/inert
    /// status: standard
    inert: []const u8,

    /// Hint for selecting an input modality
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-inputmode
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/inputmode
    /// status: standard
    inputmode: []const u8,

    /// For:
    ///   .link
    ///   .script
    ///
    /// Integrity metadata used in Subresource Integrity checks SRI
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-integrity
    /// MDN: https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity
    /// status: standard
    integrity: []const u8,

    /// Creates a customized built-in element
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/custom-elements.html#attr-is
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/is
    /// status: standard
    is: []const u8,

    /// For .img:
    ///
    /// Whether the image is a server-side image map
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-ismap
    /// status: standard
    ismap: []const u8,

    /// Global identifier for a microdata item
    ///
    /// Is a global attribute
    ///
    /// status: unknown
    itemid: []const u8,

    /// Property names of a microdata item
    ///
    /// Is a global attribute
    ///
    /// status: unknown
    itemprop: []const u8,

    /// Referenced elements
    ///
    /// Is a global attribute
    ///
    /// status: unknown
    itemref: []const u8,

    /// Introduces a microdata item
    ///
    /// Is a global attribute
    ///
    /// status: unknown
    itemscope: []const u8,

    /// Item types of a microdata item
    ///
    /// Is a global attribute
    ///
    /// status: unknown
    itemtype: []const u8,

    /// For .track:
    ///
    /// The type of text track
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-track-kind
    /// status: standard
    kind: []const u8,

    /// For:
    ///   .optgroup
    ///   .option
    ///   .track
    ///
    /// User-visible label
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-optgroup-label
    /// status: standard
    label: []const u8,

    /// Language of the element
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/dom.html#attr-lang
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/lang
    /// status: standard
    lang: []const u8,

    /// For .input:
    ///
    /// List of autocomplete options
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-list
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#list
    /// status: standard
    list: []const u8,

    /// For:
    ///   .iframe
    ///   .img
    ///
    /// Used when determining loading deferral
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-loading
    /// status: standard
    loading: []const u8,

    /// For:
    ///   .audio
    ///   .video
    ///
    /// Whether to loop the media resource
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-loop
    /// status: standard
    loop: []const u8,

    /// For .meter:
    ///
    /// High limit of low range
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-low
    /// status: standard
    low: []const u8,

    /// For .input:
    ///
    /// Maximum value
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-max
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/max
    /// status: standard
    /// For:
    ///   .meter
    ///   .progress
    ///
    /// Upper bound of range
    ///
    /// status: unknown
    max: []const u8,

    /// For:
    ///   .input
    ///   .textarea
    ///
    /// Maximum length of value
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-maxlength
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/maxlength
    /// status: standard
    maxlength: []const u8,

    /// For:
    ///   .link
    ///   .meta
    ///   .source
    ///   .style
    ///
    /// Applicable media
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-media
    /// status: standard
    media: []const u8,

    /// For .form:
    ///
    /// Variant to use for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-method
    /// status: standard
    method: []const u8,

    /// For .input:
    ///
    /// Minimum value
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-min
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/min
    /// status: standard
    /// For .meter:
    ///
    /// Lower bound of range
    ///
    /// status: unknown
    min: []const u8,

    /// For:
    ///   .input
    ///   .textarea
    ///
    /// Minimum length of value
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-minlength
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/minlength
    /// status: standard
    minlength: []const u8,

    /// For:
    ///   .input
    ///   .select
    ///
    /// Whether to allow multiple values
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-multiple
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/multiple
    /// status: standard
    multiple: []const u8,

    /// For:
    ///   .audio
    ///   .video
    ///
    /// Whether to mute the media resource by default
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-muted
    /// status: standard
    muted: []const u8,

    /// For:
    ///   .button
    ///   .fieldset
    ///   .@"form-associated custom elements"
    ///   .input
    ///   .output
    ///   .select
    ///   .textarea
    ///
    /// Name of the element to use for form submission and in the form.elements API
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-name
    /// status: standard
    /// For .details:
    ///
    /// Name of group of mutually-exclusive details elements
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-a-name
    /// status: deprecated
    /// For .form:
    ///
    /// Name of form to use in the document.forms API
    ///
    /// status: unknown
    /// For:
    ///   .iframe
    ///   .object
    ///
    /// Name of content navigable
    ///
    /// status: unknown
    /// For .map:
    ///
    /// Name of image map to reference from the usemap attribute
    ///
    /// status: unknown
    /// For .meta:
    ///
    /// Metadata name
    ///
    /// status: unknown
    /// For .slot:
    ///
    /// Name of shadow tree slot
    ///
    /// status: unknown
    name: []const u8,

    /// For .script:
    ///
    /// Prevents execution in user agents that support module scripts
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-script-nomodule
    /// status: standard
    nomodule: []const u8,

    /// Cryptographic nonce used in Content Security Policy checks CSP
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/urls-and-fetching.html#attr-nonce
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/nonce
    /// status: standard
    nonce: []const u8,

    /// For .form:
    ///
    /// Bypass form control validation for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fs-novalidate
    /// status: standard
    novalidate: []const u8,

    /// For .details:
    ///
    /// Whether the details are visible
    ///
    /// status: standard
    /// For .dialog:
    ///
    /// Whether the dialog box is showing
    ///
    /// status: unknown
    open: []const u8,

    /// For .meter:
    ///
    /// Optimum value in gauge
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-meter-optimum
    /// status: standard
    optimum: []const u8,

    /// For .input:
    ///
    /// Pattern to be matched by the form control's value
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-pattern
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/pattern
    /// status: standard
    pattern: []const u8,

    /// For:
    ///   .a
    ///   .area
    ///
    /// URLs to ping
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/links.html#ping
    /// status: standard
    ping: []const u8,

    /// For:
    ///   .input
    ///   .textarea
    ///
    /// User-visible label to be placed within the form control
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-placeholder
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/placeholder
    /// status: standard
    placeholder: []const u8,

    /// For .video:
    ///
    /// Encourage the user agent to display video content within the element's playback area
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-video-playsinline
    /// status: standard
    playsinline: []const u8,

    /// Makes the element a popover element
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/popover.html#the-popover-attribute
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/popover
    /// status: standard
    popover: []const u8,

    /// For:
    ///   .button
    ///   .input
    ///
    /// Targets a popover element to toggle, show, or hide
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/popover.html#attr-popovertarget
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#popovertarget
    /// status: standard
    popovertarget: []const u8,

    /// For:
    ///   .button
    ///   .input
    ///
    /// Indicates whether a targeted popover element is to be toggled, shown, or hidden
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/popover.html#attr-popovertargetaction
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#popovertargetaction
    /// status: standard
    popovertargetaction: []const u8,

    /// For .video:
    ///
    /// Poster frame to show prior to video playback
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-video-poster
    /// status: standard
    poster: []const u8,

    /// For:
    ///   .audio
    ///   .video
    ///
    /// Hints how much buffering the media resource will likely need
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-media-preload
    /// status: standard
    preload: []const u8,

    /// For .@"form-associated custom elements":
    ///
    /// Affects willValidate, plus any behavior added by the custom element author
    ///
    /// status: unknown
    /// For:
    ///   .input
    ///   .textarea
    ///
    /// Whether to allow the value to be edited by the user
    ///
    /// status: unknown
    readonly: []const u8,

    /// For:
    ///   .a
    ///   .area
    ///   .iframe
    ///   .img
    ///   .link
    ///   .script
    ///
    /// Referrer policy for fetches initiated by the element
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/semantics.html#attr-link-referrerpolicy
    /// status: standard
    referrerpolicy: []const u8,

    /// For:
    ///   .a
    ///   .area
    ///
    /// Relationship between the location in the document containing the hyperlink and the destination resource
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-rel
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/rel
    /// status: standard
    /// For .link:
    ///
    /// Relationship between the document containing the hyperlink and the destination resource
    ///
    /// status: unknown
    rel: []const u8,

    /// For:
    ///   .input
    ///   .select
    ///   .textarea
    ///
    /// Whether the control is required for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-required
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/required
    /// status: standard
    required: []const u8,

    /// For .ol:
    ///
    /// Number the list backwards
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#attr-ol-reversed
    /// status: standard
    reversed: []const u8,

    /// For .textarea:
    ///
    /// Number of lines to show
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-rows
    /// status: standard
    rows: []const u8,

    /// For:
    ///   .td
    ///   .th
    ///
    /// Number of rows that the cell is to span
    ///
    /// status: standard
    rowspan: []const u8,

    /// For .iframe:
    ///
    /// Security rules for nested content
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-sandbox
    /// status: standard
    sandbox: []const u8,

    /// For .th:
    ///
    /// Specifies which cells the header cell applies to
    ///
    /// status: standard
    scope: []const u8,

    /// For .option:
    ///
    /// Whether the option is selected by default
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-option-selected
    /// status: standard
    selected: []const u8,

    /// For .template:
    ///
    /// Sets clonable on a declarative shadow root
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-template-shadowrootclonable
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template#shadowrootclonable
    /// status: standard
    shadowrootclonable: []const u8,

    /// For .template:
    ///
    /// Enables declarative shadow roots to indicate they will use a custom element registry
    ///
    /// status: unknown
    shadowrootcustomelementregistry: []const u8,

    /// For .template:
    ///
    /// Sets delegates focus on a declarative shadow root
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-template-shadowrootdelegatesfocus
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template#shadowrootdelegatesfocus
    /// status: standard
    shadowrootdelegatesfocus: []const u8,

    /// For .template:
    ///
    /// Enables streaming declarative shadow roots
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-template-shadowrootmode
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template#shadowrootmode
    /// status: standard
    shadowrootmode: []const u8,

    /// For .template:
    ///
    /// Sets serializable on a declarative shadow root
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/scripting.html#attr-template-shadowrootserializable
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template#shadowrootserializable
    /// status: experimental
    shadowrootserializable: []const u8,

    /// For .area:
    ///
    /// The kind of shape to be created in an image map
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/image-maps.html#attr-area-shape
    /// status: standard
    shape: []const u8,

    /// For:
    ///   .input
    ///   .select
    ///
    /// Size of the control
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-size
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/size
    /// status: standard
    size: []const u8,

    /// For:
    ///   .img
    ///   .source
    ///
    /// Image sizes for different page layouts
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-sizes
    /// status: standard
    /// For .link:
    ///
    /// Sizes of the icons (for rel="icon")
    ///
    /// status: unknown
    sizes: []const u8,

    /// For .global:
    ///
    /// The element's desired slot
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/dom.html#attr-slot
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/slot
    /// status: standard
    slot: []const u8,

    /// For:
    ///   .col
    ///   .colgroup
    ///
    /// Number of columns spanned by the element
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/tables.html#attr-colgroup-span
    /// status: standard
    span: []const u8,

    /// Whether the element is to have its spelling and grammar checked
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-spellcheck
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/spellcheck
    /// status: standard
    spellcheck: []const u8,

    /// For:
    ///   .audio
    ///   .embed
    ///   .iframe
    ///   .img
    ///   .input
    ///   .script
    ///   .@"source (in video or audio)"
    ///   .track
    ///   .video
    ///
    /// Address of the resource
    ///
    /// status: deprecated
    src: []const u8,

    /// For .iframe:
    ///
    /// A document to render in the iframe
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/iframe-embed-object.html#attr-iframe-srcdoc
    /// status: standard
    srcdoc: []const u8,

    /// For .track:
    ///
    /// Language of the text track
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/media.html#attr-track-srclang
    /// status: standard
    srclang: []const u8,

    /// For:
    ///   .img
    ///   .source
    ///
    /// Images to use in different situations, e.g., high-resolution displays, small monitors, etc.
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-srcset
    /// status: standard
    srcset: []const u8,

    /// For .ol:
    ///
    /// Starting value of the list
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/grouping-content.html#attr-ol-start
    /// status: standard
    start: []const u8,

    /// For .input:
    ///
    /// Granularity to be matched by the form control's value
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/input.html#attr-input-step
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/step
    /// status: standard
    step: []const u8,

    /// Presentational and formatting instructions
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/dom.html#the-style-attribute
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/style
    /// status: standard
    style: []const u8,

    /// Whether the element is focusable and sequentially focusable, and
    /// the relative order of the element for the purposes of sequential focus navigation
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#attr-tabindex
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/tabindex
    /// status: standard
    tabindex: []const u8,

    /// For:
    ///   .a
    ///   .area
    ///
    /// Navigable for hyperlink navigation
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-target
    /// status: standard
    /// For .base:
    ///
    /// Default navigable for hyperlink navigation and form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-target
    /// status: standard
    /// For .form:
    ///
    /// Navigable for form submission
    ///
    /// status: unknown
    target: []const u8,

    /// Full term or expansion of abbreviation
    ///
    /// Is a global attribute
    ///
    /// status: unknown
    title: []const u8,

    /// Whether the element is to be translated when the page is localized
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/dom.html#attr-translate
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/translate
    /// status: standard
    translate: []const u8,

    /// For:
    ///   .a
    ///   .link
    ///
    /// Hint for the type of the referenced resource
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/obsolete.html#attr-li-type
    /// status: deprecated
    /// For .button:
    ///
    /// Type of button
    ///
    /// status: unknown
    /// For:
    ///   .embed
    ///   .object
    ///   .source
    ///
    /// Type of embedded resource
    ///
    /// status: unknown
    /// For .input:
    ///
    /// Type of form control
    ///
    /// status: unknown
    /// For .ol:
    ///
    /// Kind of list marker
    ///
    /// status: unknown
    /// For .script:
    ///
    /// Type of script
    ///
    /// status: unknown
    type: []const u8,

    /// For .img:
    ///
    /// Name of image map to use
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/image-maps.html#attr-hyperlink-usemap
    /// status: standard
    usemap: []const u8,

    /// For:
    ///   .button
    ///   .option
    ///
    /// Value to be used for form submission
    ///
    /// status: standard
    /// For .data:
    ///
    /// Machine-readable value
    ///
    /// status: unknown
    /// For .input:
    ///
    /// Value of the form control
    ///
    /// status: unknown
    /// For .li:
    ///
    /// Ordinal value of the list item
    ///
    /// status: unknown
    /// For:
    ///   .meter
    ///   .progress
    ///
    /// Current value of the element
    ///
    /// status: unknown
    value: []const u8,

    /// For:
    ///   .canvas
    ///   .embed
    ///   .iframe
    ///   .img
    ///   .input
    ///   .object
    ///   .@"source (in picture)"
    ///   .video
    ///
    /// Horizontal dimension
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/embedded-content-other.html#attr-dim-width
    /// status: standard
    width: []const u8,

    /// For .textarea:
    ///
    /// How the value of the form control is to be wrapped for form submission
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/form-elements.html#attr-textarea-wrap
    /// status: standard
    wrap: []const u8,

    /// Whether the element can offer writing suggestions or not.
    ///
    /// Is a global attribute
    ///
    /// Spec: https://html.spec.whatwg.org/multipage/interaction.html#writing-suggestions
    /// MDN: https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/writingsuggestions
    /// status: standard
    writingsuggestions: []const u8,
};
pub const ElementTag = enum {
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
    a,

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
    abbr,

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
    address,

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
    area,

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
    article,

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
    aside,

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
    audio,

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
    b,

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
    base,

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
    bdi,

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
    bdo,

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
    blockquote,

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
    body,

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
    br,

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
    button,

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
    canvas,

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
    caption,

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
    cite,

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
    code,

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
    col,

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
    colgroup,

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
    data,

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
    datalist,

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
    dd,

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
    del,

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
    details,

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
    dfn,

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
    dialog,

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
    div,

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
    dl,

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
    dt,

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
    em,

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
    embed,

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
    fieldset,

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
    figcaption,

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
    figure,

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
    footer,

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
    form,

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
    h1,

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
    h2,

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
    h3,

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
    h4,

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
    h5,

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
    h6,

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
    head,

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
    header,

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
    hgroup,

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
    hr,

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
    html,

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
    i,

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
    iframe,

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
    img,

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
    input,

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
    ins,

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
    kbd,

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
    label,

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
    legend,

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
    li,

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
    link,

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
    main,

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
    map,

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
    mark,

    /// MathML root
    ///
    /// Element with interface Element
    ///
    /// Allowed attributes:
    ///
    /// status: unknown
    math,

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
    menu,

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
    meta,

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
    meter,

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
    nav,

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
    noscript,

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
    object,

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
    ol,

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
    optgroup,

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
    option,

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
    output,

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
    p,

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
    picture,

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
    pre,

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
    progress,

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
    q,

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
    rp,

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
    rt,

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
    ruby,

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
    s,

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
    samp,

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
    script,

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
    search,

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
    section,

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
    select,

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
    slot,

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
    small,

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
    source,

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
    span,

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
    strong,

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
    style,

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
    sub,

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
    summary,

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
    sup,

    /// SVG root
    ///
    /// Element with interface SVGSVGElement
    ///
    /// Allowed attributes:
    ///
    /// status: unknown
    svg,

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
    table,

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
    tbody,

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
    td,

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
    template,

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
    textarea,

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
    tfoot,

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
    th,

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
    thead,

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
    time,

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
    title,

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
    tr,

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
    track,

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
    u,

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
    ul,

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
    @"var",

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
    video,

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
    wbr,
};

// @GENERATED SECTION END
