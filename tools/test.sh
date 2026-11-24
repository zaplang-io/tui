#!/bin/sh
set -eu

root=$(CDPATH='' cd -- "$(dirname "$0")/.." && pwd)
zap=${ZAP:-zap}
scratch=$(mktemp -d)
trap 'rm -rf "$scratch"' EXIT
trap 'exit 1' HUP INT TERM
export ZAP_CACHE="$scratch/cache"
unset ZAP_ZENV

"$zap" fmt --check "$root/src" "$root/tests"

# Exercise the public API from a consumer with tui installed as a dependency.
cd "$scratch"
ln -s "$root" tui
cat > zap.toml <<'MANIFEST'
[package]
name = "tui_tests"
version = "0.0.0"

[dependencies]
tui = { path = "tui" }
MANIFEST
"$zap" zenv create --no-venv
cp -R "$root/tests" tests
ZAP_ZENV="$scratch/zenv" "$zap" test tests/
