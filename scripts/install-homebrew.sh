#!/bin/bash
set -euo pipefail

show_installed_version() {
  local version=$1 top bottom upper lower column
  # A tiny terminal rendition of the Whitney logo.
  local colors=(0 173 230 94)
  local rows=(
    '001000100'
    '011222110'
    '112222211'
    '012323210'
    '002233200'
    '002222200'
    '000111000'
    '000000000'
  )

  if [[ ! -t 1 || ${TERM:-dumb} == dumb || -n ${NO_COLOR+x} ]]; then
    printf '%s\n' "$version"
    return
  fi

  for ((top = 0; top < ${#rows[@]}; top += 2)); do
    bottom=$((top + 1))
    printf '  '
    for ((column = 0; column < ${#rows[top]}; column++)); do
      upper=${rows[top]:column:1}
      lower=${rows[bottom]:column:1}
      if (( upper && lower )); then
        printf '\033[38;5;%s;48;5;%sm▀\033[0m' "${colors[upper]}" "${colors[lower]}"
      elif (( upper )); then
        printf '\033[38;5;%sm▀\033[0m' "${colors[upper]}"
      elif (( lower )); then
        printf '\033[38;5;%sm▄\033[0m' "${colors[lower]}"
      else
        printf ' '
      fi
    done
    if (( top == 2 )); then
      printf '  %s' "$version"
    fi
    printf '\n'
  done
}

install_stayawake() {
  local tap=gabe-maxxing/tap
  local formula=$tap/stayawake prefix version

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

  prefix=$(brew --prefix "$formula")
  version=$("$prefix/bin/stayawake" --version)
  show_installed_version "$version"
}

install_stayawake
