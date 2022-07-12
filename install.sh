#!/usr/bin/env bash
set -x

source ./scripts/dotfiles.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

_mac() {
  echo "Setting mac links"
  sudo ln -sf /opt/homebrew/bin/bash /usr/local/bin/bash
}

__system() {
  _fonts $PLATFORM
  _system
  _py_cli
  _cli
  if [ ${PLATFORM} == "darwin" ]; then
    _mac
  fi
}

__users() {
  _neovim
  _shell
  _dots $PLATFORM
  _configs $PLATFORM
  _git
}

main() {
  if [ $1 == "system" ]; then
    __system
    exit 0;
  fi
  __users
}

main
