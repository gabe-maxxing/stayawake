#!/bin/bash
set -euo pipefail

install_stayawake() {
  local tap=gabe-maxxing/tap
  local formula=$tap/stayawake

  if ! command -v brew >/dev/null; then
    printf 'Install Homebrew first from https://brew.sh/, then rerun this script.\n' >&2
    return 1
  fi

  brew tap "$tap"
  brew update
  # Older Homebrew versions do not require formula trust.
  if brew command trust >/dev/null 2>&1; then
    brew trust --formula "$formula"
  fi

  if brew list --formula --versions "$formula" >/dev/null; then
    brew upgrade "$formula"
  else
    brew install "$formula"
  fi

  "$(brew --prefix "$formula")/bin/stayawake" --version
}

install_stayawake
