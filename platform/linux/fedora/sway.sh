#!/bin/bash
CUSTOM_EXPORTS=()
# QT_AUTO_SCREEN_SCALE_FACTOR=0 QT_SCALE_FACTOR=1.5 ELM_SCALE=1.5
for kv in $(echo $1 | tr " " "\n"); do
  CUSTOM_EXPORTS+=("export ${kv}")
done

# https://github.com/fairyglade/ly/issues/228#issuecomment-756742472
sudo dnf copr enable erikreider/SwayNotificationCenter
sudo dnf install -y xdg-desktop-portal xdg-desktop-portal-wlr grim slurp wlr-randr sway dex-autostart waybar rofi-wayland wev \
  fcitx5 fcitx5-gtk fcitx5-qt fcitx5-unikey wlsunset pavucontrol blueman wf-recorder  \
  kvantum swappy network-manager-applet eog nautilus SwayNotificationCenter

if [ -f $HOME/.cargo/bin/cargo ]; then
  $HOME/.cargo/bin/cargo install sworkstyle
  sudo cp $HOME/.cargo/bin/sworkstyle /usr/local/bin
fi

sudo tee /usr/bin/start-sway << EOF
#!/bin/bash

export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DISABLE_RDD_SANDBOX=1
export XDG_SESSION_TYPE=wayland
export _JAVA_AWT_WM_NONREPARENTING=1

# GTK
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland

# qt stuff
export QT_QPA_PLATFORM=wayland
export QT_STYLE_OVERRIDE=kvantum

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway

export GTK_IM_MODULE=fcitx
export GTK_THEME=Adwaita:light
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export CALIBRE_USE_DARK_PALETTE=1

eval \$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

${CUSTOM_EXPORTS[@]}

exec sway
EOF

sudo chmod +x /usr/bin/start-sway

sudo tee /usr/share/wayland-sessions/sway-secured.desktop  << EOF
[Desktop Entry]
Name=Sway Secured
Comment=An i3-compatible Wayland compositor
Exec=/usr/bin/start-sway
Type=Application
EOF

