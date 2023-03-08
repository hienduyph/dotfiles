#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
APP_ROOT="$(dirname "$SCRIPT_DIR")"

source $APP_ROOT/shell/vars.sh

_fonts() {
  FONT_DIR=""
  case "$1" in
    darwin)
      FONT_DIR="$HOME/Library/Fonts"
      ;;
    linux)
      FONT_DIR="$HOME/.local/share/fonts"
      ;;
    *)
      echo "Unsupport platform $1"
      exit;
  esac

  echo "Install fonts to ${FONT_DIR}"
  mkdir -p ${FONT_DIR}
  cd ${FONT_DIR} && {
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Light/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20Light.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Light/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20Mono%20Light.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/ExtraLight/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20ExtraLight.ttf?raw=true"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/ExtraLight/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20Mono%20ExtraLight.ttf?raw=true"
    curl -sLo 'Blex Mono Light Nerd Font Complete.ttf' 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/IBMPlexMono/Mono/complete/Blex%20Mono%20Light%20Nerd%20Font%20Complete.ttf'
    curl -sLo 'Blex Mono Light Nerd Font Complete.ttf' 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/IBMPlexMono/Mono/complete/Blex%20Mono%20Light%20Nerd%20Font%20Complete.ttf'
    curl -slo /tmp/font.zip 'https://fonts.google.com/download?family=Roboto'
    unzip -d ${FONT_DIR} /tmp/font.zip
  cd -; }
}

main() {
  _fonts $PLATFORM

  if [[ ${PLATFORM} == "darwin" ]]; then
    echo "macsetup"
  elif [[ ${PLATFORM} == "linux" ]]; then
    echo "linux UI"
  fi

}

main
