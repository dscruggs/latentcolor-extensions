---
name: latentcolor
description: Edit, inspect, and export local images through the Latentcolor browser editor using the standalone CLI. Use when the user asks to work on a local image with Latentcolor or explicitly asks to install or update its CLI.
---

# latentcolor CLI

At the start of an editing task, verify the installed CLI:

```sh
latentcolor version --json
```

If the CLI is missing or incompatible, explain the setup requirement and
offer to install it. An editing request alone does not authorize installation
or an update.

When the user explicitly requests installation or an update, follow the
[official installation guide](https://github.com/dscruggs/latentcolor-extensions/blob/main/docs/install.md).
Use the published installer for the computer that runs the browser editor.
Verify setup with `latentcolor version --json` and resume any pending edit only
after it succeeds. If setup cannot complete, explain what blocked it and
share the installation guide.

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
