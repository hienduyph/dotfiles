#!/bin/bash

_gnome() {
  echo "Settings some gnome configs"
  gsettings set org.gnome.shell.window-switcher app-icon-mode 'app-icon-only'
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-input-source '["<Control>space"]'
  gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward '["<Shift><Control>space"]'

  # name binding command
  cmds=(
    "Spotlight" "<Alt>space" "albert toggle"
    "Shot" "<Control><Alt>4" "flameshot gui"
  )
  totals=$((${#cmds[@]}/3))
  echo "Settings up ${totals} custom commands"
  for(( i=0; i < $totals; i++ )); do
    offset=$((i*3))
    name=${cmds[offset]}
    binding=${cmds[offset+1]}
    cmd=${cmds[offset+2]}
    path="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/"
    echo "Settings keys ${i} -> $name $binding $cmd"
    gsettings set $path name "${name}"
    gsettings set $path binding "${binding}"
    gsettings set $path command "${cmd}"
  done
}

_gnome
