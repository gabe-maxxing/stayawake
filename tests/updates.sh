#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
source ./stayawake

export XDG_CACHE_HOME
XDG_CACHE_HOME=$(mktemp -d)
trap 'rm -rf "$XDG_CACHE_HOME"' EXIT

newer_than 1.10.0 1.9.15
newer_than 2.0.0 1.999999.999999
if newer_than 1.2.0 1.2.0 || newer_than '2.0.0-beta' 1.2.0; then
  echo 'Unexpected version comparison' >&2
  exit 1
fi

latest_release() { printf '2.10.0\n'; }
check_updates explicit > "$XDG_CACHE_HOME/output"
grep -F 'Whitney spotted stayawake v2.10.0!' "$XDG_CACHE_HOME/output"
grep -F 'https://github.com/gabe-maxxing/stayawake/releases/tag/v2.10.0' "$XDG_CACHE_HOME/output"
grep -Eq '^[0-9]+ 2\.10\.0 2\.10\.0$' "$(release_cache_path)"

latest_release() { printf '%s\n' "$VERSION"; }
check_updates explicit | grep -F 'You’re up to date'
latest_release() { return 1; }
if check_updates explicit 2> "$XDG_CACHE_HOME/offline"; then
  echo 'Expected an offline check to fail' >&2
  exit 1
fi
grep -F 'couldn’t reach the release page' "$XDG_CACHE_HOME/offline"
grep -Eq '^[0-9]+ - 2\.10\.0$' "$(release_cache_path)"
check_updates passive > "$XDG_CACHE_HOME/output"
test ! -s "$XDG_CACHE_HOME/output"
