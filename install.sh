#!/usr/bin/env bash
set -x

source ./scripts/dotfiles.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

_cli() {
  source $HOME/.cargo/env
  cargo build --release
  cp target/release/json2yaml target/release/yaml2json ~/.local/bin

  pkgs=(
    jwt-cli
    cargo-edit
  )

  for pk in "${pkgs[@]}"; do
    echo "[Cargo] installing $pk"
    cargo install $pk
  done
}

_mac() {
  echo "Setting mac links"
  sudo ln -sf /opt/homebrew/bin/bash /usr/local/bin/bash
}

__system() {
  _fonts $PLATFORM
  _system
  _py_cli
  if [ ${PLATFORM} == "darwin" ]; then
    _mac
  fi
}

__users() {
  _neovim
  _shell
  _dots $PLATFORM
  _configs $PLATFORM
  _cli
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
