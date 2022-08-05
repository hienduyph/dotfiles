#!/bin/bash

sudo dnf install -y xdg-desktop-portal xdg-desktop-portal-wlr grim wlr-randr sway dex-autostart rofi waybar

sudo tee /usr/bin/start-sway << EOF
#!/bin/bash

export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway

exec sway --unsupported-gpu
EOF

sudo chmod +x /usr/bin/start-sway

sudo tee /usr/share/wayland-sessions/sway.desktop  << EOF
[Desktop Entry]
Name=Sway
Comment=An i3-compatible Wayland compositor
Exec=/usr/bin/start-sway
Type=Application
EOF
