#!/usr/bin/env bash

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

_apps() {
  _dropbox
  cp $APP_ROOT/.local/share/applications/* $HOME/.local/share/applications/
  ln -sf $HOME/.local/share/applications/dropbox.desktop  $HOME/.config/autostart/
}

mkdir -p $HOME/.local/share/icons/ $HOME/.config/autostart/ $APP_HOME
_apps
