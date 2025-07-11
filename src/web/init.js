const LOG_INFO = 0;
const LOG_WARN = 1;
const LOG_ERR = 2;
const LOG_DEBUG = 3;
const U32_MAX = 4294967295;

// @GENERATED SECTION START

// generated - *DO NOT EDIT MANUALLY*

const events = [
  ["DOMContentLoaded", 0],
  ["afterprint", 1],
  ["beforematch", 2],
  ["beforeprint", 3],
  ["beforetoggle", 4],
  ["beforeunload", 5],
  ["blur", 6],
  ["cancel", 7],
  ["change", 8],
  ["click", 9],
  ["close", 10],
  ["command", 11],
  ["connect", 12],
  ["contextlost", 13],
  ["contextrestored", 14],
  ["currententrychange", 15],
  ["dispose", 16],
  ["error", 17],
  ["focus", 18],
  ["formdata", 19],
  ["hashchange", 20],
  ["input", 21],
  ["invalid", 22],
  ["languagechange", 23],
  ["load", 24],
  ["message", 25],
  ["messageerror", 26],
  ["navigate", 27],
  ["navigateerror", 28],
  ["navigatesuccess", 29],
  ["offline", 30],
  ["online", 31],
  ["open", 32],
  ["pagehide", 33],
  ["pagereveal", 34],
  ["pageshow", 35],
  ["pageswap", 36],
  ["pointercancel", 37],
  ["popstate", 38],
  ["readystatechange", 39],
  ["rejectionhandled", 40],
  ["reset", 41],
  ["select", 42],
  ["storage", 43],
  ["submit", 44],
  ["toggle", 45],
  ["unhandledrejection", 46],
  ["unload", 47],
  ["visibilitychange", 48],
  ["abort", 49],
  ["canplay", 50],
  ["canplaythrough", 51],
  ["durationchange", 52],
  ["emptied", 53],
  ["ended", 54],
  ["loadeddata", 55],
  ["loadedmetadata", 56],
  ["loadstart", 57],
  ["pause", 58],
  ["play", 59],
  ["playing", 60],
  ["progress", 61],
  ["ratechange", 62],
  ["resize", 63],
  ["seeked", 64],
  ["seeking", 65],
  ["stalled", 66],
  ["suspend", 67],
  ["timeupdate", 68],
  ["volumechange", 69],
  ["waiting", 70],
  ["drag", 71],
  ["dragend", 72],
  ["dragenter", 73],
  ["dragleave", 74],
  ["dragover", 75],
  ["dragstart", 76],
  ["drop", 77],
];
// @GENERATED SECTION END

const text_decoder = new TextDecoder();
const text_encoder = new TextEncoder();

var wasm_memory = new WebAssembly.Memory({
  initial: 17, // 1M (Can't be 16 annoyingly)
  maximum: 256,
});
var wasm_exports = null;

const references = [undefined];

async function init(wasm_target) {
  const importObject = {
    env: {
      memory: wasm_memory,

      // Logging
      log: function (level, ptr, len) {
        const msg = loadString(ptr, len);

        switch (level) {
          case LOG_INFO:
            console.info(msg);
            break;
          case LOG_WARN:
            console.warn(msg);
            break;
          case LOG_ERR:
            console.error(msg);
            break;
          case LOG_DEBUG:
            console.debug(msg);
            break;
          default:
            console.error(`Unknown error level ${level}`);
            console.error(`Message was '${msg}'`);
            break;
        }
      },

      // Refrence things
      refById: function (id_ptr, id_len) {
        const id = loadString(id_ptr, id_len);
        const obj = document.getElementById(id);

        return refObject(obj);
      },

      unref: function (ref) {
        assert(ref < references.length);
        references[ref] = null;
      },

      refCall: function (ref, fnptr, fnlen, argsptr, argslen) {
        const name = loadString(fnptr, fnlen);
        const args = JSON.parse(loadString(argsptr, argslen));
        const obj = references[ref];

        const ret = obj[name](...args);

        return refObject(ret);
      },

      refSet: function (ref, fieldptr, fieldlen, argptr, arglen) {
        const name = loadString(fieldptr, fieldlen);
        const arg = JSON.parse(loadString(argptr, arglen));
        const obj = references[ref];

        obj[name] = arg;
      },

      refSetString: function (ref, fieldptr, fieldlen, stringptr, stringlen) {
        const name = loadString(fieldptr, fieldlen);

        const str = loadString(stringptr, stringlen);
        const obj = references[ref];

        obj[name] = str;
      },

      refGetRef: function (ref, fieldptr, fieldlen) {
        const name = loadString(fieldptr, fieldlen);
        const obj = references[ref];

        const ret = obj[name];

        return refObject(ret);
      },

      refGet: function (ref, fieldptr, fieldlen) {
        const name = loadString(fieldptr, fieldlen);
        const obj = references[ref];

        const ret = obj[name];

        const json_ret = JSON.stringify(ret);

        return storeSting(json_ret);
      },

      // Fetch API TODO: integrate with web.zig
      //
      // startFetch: function (id, target_ptr, target_len) {
      //   const target = loadString(target_ptr, target_len);
      //
      //   fetch(target)
      //     .then((res) => res.bytes())
      //     .then((bytes) => {
      //       const ret_ptr = wasm_exports.allocRet(bytes.length);
      //       const slice = new Uint8Array(
      //         wasm_memory.buffer,
      //         ret_ptr,
      //         bytes.length,
      //       );
      //       slice.set(bytes);
      //
      //       wasm_exports.handleFetch(id, packSlice(ret_ptr, slice.length));
      //     })
      //     .catch((reason) => {
      //       console.error(`Error while fetching ${reason}`);
      //       wasm_exports.handleFetch(id, 0n);
      //     });
      // },
    },
  };

  const wasm = await WebAssembly.instantiateStreaming(
    fetch(wasm_target),
    importObject,
  );
  wasm_exports = wasm.instance.exports;
  window.drasil_wasm = wasm;

  const expected_exports = ["init", "handleEvent", "allocRet"];
  for (const ee of expected_exports) {
    if (!wasm_exports[ee]) {
      throw new Error(`WASM module missing required export: ${ee}`);
    }
  }

  // Ensure that no matter how many times we call setup, events are only
  // registered once
  if (!window.drasil_event_setup) {
    window.drasil_event_setup = true;

    // Setup event handling
    for (const ev of events) {
      document.body.addEventListener(ev[0], (event) => {
        if (!event.target.hasAttribute("drasil-event")) return;

        const data = JSON.parse(event.target.getAttribute("drasil-event"));
        if (ev[1] !== data[0]) return;

        const ref = refObject(event);

        wasm_exports.handleEvent(ref, data[0], data[1]);
        references[ref] = null;
      });
    }
  }

  wasm_exports.init();
}

function storeSting(str) {
  const byte_size = new Blob([str]).size;
  const ptr = wasm_exports.allocRet(byte_size);
  if (ptr == 0) return BigInt(0);
  const slice = new Uint8Array(wasm_memory.buffer, ptr, byte_size);
  text_encoder.encodeInto(str, slice);

  return packSlice(ptr, byte_size);
}

function packSlice(ptr, len) {
  assert(len < U32_MAX);
  assert(ptr < U32_MAX);
  assert(ptr > 0);

  return BigInt(ptr) | (BigInt(len) << 32n);
}

function loadByteSlice(ptr, len) {
  assert(len < U32_MAX);
  assert(ptr < U32_MAX);
  assert(ptr > 0);

  return new Uint8Array(wasm_memory.buffer, ptr, len);
}

function loadString(ptr, len) {
  if (len === 0) return "";

  const str = text_decoder.decode(loadByteSlice(ptr, len));
  return str;
}

function assert(cond) {
  if (!cond) throw Error("Assertion tripped");
}

function refObject(obj) {
  if (obj === null) return 0;
  if (obj === undefined) return 0;

  var idx = references.indexOf(null, 1);
  if (idx === -1) {
    idx = references.length;
    references.push(obj);
  } else {
    references[idx] = obj;
  }

  assert(idx < references.length);

  return idx;
}
