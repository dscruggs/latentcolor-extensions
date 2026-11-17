---
name: latentcolor
description: Edit, inspect, and export local images through the Latentcolor browser editor using the standalone CLI. Use when the user asks to work on a local image with Latentcolor or explicitly asks to install or update its CLI.
---

# latentcolor CLI

## Connect the editor

Check the installed CLI and the target editor at the start of an editing task.

```sh
latentcolor version --json
latentcolor doctor --json
```

Use the same `--app-url` for `doctor` and `open` when the user chooses an editor
other than the default. Read `result.compatibility` and `result.recovery` from
`doctor`. An idle bridge is normal before the first `open`. If compatibility is
unknown or an older CLI omits it, use `open` and check whether the editor
attaches. The current CLI checks compatibility automatically before launch.

If the CLI is missing or reports an incompatibility, explain the setup
requirement and offer to install or update it. An editing request alone does
not authorize installation or an update. When the user explicitly requests
installation or an update, follow the
[official installation guide](https://github.com/dscruggs/latentcolor-extensions/blob/main/docs/install.md).
Use the published installer on the computer that runs the browser editor, then
verify with `version --json` and `doctor --json`.

Use the diagnosed stage to guide recovery. If the browser failed to launch,
check its default-browser setting. If the browser is open and unattached,
check the editor tab for a loading screen or a Local Network Access prompt.
If the editor is attached and still loading, wait for it to become ready.
A generic connection failure alone cannot identify the cause.

## Edit and review

1. Open the source with `latentcolor open /absolute/path/photo.jpg --json`.
2. Inspect with `latentcolor inspect --json` before naming a target. Record the
   document revision and stable scope and mask IDs. Look up a specific operation
   with `latentcolor commands <name> --json`.
3. Use `cliInvocation.usage` and include an operation in an `apply` plan only
   when its `cliInvocation.inEditPlan` is true. If an older catalog omits these
   fields, check `latentcolor --help` for dedicated commands. For AI brush
   guidance, use `latentcolor paint-ai-selection --file gesture.json --json`.
4. Use `--expect` with the inspected revision where available. After a revision
   conflict, inspect the current document before retrying.
5. To verify a mask, use
   `latentcolor preview-mask --id <mask-id> --scope <scope-id> --json` when the
   installed command catalog lists it. Inspect the temporary PNG at the
   returned path. Mask preview leaves the document and history untouched.

Use `export --temporary --json` for general rendered review. Write a persistent
export only when the user requests one. Keep bridge credentials and raw command
dumps out of model context. Inspect history before retrying after a transport
failure. The browser owns document state, history, rendering, decoding, and
export encoding.
