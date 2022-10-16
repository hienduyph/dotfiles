#!/usr/bin/env bash

_env() {
  sudo mkdir -p /etc/profile.d/
  sudo cp $HOME/dotfiles/shell/system.sh /etc/profile.d/
  sudo cp $HOME/dotfiles/shell/system/locale /etc/default/locale
}

# system stuff
_py_cli() {
  sudo python3.9 -m ensurepip
  sudo python3.9 -m pip install virtualenv
  sudo python3.9 -m virtualenv $PYCLI_HOME
  sudo chown -R $(whoami) $PYCLI_HOME
  $PYCLI_HOME/bin/pip install --upgrade pip mycli pgcli pyyaml awscli ansible black darker
  bins=(
    mycli
    pgcli
  )
  for b in ${bins[@]}; do
    ln -sf $PYCLI_HOME/bin/$b $HOME/.local/bin
  done
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

_mac() {}

__system() {
  _env
  _py_cli
  _cli
  if [ ${PLATFORM} == "darwin" ]; then
    _mac
  elif [ ${PLATFORM} == "linux" ]; then
    _linux
  fi
}

_system
