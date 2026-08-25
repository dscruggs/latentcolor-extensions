# Install the latentcolor CLI

The `latentcolor` CLI is a standalone executable. It opens the visible browser
editor through a private loopback bridge and does not need Node.js, Python, or a
package manager.

## Latest version

```sh
curl -LsSf https://raw.githubusercontent.com/dscruggs/latentcolor-extensions/main/install.sh | sh
```

```powershell
irm https://raw.githubusercontent.com/dscruggs/latentcolor-extensions/main/install.ps1 | iex
```

The Unix default is `$HOME/.local/bin`; Windows uses
`%LOCALAPPDATA%\\Programs\\latentcolor`. Both installers print a PATH instruction
when required.

## Pinned version and direct archives

Download the installer first when local review is required:

```sh
curl -LO https://raw.githubusercontent.com/dscruggs/latentcolor-extensions/main/install.sh
sh install.sh --version 0.1.0 --install-dir "$HOME/bin"
```

Every release provides one versioned archive per supported platform, a
checksum manifest, and a release manifest. The installers resolve the current
release, download the matching archive, and verify its SHA-256 before extraction. Then run:

```sh
latentcolor version --json
```

Install the CLI before an agent integration. Plugins contain instructions only;
they never carry, compile, download, or replace a binary.
