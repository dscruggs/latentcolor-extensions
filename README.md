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

## License

The installers, documentation, and plugin are [MIT licensed](LICENSE). This
does not grant rights to the proprietary LatentColor application or CLI source.
