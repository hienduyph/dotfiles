#!/usr/bin/env bash

_env() {
  sudo cp $HOME/dotfiles/shell/system/locale /etc/default/locale
}

_brew() {
  export HOMEBREW_INSTALL_FROM_API=1
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  sudo useradd brew
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
  sudo tee /etc/environment << EOF
EDITOR=nvim
VISUAL=nvim
SYSTEMD_EDITOR=nvim
KUBE_EDITOR=nvim
EOF

  u=$USER
  sudo chown -R brew:brew /home/linuxbrew/.linuxbrew
  sudo tee  /etc/sudoers.d/brew <<< EOF
  $u ALL= (ALL) NOPASSWD: /home/linuxbrew/.linuxbrew/bin/brew
EOF
}

_mac() {
  echo "Setup mac syste"
  sudo chown -R brew:brew /opt/homebrew
}

__system() {
  _env
  _brew
  if [[ ${PLATFORM} == "darwin" ]]; then
    _mac
  elif [[ ${PLATFORM} == "linux" ]]; then
    _linux
  fi
}

__system
