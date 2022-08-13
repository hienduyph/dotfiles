#!/usr/bin/env bash
set -x

source ./scripts/dotfiles.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

_mac() {
  echo "Setting mac links"
  sudo ln -sf /opt/homebrew/bin/bash /usr/local/bin/bash
}

_linux() {
  mkdir -p ~/.gnupg
  tee ~/.gnupg/gpg-agent.conf << EOF
pinentry-program $(which pinentry-curses)
EOF

  mkdir -p ~/.config/autostart && cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart
}

__system() {
  _fonts $PLATFORM
  _system
  _py_cli
  _cli
  if [ ${PLATFORM} == "darwin" ]; then
    _mac
  elif [ ${PLATFORM} == "linux" ]; then
    _linux
  fi
}

__users() {
  _shell
  _dots $PLATFORM
  _configs $PLATFORM
  _git
  _ranger
  _neovim
}

main() {
  if [ $1 == "system" ]; then
    __system
    exit 0;
  fi
  __users
}

main
