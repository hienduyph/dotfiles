#!/bin/bash

set -ex

_fp() {
  flatpak --user $@
}

_fp remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpaks=(
  com.google.Chrome
  org.gnome.Extensions
  io.dbeaver.DBeaverCommunity
  org.mozilla.firefox
  org.telegram.desktop
  com.github.tchx84.Flatseal 
  com.visualstudio.code
  org.keepassxc.KeePassXC
  net.cozic.joplin_desktop
)
for pkg in "${flatpaks[@]}";do
  _fp install flathub ${pkg} -y
done

cp /usr/share/icons ~/.icons -r

_fp override --filesystem=/home/$USER/.icons/:ro
_fp override --env=QT_WAYLAND_DECORATION=material
