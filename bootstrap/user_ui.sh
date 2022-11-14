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
    BASE=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures
    curl -Lo 'JetBrains Mono Light Nerd Font Complete.ttf' "${BASE}/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete.ttf"
    curl -Lo 'JetBrains Mono Light Nerd Font Complete Mono.ttf' "${BASE}/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete%20Mono.ttf"
    curl -Lo 'JetBrains Mono ExtraLight Nerd Font Complete Mono.ttf' "${BASE}/ExtraLight/complete/JetBrains%20Mono%20ExtraLight%20Nerd%20Font%20Complete%20Mono.ttf"
  cd -; }
}

_ibus() {
  tee $HOME/.config/autostart/ibus-daemon.desktop << EOF
[Desktop Entry]
Type=Application
Name=IBus Daemon
Exec=ibus-daemon --xim -d -r

EOF
}

_shot() {
  tee $HOME/.local/share/applications/swappy.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=Swappy
Comment=Annonate image from clipboard
Exec=wl-paste | swappy -f -
Icon=org.gnome.Screenshot
Type=Application
Categories=Office;
EOF
}

_apps() {
  CURR=$(pwd)
  cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

  tee $HOME/.local/share/applications/dropbox.desktop << EOF
[Desktop Entry]
Name=Dropbox
Comment=Dropbox Daemon
Exec=/home/$USER/.dropbox-dist/dropboxd
Icon=dropbox
Type=Application
Categories=Office;
EOF

  ln -sf $HOME/.local/share/applications/dropbox.desktop  $HOME/.config/autostart/
  cd $CURR
}

main() {
  _fonts $PLATFORM

  if [[ ${PLATFORM} == "darwin" ]]; then
    echo "macsetup"
  elif [[ ${PLATFORM} == "linux" ]]; then
    mkdir -p $HOME/.local/share/icons/ $HOME/.config/autostart/ $APP_HOME
    _shot
    _apps
  fi

}

main
