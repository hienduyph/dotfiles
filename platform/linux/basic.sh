#/bin/bash

source $HOME/dotfiles/shell/func.sh

set -ex

_py() {
  python3.9 -m ensurepip --user
  python3.9 -m pip install virtualenv
  python3.8 -m ensurepip --user
  python3.8 -m pip install virtualenv
}


_sccache() {
  if ! command -v sccache &> /dev/null
  then
    VERSION=0.3.0
    curl -fsSL https://github.com/mozilla/sccache/releases/download/v${VERSION}/sccache-v${VERSION}-x86_64-unknown-linux-musl.tar.gz | sudo tar zx -C /usr/local/bin --strip-components=1
    sudo chmod +x /usr/local/bin/sccache
  fi
}

_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

_ibus() {
  dconf load /desktop/ibus/ < ibus.dconf
}
_fcitx() {
  sudo tee /etc/environment << EOF
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF
}


main() {
  _py
  _jetbrains
  _rust
  sudo curl -fSsLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.27.2/yq_linux_amd64 && sudo chmod +x /usr/local/bin/yq
}


if [[ $_ == $0 ]]; then
  main
else
  echo "Sourced"
fi

