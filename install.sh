#!/usr/bin/env bash
set -x

source ./scripts/dotfiles.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

_mac() {
  echo "Setting mac links"
  sudo ln -sf /opt/homebrew/bin/bash /usr/local/bin/bash
}

_linux() {
  sudo tee /etc/systemd/resolved.conf << EOM
[Resolve]
DNS=127.0.0.1
FallbackDNS=8.8.8.8
EOM
  sudo mkdir -p /etc/dnscrypt-proxy
  sudo cp $HOME/dotfiles/.config/dnscrypt-proxy.toml /etc/dnscrypt-proxy/
  sudo touch /etc/dnscrypt-proxy/forwarding-rules.txt

  sleep 5

  sudo systemctl restart systemd-resolved
  sudo systemctl restart dnscrypt-proxy
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

_linux_user() {
  mkdir -p ~/.gnupg
  tee ~/.gnupg/gpg-agent.conf << EOF
pinentry-program $(which pinentry-curses)
EOF

  mkdir -p ~/.config/autostart && cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart
}
__users() {
  _dots $PLATFORM
  _configs $PLATFORM
  _git
  _ranger
  _neovim
  _cmp
  if [ ${PLATFORM} == "darwin" ]; then
    _mac
  elif [ ${PLATFORM} == "linux" ]; then
    _linux_user
  fi
}

main() {
  if [ $1 == "system" ]; then
    __system
    exit 0;
  fi
  __users
}

main
