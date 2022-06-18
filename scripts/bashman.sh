#!/bin/bash
# Simple bash package manager

source $HOME/dotfiles/shell/vars.sh

PKGS=(
  lincheney/fzf-tab-completion
)

for pkg in "${PKGS[@]}"; do
  dst=${BASHMAN_DIR}/${pkg}
  mkdir -p ${dbashst}
  git clone https://github.com/${pkg} ${dst}
done
