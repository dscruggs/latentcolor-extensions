#!/bin/sh
set -eu

repo='dscruggs/latentcolor-extensions'
version=''
destination=${LATENTCOLOR_INSTALL_DIR:-"$HOME/.local/bin"}
while [ "$#" -gt 0 ]; do
  case "$1" in
    --version) version=$2; shift 2 ;;
    --install-dir) destination=$2; shift 2 ;;
    --help|-h) echo 'Usage: install.sh [--version VERSION] [--install-dir DIRECTORY]'; exit 0 ;;
    *) echo 'Usage: install.sh [--version VERSION] [--install-dir DIRECTORY]' >&2; exit 2 ;;
  esac
done
case "$(uname -s)" in Darwin) os=darwin ;; Linux) os=linux ;; *) echo 'Unsupported operating system.' >&2; exit 1 ;; esac
case "$(uname -m)" in arm64|aarch64) arch=arm64 ;; x86_64|amd64) arch=amd64 ;; *) echo 'Unsupported processor architecture.' >&2; exit 1 ;; esac
command -v curl >/dev/null && command -v tar >/dev/null || { echo 'curl and tar are required.' >&2; exit 1; }
if command -v shasum >/dev/null; then checksum='shasum -a 256'; elif command -v sha256sum >/dev/null; then checksum=sha256sum; else echo 'A SHA-256 tool is required.' >&2; exit 1; fi
tmp=$(mktemp -d "${TMPDIR:-/tmp}/latentcolor-install.XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM
if [ -n "$version" ]; then case "$version" in v*) tag=$version ;; *) tag="v$version" ;; esac; archive="latentcolor-${tag}-${os}-${arch}.tar.gz"; sums="latentcolor-${tag}-checksums.txt"; base="https://github.com/$repo/releases/download/$tag"; else archive="latentcolor-${os}-${arch}.tar.gz"; sums=checksums.txt; base="https://github.com/$repo/releases/latest/download"; fi
curl -fsSL "$base/$sums" -o "$tmp/checksums.txt"
curl -fsSL "$base/$archive" -o "$tmp/$archive"
expected=$(awk -v name="$archive" '$2 == name { print $1 }' "$tmp/checksums.txt")
actual=$(cd "$tmp" && $checksum "$archive" | awk '{print $1}')
[ -n "$expected" ] && [ "$expected" = "$actual" ] || { echo 'Checksum verification failed.' >&2; exit 1; }
tar -xzf "$tmp/$archive" -C "$tmp"
[ -f "$tmp/latentcolor" ] || { echo 'Archive has no LatentColor executable.' >&2; exit 1; }
mkdir -p "$destination"
install -m 755 "$tmp/latentcolor" "$destination/latentcolor"
echo "Installed $destination/latentcolor"
case ":$PATH:" in *":$destination:"*) ;; *) echo "Add $destination to PATH, then run: latentcolor version --json" ;; esac
