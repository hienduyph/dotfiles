#!/usr/bin/env bash

_env() {
  sudo mkdir -p /etc/profile.d/
  sudo cp $HOME/dotfiles/shell/system.sh /etc/profile.d/
  sudo cp $HOME/dotfiles/shell/system/locale /etc/default/locale
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
  sudo chown -R $(whoami) /etc/dnscrypt-proxy/forwarding-rules.txt

  sleep 5

  sudo systemctl restart systemd-resolved
  sudo systemctl restart dnscrypt-proxy
}

_mac() {
  echo "Setup mac systej"
}

__system() {
  _env
  if [[ ${PLATFORM} == "darwin" ]]; then
    _mac
  elif [[ ${PLATFORM} == "linux" ]]; then
    _linux
  fi
}

__system
