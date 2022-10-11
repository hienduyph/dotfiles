#!/usr/bin/env bash
sudo dnf install wl-clipboard 

DST=/usr/bin/start-gdm-wayland
sudo tee $DST << EOF
#!/bin/bash

export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export QT_SCALE_FACTOR=1.5

exec gnome-session
EOF

sudo chmod +x $DST

sudo tee /usr/share/wayland-sessions/gdm-wayland.desktop  << EOF
[Desktop Entry]
Name=Wayland
Comment=Q custom wayland starter
Exec=$DST
Type=Application
EOF

tee $HOME/.local/share/applications/swappy.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=Swappy
Comment=Annonate image from clipboard
Exec=wl-paste | swappy -f -
Icon=org.gnome.Screenshot
Type=Application
Categories=Office;
EOF
