#!/bin/bash

set -e

_desktop_entry() {
  APP_DIR=~/.local/share/applications/
  mkdir -p  $APP_DIR

  read -d '' content << EOF || true
  [Desktop Entry]
  Version=1.0
  Name=WineHQ
  Comment=Official desktop version of winehq
  Exec=/usr/bin/x11docker --desktop --xorg --clipboard --pulseaudio --gpu --home x11docker/xfce-wine-playonlinux
  Icon=/usr/share/icons/wine.png
  Terminal=false
  StartupWMClass=Wine
  Type=Application
  Categories=Network;Qt;
  MimeType=x-scheme-handler/tg;
  Keywords=wine;windows
  X-GNOME-UsesNotifications=true
  X-Desktop-File-Install-Version=0.23
EOF

  echo "$content" | tee "$APP_DIR/wine.desktop"
}

_desktop_entry
