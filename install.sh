#!/usr/bin/env bash
set -x

source ./scripts/dotfiles.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

_cli() {

  carbo build --release
  cp target/release/json2yaml target/release/yaml2json ~/.local/bin
}

main() {
  _neovim
  _shell
  _dots $PLATFORM
  _fonts
  _ranger
  _cli
}


main
