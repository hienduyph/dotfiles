#!/usr/bin/env bash
set -x

source ./scripts/dotfiles.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

_cli() {
  cargo build --release
  cp target/release/json2yaml target/release/yaml2json ~/.local/bin
}

_system() {
  sudo cp $HOME/dotfiles/shell/system.sh /etc/profile.d/
}

main() {
  _neovim
  _shell
  _dots $PLATFORM
  _fonts
  _ranger
  _cli
  _system
  _completions
}

main
