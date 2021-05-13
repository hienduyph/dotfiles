#!/bin/bash

source ./shell/common_setup.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

main() {
  _neovim
  _shell
  _dots $PLATFORM
  _fonts
  _ranger
}

main
