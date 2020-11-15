#!/bin/bash

set -e

set_custom_key() {
  echo "Setting $1 $2 $3"
  sudo dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'$1'"
  sudo dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'$2'"
  sudo dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'$3'"
}

set_custom_key 'Screenshot' '<Shift><Alt>$' 'flameshot gui'
