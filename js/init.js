const LOG_INFO = 0;
const LOG_WARN = 1;
const LOG_ERR = 2;
const LOG_DEBUG = 3;
const U32_MAX = 4294967295;
const WASM_TARGET = "wasm";

const text_decoder = new TextDecoder();

var wasm_memory = new WebAssembly.Memory({
  initial: 17, // 1M (Can't be 16 annoyingly)
  maximum: 128, // 8M
});
var wasm_exports = null;

var references = [undefined];

async function init() {
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

        if (obj === null) return 0;

        // TODO: factor out
        var idx = references.indexOf(null);
        if (idx === -1) {
          idx = references.length;
          references.push(obj);
        } else {
          references[idx] = obj;
        }

        assert(idx < references.length);
        // ----

        return idx;
      },

      unref: function (ref) {
        assert(ref < references.length);
        references[ref] = null;
      },

      // Use references
      setInnerHtml: function (ref, content_ptr, content_len) {
        const obj = references[ref];
        const content = loadString(content_ptr, content_len);

        obj.innerHTML = content;
      },

      // Fetch API
      startFetch: function (id, target_ptr, target_len) {
        const target = loadString(target_ptr, target_len);

        fetch(target)
          .then((res) => res.bytes())
          .then((bytes) => {
            const ret_ptr = wasm_exports.alloc(bytes.length);
            const slice = new Uint8Array(
              wasm_memory.buffer,
              ret_ptr,
              bytes.length,
            );
            slice.set(bytes);

            wasm_exports.handleFetch(id, packSlice(ret_ptr, slice.length));
          })
          .catch((reason) => {
            console.error(`Error while fetching ${reason}`);
            wasm_exports.handleFetch(id, 0n);
          });
      },
    },
  };

  const wasm = await WebAssembly.instantiateStreaming(
    fetch(WASM_TARGET),
    importObject,
  );
  wasm_exports = wasm.instance.exports;
  window.drasil_wasm = wasm;

  wasm_exports.init();

  // TODO: validate exports (requires stablish ABI)
  // if (
  //   !instance.exports.memory ||
  //   !instance.exports.malloc ||
  //   !instance.exports.free
  // ) {
  //   throw new Error("WASM module missing required exports");
  // }
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

function callback(subtree, index) {
  wasm_exports.handleCallback(subtree, index);
}

init();
