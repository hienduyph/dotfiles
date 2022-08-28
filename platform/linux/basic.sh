#/bin/bash

source $HOME/dotfiles/shell/func.sh

set -ex

_py() {
  python3.9 -m ensurepip --user
  python3.9 -m pip install virtualenv
  python3.8 -m ensurepip --user
  python3.8 -m pip install virtualenv
}

_jetbrains() {
  # Note that we grep for linux here, if you are using this on mac/windows please see json output
  TOOLBOX_URL=$(curl --silent 'https://data.services.jetbrains.com//products/releases?code=TBA&latest=true&type=release' \
      -H 'Origin: https://www.jetbrains.com' \
      -H 'Accept-Encoding: gzip, deflate, br' \
      -H 'Accept-Language: en-US,en;q=0.8' \
      -H 'Accept: application/json, text/javascript, */*; q=0.01' \
      -H 'Referer: https://www.jetbrains.com/toolbox/download/' \
      -H 'Connection: keep-alive' \
      -H 'DNT: 1' \
      --compressed \
    | grep -Po '"linux":.*?[^\\]",' \
    | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')

  curl -fsSL ${TOOLBOX_URL} | tar xz --directory=${HOME}/.local/bin --strip-components=1
}

_sccache() {
  if ! command -v sccache &> /dev/null
  then
    VERSION=0.3.0
    curl -fsSL https://github.com/mozilla/sccache/releases/download/v${VERSION}/sccache-v${VERSION}-x86_64-unknown-linux-musl.tar.gz | sudo tar zx -C /usr/local/bin --strip-components=1
    sudo chmod +x /usr/local/bin/sccache
  fi
}

_telegram() {
  DST=/opt/Telegram
  _linux_telegram $DST
  sudo curl -fsSL -o /usr/share/icons/telegram.png 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/512px-Telegram_logo.svg.png'

  sudo tee /usr/local/share/applications/telegramdesktop.desktop << EOM
[Desktop Entry]
Version=1.5
Name=Telegram Desktop
Comment=Official desktop version of Telegram messaging app
TryExec=$DST/Telegram
Exec=$DST/Telegram -- %u
Icon=telegram.png
Terminal=false
StartupWMClass=TelegramDesktop
Type=Application
Categories=Chat;Network;InstantMessaging;Qt;
MimeType=x-scheme-handler/tg;
Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
Actions=Quit;
SingleMainWindow=true
X-GNOME-UsesNotifications=true
X-GNOME-SingleWindow=true

[Desktop Action Quit]
Exec=${DST}/Telegram -quit
Name=Quit Telegram
Icon=application-exit

EOM
}

_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

_ibus() {
  dconf load /desktop/ibus/ < ibus.dconf
}
_fcitx() {
  sudo tee /etc/environment << EOF
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF
}

_ff() {
  curl -fsL -o /tmp/ff.tar.bz2 'https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US'
  DST=/opt/firefox-dev
  sudo rm -rf ${DST}
  sudo mkdir -p ${DST}
  sudo tar -xf /tmp/ff.tar.bz2 -C $DST --strip-components=1
  sudo curl -Lo /usr/share/icons/firefox-dev.png 'https://upload.wikimedia.org/wikipedia/commons/6/68/Firefox_Developer_Edition_logo%2C_2017.png'

  sudo tee /usr/local/share/applications/firefox-dev.desktop << EOM
[Desktop Entry]
Version=1.0
Name=Firefox Developer
Exec=/opt/firefox-dev/firefox %u
Icon=firefox-dev
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;
X-Desktop-File-Install-Version=0.26

[Desktop Action new-window]
Name=Open a New Window
Exec=/opt/firefox-dev/firefox --new-window %u

[Desktop Action new-private-window]
Name=Open a New Private Window
Exec=/opt/firefox-dev/firefox --private-window %u

[Desktop Action profile-manager-window]
Name=Open the Profile Manager
Exec=/opt/firefox-dev/firefox --ProfileManager

EOM

}

main() {
  _py
  _jetbrains
  _rust
  _telegram
  sudo curl -fSsLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.27.2/yq_linux_amd64 && sudo chmod +x /usr/local/bin/yq
}


if [[ $_ == $0 ]]; then
  main
else
  echo "Sourced"
fi

