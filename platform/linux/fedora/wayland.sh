#!/usr/bin/env bash

sudo dnf install -y  wl-clipboard xlsclients swappy flameshot

DST=/usr/bin/start-gdm-wayland
sudo tee $DST << EOF
#!/bin/bash

export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DISABLE_RDD_SANDBOX=1
export XDG_SESSION_TYPE=wayland

# GTK
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland

# qt stuff
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DECORATION=material

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

exec /usr/bin/gnome-session
EOF

sudo chmod +x $DST

sudo tee /usr/share/wayland-sessions/gdm-wayland.desktop  << EOF
[Desktop Entry]
Name=HienGnome
Comment=Force GNOME runs wayland for everything
Exec=$DST
Type=Application
EOF
