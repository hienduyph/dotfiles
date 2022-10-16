#!/usr/bin/env bash

_telegram() {
  TELE_VERSION="$(gh_latest_release telegramdesktop/tdesktop)"
  TELE_VERSION=${TELE_VERSION#v}
  DST=$APP_HOME/Telegram
  mkdir -p $DST
  curl -fSL "https://github.com/telegramdesktop/tdesktop/releases/download/v${TELE_VERSION}/tsetup.${TELE_VERSION}.tar.xz" | tar x -J -C $APP_HOME/Telegram --strip-components=1
  ln -sf $APP_HOME/Telegram/Telegram $HOME/.local/bin
}

_firefox_dev() {
  DST=$APP_HOME/firefox-developer
  mkdir -p $DST
  curl -fL -o /tmp/ff.tar.bz2 'https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US'
  tar -xf /tmp/ff.tar.bz2  -C $DST --strip-components=1
  curl -Lo $HOME/.local/share/icons/firefox-dev.png 'https://upload.wikimedia.org/wikipedia/commons/6/68/Firefox_Developer_Edition_logo%2C_2017.png'
  rm /tmp/ff.tar.bz2

  tee $HOME/.local/share/applications/firefox-dev.desktop << EOM
[Desktop Entry]
Version=1.0
Name=Firefox Developer
Exec=$DST/firefox-bin %u
Icon=firefox-developer-edition
Comment=Firefox Browser Developer Edition
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
Categories=Network;WebBrowser;
StartupWMClass=firefox-aurora
EOM
}

_ibus() {
  tee $HOME/.config/autostart/ibus-daemon.desktop << EOF
[Desktop Entry]
Type=Application
Name=IBus Daemon
Exec=ibus-daemon --xim -d -r

EOF
}

_shot() {
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
}


main() {
  mkdir -p $HOME/.local/share/icons/
  mkdir -p $APP_HOME

  _shot
  _ibus
}

main
