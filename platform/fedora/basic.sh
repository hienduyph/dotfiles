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
  mpv
  code
  qbittorrent
  google-chrome-stable
  dropbox
  calibre
  fcitx5 fcitx5-unikey 

  https://github.com/wez/wezterm/releases/download/20220807-113146-c2fee766/wezterm-20220807_113146_c2fee766-1.fedora36.x86_64.rpm

  maven
  cronie cronie-anacron
  libheif gimp-heif-plugin qt-heif-image-plugin
)

echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo dnf remove PackageKit fedora-chromium-config -y

services=(
  dnscrypt-proxy
)

for pkg in "${services[@]}"; do
  sudo systemctl enable --now $pkg
done
