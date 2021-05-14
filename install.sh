#!/bin/bash

source ./scripts/dotfiles.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

main() {
  _neovim
  _shell
  _dots $PLATFORM
  _fonts
  _ranger
}

main
