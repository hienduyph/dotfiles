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
  ncdu
  ranger
  cheat

  # core libs
  openblas-devel lapack-devel

  # coding stuff
  golang
  python3.9
  python3.10
  rust-analyzer
  g++ libstdc++-devel libstdc++
  java-11-openjdk
  java-11-openjdk-devel
  clang
  clang-devel clang-tools-extra
  llvm lld
  cmake
  bazel5

  # db stuff
  mysql-devel
  postgresql-devel

  # container stuff
  helm
  kubectl
  terraform
  podman-compose
  podman

  # cloud platform
  google-cloud-cli

  # ui stuff
  cabextract xorg-x11-font-utils fontconfig
  blueman
  keepassxc
  brave-browser
  mpv
  code
  gnome-tweak-tool
  qbittorrent
  google-chrome-stable
  dropbox
  calibre
  flameshot
  ibus-bamboo
)

echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo dnf remove PackageKit fedora-chromium-config firefox -y

services=(
  dnscrypt-proxy
)

for pkg in "${services[@]}"; do
  sudo systemctl enable --now $pkg
done
