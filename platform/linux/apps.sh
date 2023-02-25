#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
APP_ROOT="$(dirname "$SCRIPT_DIR")"
APP_ROOT="$(dirname "$APP_ROOT")"

_dropbox() {
  CURR=$(pwd) && cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - && cd $CURR
  tee $HOME/.local/share/applications/dropbox.desktop  << EOF
[Desktop Entry]
Name=Dropbox
Comment=Dropbox Daemon
Exec=/home/$USER/.dropbox-dist/dropboxd
Icon=dropbox
Categories=Office
Type=Application

EOF
}

_tele() {
  VERSION=$1
  mkdir -p $HOME/Applications
  curl -fsSL "https://github.com/telegramdesktop/tdesktop/releases/download/v${VERSION}/tsetup.${VERSION}.tar.xz" | tar xJ -C $HOME/Applications
}

_apps() {
  _dropbox
  _tele 4.6.3
  cp $APP_ROOT/.local/share/applications/* $HOME/.local/share/applications/
  ln -sf $HOME/.local/share/applications/dropbox.desktop  $HOME/.config/autostart/
}

mkdir -p $HOME/.local/share/icons/ $HOME/.config/autostart/ $APP_HOME
_apps
