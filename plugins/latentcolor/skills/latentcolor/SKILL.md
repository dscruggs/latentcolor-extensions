---
name: latentcolor
description: Edit, inspect, and export local images through the visible latentcolor browser editor using the installed standalone CLI. Use when the user asks to improve, color-grade, inspect, or export a local image with latentcolor.
---

# latentcolor CLI

At the start of a task, verify the installed CLI:

```sh
latentcolor version --json
```

If it is missing or incompatible, direct the user to
`https://github.com/dscruggs/latentcolor-extensions`. Do not compile, download,
or replace a binary during an editing task.

The CLI starts a private loopback bridge and connects the visible browser
editor. The browser owns document state, history, rendering, decoding, and
export encoding.

1. Open the source: `latentcolor open /absolute/path/photo.jpg --json`.
2. Inspect before naming targets: `latentcolor inspect --json` and
   `latentcolor commands --json`.
3. Apply explicit engine commands with `--json`; inspect after revision
   conflicts instead of overwriting manual work.
4. Export only when requested: `latentcolor export /absolute/path/result.png --json`.

Use `export --temporary --json` for rendered review. Never copy bridge
credentials, full file contents, or raw command dumps into model context. After
an uncertain mutation transport failure, inspect history before retrying.
