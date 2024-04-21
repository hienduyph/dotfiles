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
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Italic/JetBrainsMonoNerdFont-Italic.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Italic/JetBrainsMonoNerdFontMono-Italic.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Light/JetBrainsMonoNerdFont-Light.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Light/JetBrainsMonoNerdFontMono-Light.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/ExtraLight/JetBrainsMonoNerdFont-ExtraLight.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/ExtraLight/JetBrainsMonoNerdFontMono-ExtraLight.ttf"
    curl -sLO "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Regular/RobotoMonoNerdFontMono-Regular.ttf"
    curl -slo /tmp/font.zip 'https://fonts.google.com/download?family=Roboto'
    unzip -d ${FONT_DIR} /tmp/font.zip
    fc-cache -fv
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
