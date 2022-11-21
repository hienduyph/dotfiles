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

fp override --filesystem=/home/$USER/.icons/:ro \
  --env=QT_WAYLAND_DECORATION=material \
  --env=GTK_THEME=Adwaita-dark \
  --filesystem=/usr/share/themes/ \
  --socket=wayland\
  --nosocket=x11 \
  --nosocket=fallback-x11\
  --device=dri

fp override --env=MOZ_DISABLE_RDD_SANDBOX=1 org.mozilla.firefox
