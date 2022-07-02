#!/bin/bash
set -e

PKGS=(
  zoxide
  fzf
  exa
  bat
  neovim
  tmux
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
  rust-analyzer
  rust
  cargo
  openjdk11
  podman
  podman-compose
  htop
)
sudo port -N install ${PKGS[@]}

curl -qL https://www.npmjs.com/install.sh | sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
