#!/usr/bin/env bash
APP_ROOT="$(dirname "$(readlink -fm "$0")")"

keys=(
  /org/gnome/shell/
  /org/gnome/desktop/
  /org/gnome/mutter/
  /org/gnome/settings-daemon/
)
files=(
  $APP_ROOT/dconf/shell.dconf
  $APP_ROOT/dconf/desktop.dconf
  $APP_ROOT/dconf/mutter.dconf
  $APP_ROOT/dconf/settings.dconf
)

_load() {
  for i in "${!keys[@]}"; do 
    printf "Load \t%s\n" "${files[$i]}" "${files[$i]}"
    dconf load "${keys[$i]}" < "${files[$i]}"
  done
}

_dump() {
  for i in "${!keys[@]}"; do 
    printf "Dump \t%s\n" "${files[$i]}" "${files[$i]}"
    dconf dump "${keys[$i]}" > "${files[$i]}"
  done
}


_theme() {
  local workdir=/tmp/theme
  mkdir $workdir
  git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git $workdir
  $workdir/install.sh -t default -a -b
  rm -rf $workdir
}


if [[ $1 == "load" ]]; then
  _load
elif [[ $1 == "dump" ]]; then
  _dump
elif [[ $1 == "theme" ]]; then
  _theme
else
  echo "Require load or dump"
  exit 1
fi
