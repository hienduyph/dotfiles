#!/bin/bash
local APP_ROOT="$(dirname "$(readlink -fm "$0")")"
flatpak -user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
cp /usr/share/icons ~/.icons -r
flatpak --user override --filesystem=/home/$USER/.icons/:ro
flatpak -user  override --env=QT_WAYLAND_DECORATION=material
flatpak run --env=QT_STYLE_OVERRIDE=kvantum --filesystem=xdg-config/Kvantum:ro

while IFS= read -r line; do
  flatpak --user install -y $line
done < $APP_ROOT/apps.txt

