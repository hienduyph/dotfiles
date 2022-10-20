#/bin/bash

source $HOME/dotfiles/shell/func.sh

packages=(
  dnscrypt-proxy
  git-lfs
  git
  git-subtree
  icu
  neovim
  htop
  telnet
  cronie cronie-anacron

  java-11-openjdk

  podman-compose
  podman

  libsecret-tools

  alacritty

  libheif gimp-heif-plugin qt-heif-image-plugin

  swappy
)

echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo dnf remove PackageKit fedora-chromium-config -y
