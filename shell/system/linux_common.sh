joplin_install() {{
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

u() {
  if command -v rustup > /dev/null; then
    rustup self update
    rustup update
  fi
  echo "Updating gopls"
  GO111MODULE=on go install golang.org/x/tools/gopls@latest

  echo "node pkg updates"
  npm i -g -u tree-sitter-cli pyright prettier typescript-language-server yaml-language-server typescript vscode-langservers-extracted bash-language-server

  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
