#!//usr/bin/env bash

APP_ROOT="$(dirname "$(readlink -fm "$0")")"
echo $APP_ROOT

fp() {
	flatpak --user $@
}

fp remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

_all() {
while IFS= read -r line; do
  fp install -y $line
done < $APP_ROOT/apps.txt
}

_all
