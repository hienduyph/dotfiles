#!/bin/bash

set -ex

flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpaks=(
  com.google.Chrome
  org.gnome.Extensions
  io.dbeaver.DBeaverCommunity
  org.mozilla.firefox
  org.telegram.desktop
  com.github.tchx84.Flatseal 
  com.visualstudio.code
  org.keepassxc.KeePassXC
)
for pkg in "${flatpaks[@]}";do
  flatpak --user install flathub ${pkg} -y
done

cp /usr/share/icons ~/.icons -r

flatpak --user override --filesystem=/home/$USER/.icons/:ro
