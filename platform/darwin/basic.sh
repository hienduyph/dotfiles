#!/bin/bash
set -e

PKGS=(
  zoxide
  fzf
  exa
  bat
  neovim
  tmux
  tmux-pasteboard
  direnv
  starship
  alacritty
  git-delta
  gnupg2
  git
  git-lfs
  python39
  nodejs16
  go
  fd
  ripgrep
  inetutils
  wget
  jq
  gsed
  findutils
  rust-analyzer
  rust
  cargo
  openjdk11
  podman
  podman-compose
  htop
  google-cloud-sdk
  sccache
  OpenBLAS lapack
)
sudo port -N install ${PKGS[@]}

curl -qL https://www.npmjs.com/install.sh | sh
