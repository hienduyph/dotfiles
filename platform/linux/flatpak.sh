#!//usr/bin/env bash

APP_ROOT="$(dirname "$(readlink -fm "$0")")"
echo $APP_ROOT

fp() {
	flatpak --user $@
}

fp remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

while IFS= read -r line; do
  fp install -y $line
done < $APP_ROOT/apps.txt

cp -r /usr/share/icons ~/.icons
fp override --filesystem=/home/$USER/.icons/:ro
fp override --env=QT_WAYLAND_DECORATION=material
fp override --env=GTK_THEME=Adwaita-dark
fp override --filesystem=/usr/share/themes/
