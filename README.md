# LatentColor extensions

This repository is the public distribution channel for the LatentColor CLI and
agent integrations. The editor, its engine, and CLI source remain private.

The CLI opens the visible browser editor and uses a private loopback bridge. It
does not upload image bytes or editing commands to a LatentColor server.

## Status

The first public CLI release has not yet been published. The installer and
Codex plugin are ready for the first immutable GitHub Release.

## Install

After the first release:

```sh
curl -LsSf https://raw.githubusercontent.com/dscruggs/latentcolor-extensions/main/install.sh | sh
```

```powershell
irm https://raw.githubusercontent.com/dscruggs/latentcolor-extensions/main/install.ps1 | iex
```

See [installation](docs/install.md), [compatibility](docs/compatibility.md),
and [security](docs/security.md).

## Agent marketplaces

Codex, Claude Code, and Cursor each have a marketplace catalog at their
documented repository location. All three point to the same
`plugins/latentcolor` package.

The package contains one `skills/latentcolor/SKILL.md`, two shared presentation
images, and only the three host-required manifests:

- `.codex-plugin/plugin.json` for Codex and ChatGPT
- `.claude-plugin/plugin.json` for Claude Code
- `.cursor-plugin/plugin.json` for Cursor

The manifests describe the same versioned package for their respective hosts;
the workflow itself is defined once. The plugin requires the separately
installed CLI.

## License

The installers, documentation, and plugin are [MIT licensed](LICENSE). This
does not grant rights to the proprietary LatentColor application or CLI source.
