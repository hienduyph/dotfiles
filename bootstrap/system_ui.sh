#!/usr/bin/env bash

source $HOME/dotfiles/shell/vars.sh

_fonts() {
  FONT_DIR=""
  case "$1" in
    darwin)
      FONT_DIR="/Library/Fonts"
      ;;
    linux)
      FONT_DIR="/usr/local/share/fonts"
      ;;
    *)
      echo "Unsupport platform $1"
      exit;
  esac
  sudo mkdir -p ${FONT_DIR}
  cd ${FONT_DIR} && {
    BASE=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures
    sudo curl -Lo 'JetBrains Mono Light Nerd Font Complete.ttf' "${BASE}/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete.ttf"
    sudo curl -Lo 'JetBrains Mono Light Nerd Font Complete Mono.ttf' "${BASE}/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete%20Mono.ttf"
    sudo curl -Lo 'JetBrains Mono ExtraLight Nerd Font Complete Mono.ttf' "${BASE}/ExtraLight/complete/JetBrains%20Mono%20ExtraLight%20Nerd%20Font%20Complete%20Mono.ttf"
  cd -; }
}

main() {
  _fonts $PLATFORM
}

main
