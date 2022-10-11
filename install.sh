#!/usr/bin/env bash
set -x

source $HOME/dotfiles/scripts/dotfiles.sh
source $HOME/dotfiles/shell/func.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

_mac() {
  echo "Setting mac links"
  sudo ln -sf /opt/homebrew/bin/bash /usr/local/bin/bash
}

_linux() {
  sudo tee /etc/systemd/resolved.conf << EOM
[Resolve]
DNS=127.0.0.1
FallbackDNS=8.8.8.8
EOM
  sudo mkdir -p /etc/dnscrypt-proxy
  sudo cp $HOME/dotfiles/.config/dnscrypt-proxy.toml /etc/dnscrypt-proxy/
  sudo touch /etc/dnscrypt-proxy/forwarding-rules.txt

  sleep 5

  sudo systemctl restart systemd-resolved
  sudo systemctl restart dnscrypt-proxy
}

__system() {
  _fonts $PLATFORM
  _system
  _py_cli
  _cli
  if [ ${PLATFORM} == "darwin" ]; then
    _mac
  elif [ ${PLATFORM} == "linux" ]; then
    _linux
  fi
}

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
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
Categories=Network;WebBrowser;
StartupWMClass=firefox-aurora
EOM
}


_linux_user() {
  mkdir -p $HOME/.local/share/icons/
  mkdir -p $APP_HOME
  _telegram
  _firefox_dev

  mkdir -p ~/.gnupg
  tee ~/.gnupg/gpg-agent.conf << EOF
pinentry-program $(which pinentry-curses)
EOF
}
__users() {
  _dots $PLATFORM
  _configs $PLATFORM
  _git
  _ranger
  _neovim
  _cmp
  if [ ${PLATFORM} == "darwin" ]; then
    _mac
  elif [ ${PLATFORM} == "linux" ]; then
    _linux_user
  fi
}

main() {
  if [ $1 == "system" ]; then
    __system
    exit 0;
  fi
  __users
}

main
