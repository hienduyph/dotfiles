#/bin/bash

source $HOME/dotfiles/shell/func.sh

packages=(
  dnscrypt-proxy
  zsh
  jq
  wget
  albert
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

  alacritty

  libheif gimp-heif-plugin qt-heif-image-plugin

  swappy
  gnome-tweaks
  xlsclients
  ibus-qt
  ibus-gtk
  onedrive
)

echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo dnf remove PackageKit fedora-chromium-config -y
