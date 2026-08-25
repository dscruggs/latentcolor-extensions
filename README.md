<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/brand/latentcolor-banner-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="assets/brand/latentcolor-banner-light.svg">
    <img alt="latentcolor" src="assets/brand/latentcolor-banner-light.svg" width="560">
  </picture>
</p>

# latentcolor extensions

[latentcolor](https://latentcolor.com) is a professional photo editor that runs
in the browser. It is designed for local, desktop- and tablet-first work.

Visit [latentcolor.com](https://latentcolor.com).

Editing runs on your device. Remote AI features are used only when you choose
them for advanced workflows. latentcolor does not collect or retain image data
or usage data.

This repository distributes the latentcolor CLI and plugins for Codex, Claude
Code, and Cursor.

## Quick start

1. Install the latentcolor CLI.
2. Install the `latentcolor` plugin from your preferred agent's marketplace.
3. Ask the agent to edit a local photo.

For example:

> Make this photo look better with latentcolor.

The agent opens latentcolor in your browser, where you can see the image and
the result of each edit.

## Install

After the first public release:

```sh
curl -LsSf https://raw.githubusercontent.com/dscruggs/latentcolor-extensions/main/install.sh | sh
```

```powershell
irm https://raw.githubusercontent.com/dscruggs/latentcolor-extensions/main/install.ps1 | iex
```

See [installation](docs/install.md) for versioned installs and archive
verification.

## Agent plugins

The `latentcolor` plugin is available for Codex, Claude Code, and Cursor. It
teaches an agent how to open local images, inspect available commands, apply
requested edits, and export results through latentcolor.

For Claude Code:

```text
/plugin marketplace add dscruggs/latentcolor-extensions
/plugin install latentcolor@latentcolor
```

## CLI

The `latentcolor` command starts a local process, opens the editor in your
browser, and communicates with that browser session through an authenticated
connection bound to `localhost`.

It reads image files from the paths you provide and writes exports to the paths
you provide. The browser editor owns the document, edit history, rendering, and
export.

When an agent uses the CLI, the agent provider handles the prompt, file paths,
and command output included in that agent's context under its own privacy
settings.

```sh
latentcolor open /absolute/path/photo.jpg --json
latentcolor inspect --json
latentcolor commands --json
latentcolor export /absolute/path/result.png --json
```

Use `inspect` and `commands` before applying an edit.

## Documentation

- [Installation](docs/install.md)
- [Compatibility](docs/compatibility.md)
- [Security](docs/security.md)

## License

The installers, documentation, and plugin package are [MIT licensed](LICENSE).
The latentcolor editor and CLI source are proprietary.
