#!/usr/bin/env bash

_box_ui_pkg() {
  sudo dnf install -y libwayland-cursor wayland-devel libxkbcommon freetype
}


_brew_install() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

_code_server() {
  CODE_VERSION="$(curl -s "https://api.github.com/repos/coder/code-server/releases" | jq -r 'first | .tag_name')"
  CODE_VERSION="${CODE_VERSION#v}"
  sudo dnf install -y https://github.com/coder/code-server/releases/download/v${CODE_VERSION}/code-server-${CODE_VERSION}-amd64.rpm
}

_gocryptfs() {
  VERSION=$(gh_latest_release rfjakob/gocryptfs)
  echo "Install ${VERSION}"
  mkdir -p $HOME/.local/bin
  curl -fsSL https://github.com/rfjakob/gocryptfs/releases/download/${VERSION}/gocryptfs_${VERSION}_linux-static_amd64.tar.gz | tar xz -C $HOME/.local/bin
  sudo cp $HOME/.local/bin/gocryptfs /usr/local/bin
}
