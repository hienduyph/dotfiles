#!/usr/bin/env bash

gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

sudo tee /usr/share/glib-2.0/schemas/99_hidpi.gschema.override << EOF
[org.gnome.desktop.interface]
scaling-factor=1
text-scaling-factor=1.5
EOF
sudo glib-compile-schemas /usr/share/glib-2.0/schemas
