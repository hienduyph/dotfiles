#/bin/bash

source $HOME/dotfiles/shell/func.sh

packages=(
  zsh
  dnscrypt-proxy
  git-lfs
  git
  git-subtree
  xclip
  icu
  nodejs
  bat
  neovim
  exa
  zoxide
  direnv
  fzf
  jq
  ripgrep
  fd-find
  starship
  htop
  git-delta
  telnet
  editorconfig
  lazygit
  tokei
  unrar
  ranger
  cheat

  # core libs
  openblas-devel lapack-devel

  # coding stuff
  golang
  python3.9
  python3.10
  g++ libstdc++-devel libstdc++
  java-11-openjdk
  java-11-openjdk-devel
  clang
  clang-devel clang-tools-extra
  llvm lld
  cmake
  bazel5
  maven

  # db stuff
  mysql-devel
  postgresql-devel

  # container stuff
  helm
  kubectl
  terraform
  podman-compose
  podman

  # ui stuff
  cabextract xorg-x11-font-utils fontconfig
  keepassxc libsecret-tools
  mpv
  qbittorrent
  dropbox
  calibre

  alacritty

  cronie cronie-anacron
  libheif gimp-heif-plugin qt-heif-image-plugin

  gocryptfs
  swappy
)

echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo dnf remove PackageKit fedora-chromium-config -y
