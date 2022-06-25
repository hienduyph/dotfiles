#!/usr/bin/env bash

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
)
sudo port install -N ${PKGS[@]}
