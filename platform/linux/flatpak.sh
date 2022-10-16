#!/bin/bash

set -ex

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpaks=(
  org.gnome.Extensions
  io.dbeaver.DBeaverCommunity
  org.mozilla.firefox
  org.telegram.desktop
  com.github.tchx84.Flatseal 
  com.visualstudio.code
)
for pkg in "${flatpaks[@]}";do
  flatpak install flathub ${pkg} -y
done
