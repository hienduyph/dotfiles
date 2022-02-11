#!/usr/bin/env bash
set -x

source ./scripts/dotfiles.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

_cli() {
  curl -fsSL https://github.com/mozilla/sccache/releases/download/v0.2.15/sccache-v0.2.15-x86_64-unknown-linux-musl.tar.gz | sudo tar zx -C /usr/local/bin --strip-components=1
  sudo chmod +x /usr/local/bin/sccache
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
  _system
  _completions
  _cli
}

main
