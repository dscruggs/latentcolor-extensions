# Review masks with the Latentcolor CLI

Start with `latentcolor doctor --json` and check the installed executable, editor
compatibility, and recovery message. Then open the photo and inspect its scope
IDs and revision. The newer commands below are available when the installed CLI
and connected editor both support them. Check `latentcolor --help` and
`latentcolor commands <name> --json`.

## Paint and inspect one mask

Suppose `inspect` reports the Global scope as `output-primary` at revision 12.
Use the actual scope, revision, and points from your own photo. The IDs for the
new mask and its component must be unused.

Save this as `gesture.json`.

```json
{
  "target": {
    "kind": "create-mask",
    "scopeNodeId": "output-primary",
    "maskId": "portrait-mask",
    "componentId": "portrait-ai-component",
    "adjustmentNodeId": "portrait-adjustment",
    "name": "Portrait"
  },
  "diameterPx": 48,
  "points": [{ "x": 0.48, "y": 0.35 }, { "x": 0.51, "y": 0.55 }]
}
```

```sh
latentcolor paint-ai-selection --file gesture.json --expect 12 --json
```

Read the new revision from the successful response. If it is 13, inspect the
mask at that revision.

```sh
latentcolor preview-mask --id portrait-mask --scope output-primary --expect 13 --json
```

Open the PNG at the returned path before it expires. The colored overlay shows
the effective coverage used by the editor. The preview does not add an edit or
change the document revision.

## Review people and apply a subset

Use a scope from `inspect` and its current revision. For example, save this as
`scope.json`.

```json
{"scopeNodeId":"output-primary"}
```

```sh
latentcolor detect-people --file scope.json --expect 13 --json
```

The response contains a `reviewId`, the unchanged revision, and numbered
candidates with boxes and detection scores. It also reports intersecting
detection boxes. Inspect the candidates and choose which ones to preview.
Replace `review-id-from-detection` in the examples with the returned ID.

Save this as `candidate.json`.

```json
{"reviewId":"review-id-from-detection","candidate":1}
```

```sh
latentcolor preview-person --file candidate.json --expect 13 --json
```

Open the temporary PNG. The preview starts with brush guidance inside the
candidate box. To replace the guidance, add an optional `include` stroke, an
`exclude` stroke, or both and run the preview again. The example points below
use the selected scope's normalized coordinates. Choose points based on what
the previous preview covered.

```json
{
  "reviewId": "review-id-from-detection",
  "candidate": 1,
  "include": {"diameterPx": 36, "points": [{"x":0.48,"y":0.4},{"x":0.49,"y":0.62}]},
  "exclude": {"diameterPx": 24, "points": [{"x":0.56,"y":0.47}]}
}
```

Repeat for each person you want to select. If candidates 1 and 2 have been
reviewed at revision 13 and the masks are usable, save this as
`selection.json`.

```json
{"reviewId":"review-id-from-detection","candidates":[1,2]}
```

```sh
latentcolor apply-people --file selection.json --expect 13 --json
```

Use `result.complete` and each entry in `result.items` to report which masks
were applied or failed. The editor commits accepted masks together, so one
Undo removes the batch. If a result says `adopted-unconfirmed`, inspect
history and the returned mask IDs before retrying. For a partial result,
inspect the document at the returned revision before attempting the remaining
edits. If a new revision invalidates the
review, find and preview the remaining people again.

Intersections reported in `boxOverlaps` describe detection boxes. Use the PNGs
to check the actual masks. Small people or subjects obscured by a crowd may
remain unresolved. Report those cases with the completed masks.
