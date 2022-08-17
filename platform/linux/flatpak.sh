#!/bin/bash

set -ex

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpaks=(
  org.gnome.Extensions
  io.dbeaver.DBeaverCommunity
  net.cozic.joplin_desktop
)
for pkg in "${flatpaks[@]}";do
  flatpak install flathub ${pkg} -y
done
