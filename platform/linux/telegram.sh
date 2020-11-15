#!/bin/bash
set -e

_download() {
  VERSION=$(curl -fsSL https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest | jq -r ".tag_name" | cut -d'v' -f 2)
  curl -Lo /tmp/file.tar.gz https://github.com/telegramdesktop/tdesktop/releases/download/v$VERSION/tsetup.$VERSION.tar.xz
  sudo mkdir -p /opt/
  sudo tar -xf /tmp/file.tar.gz -C /opt
  rm -f /tmp/file.tar.gz
}


_desktop_entry() {
  APP_DIR=~/.local/share/applications/
  mkdir -p  $APP_DIR

  read -d '' content << EOF || true
  [Desktop Entry]
  Version=1.0
  Name=Telegram
  Comment=Official desktop version of Telegram messaging service
  TryExec=/opt/Telegram/Telegram
  Exec=/opt/Telegram/Telegram -- %u
  Icon=/usr/share/icons/telegram.png
  Terminal=false
  StartupWMClass=TelegramDesktop
  Type=Application
  Categories=Network;InstantMessaging;Qt;
  MimeType=x-scheme-handler/tg;
  Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
  X-GNOME-UsesNotifications=true
  X-Desktop-File-Install-Version=0.23
EOF

  echo "$content" | tee "$APP_DIR/telegramdesktop.desktop"
}

sudo curl -Lo /usr/share/icons/telegram.png https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Telegram_Messenger.png/600px-Telegram_Messenger.png
_download
_desktop_entry
