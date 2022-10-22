Joplin_install() {{
  set -e
  VERSION="$(gh_latest_release laurent22/joplin)"
  VERSION=${VERSION#v}
  echo "Joplin Install Version ${VERSION}"
  DST=$APP_HOME/Joplin.AppImage
  curl -fL -o $DST "https://github.com/laurent22/joplin/releases/download/v${VERSION}/Joplin-${VERSION}.AppImage"
  chmod +x $DST
  curl -Lo $HOME/.local/share/icons/joplin.png 'https://raw.githubusercontent.com/laurent22/joplin/dev/Assets/LinuxIcons/1024x1024.png'

  tee $HOME/.local/share/applications/joplin.desktop << EOM
[Desktop Entry]
Version=1.0
Name=Joplin
Comment=Secured Notes
Exec=$DST %u
Icon=joplin
Type=Application
StartupWMClass=Joplin
EOM

  echo "Done!!"
}}

jetbrain_toolbox_install() {
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

u() {
  if command -v rustup > /dev/null; then
    rustup self update
    rustup update
  fi

  if command -v flatpak > /dev/null; then
    flatpak --user update -y
    flatpak --user uninstall --unused -y
  fi

  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}
