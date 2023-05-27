# Sway


HDPI Setup
```bash
./platform/linux/fedora/sway.sh "QT_AUTO_SCREEN_SCALE_FACTOR=0 QT_SCALE_FACTOR=1.5 ELM_SCALE=1.5"

```

```
output DP-2  {
 scale 1.5
}

set $cursor_size 24

# GTK
# This is the only place where you must set GTK scaling
# https://gist.github.com/Zeioth/d8c1fd75b5721c2170b4a2a5f19a986e
set $gnome-schema org.gnome.desktop.interface
exec_always {
  # gsettings set $gnome-schema gtk-theme 'Matcha-dark-sea'
  # gsettings set $gnome-schema icon-theme 'Numix-Square'
  gsettings set org.gnome.desktop.interface text-scaling-factor 1
  gsettings set org.gnome.desktop.interface cursor-size $cursor_size
  gsettings set org.gnome.desktop.interface font-name "Liberation Sans 11"
}
```

## On multi devices

```bash
export WLR_DRM_DEVICES=/dev/dri/card0 
exec sway --unsupported-gpu
```

```bash
# makesure checking the device correctly
udevadm info -a -n /dev/dri/card0
```
