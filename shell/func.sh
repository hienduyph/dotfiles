
fkill() {
  ps aux | grep  $1 | awk {'print $2'} | xargs kill -9
}

go_mod_update() {
  go list -f '{{if not (or .Main .Indirect)}}{{.Path}}{{end}}' -m all | xargs -n 1 bash -c 'echo $0; go get -d $0 || true'
}

git_large_file() {
  git rev-list --objects --all |
    git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
    sed -n 's/^blob //p' |
    sort --numeric-sort --key=2 |
    cut -c 1-12,41- |
    $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

gh_latest_release() {
  curl -s "https://api.github.com/repos/$1/releases" | jq -r 'first | .tag_name'
}

gh_stable_release() {
  curl -s "https://api.github.com/repos/$1/releases/latest" | jq -r '.tag_name'
}

_pkg() {
	sudo dnf "$@"
}

_fedora_upgrade() {
  sudo dnf update -y && sudo dnf upgrade -y && sudo dnf autoremove -y
}

fedora_maintenance() {
  _fedora_upgrade
}

get_docker_ip() {
  echo "$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' $1)"
}

_gocryptfs() {
  VERSION=$(gh_latest_release rfjakob/gocryptfs)
  echo "Install ${VERSION}"
  mkdir -p $HOME/.local/bin
  curl -fsSL https://github.com/rfjakob/gocryptfs/releases/download/${VERSION}/gocryptfs_${VERSION}_linux-static_amd64.tar.gz | tar xz -C $HOME/.local/bin
  sudo cp $HOME/.local/bin/gocryptfs /usr/local/bin
}

_obsidianmd() {
  VERSION=$(gh_latest_release obsidianmd/obsidian-releases)
  VERSION=${VERSION#v}
  DST=$HOME/Applications/Obsidian.AppImage
  echo "Install obsidianmd version ${VERSION} to $DST"
  curl -Lo $DST "https://github.com/obsidianmd/obsidian-releases/releases/download/v${VERSION}/Obsidian-${VERSION}.AppImage"
  chmod +x $DST
  tee $HOME/.local/share/applications/obsidian.desktop << EOF
[Desktop Entry]
Name=Obsidian
Exec=$DST --ozone-platform=wayland @@u %u @@
Terminal=false
Type=Application
Icon=obsidian
StartupWMClass=obsidian
Comment=Obsidian
MimeType=x-scheme-handler/obsidian;
Categories=Office;
EOF

  tee $HOME/.local/share/applications/obsidian-x11.desktop << EOF
[Desktop Entry]
Name=Obsidian X11
Exec=$DST --ozone-platform=x11 @@u %u @@
Terminal=false
Type=Application
Icon=obsidian
StartupWMClass=obsidian
Comment=Obsidian
MimeType=x-scheme-handler/obsidian;
Categories=Office;
EOF
}

_lapce() {
  VERSION=$(gh_stable_release lapce/lapce)
  VERSION=${VERSION#v}
  DST=$HOME/Applications
  echo "Install Lapce Editor ${VERSION} to $DST"
  curl -fsSL "https://github.com/lapce/lapce/releases/download/v${VERSION}/Lapce-linux.tar.gz" | tar xz -C $DST --strip-components=1

  ICON_DIR=$HOME/.local/share/icons/hicolor/256x256/apps
  mkdir -p $ICON_DIR
  curl -Lo $ICON_DIR/lapce.png "https://raw.githubusercontent.com/lapce/lapce/master/extra/images/logo.png"
  tee $HOME/.local/share/applications/lapce.desktop << EOF
[Desktop Entry]
Name=Lapce
Exec=$DST/lapce %U
Terminal=false
Type=Application
Icon=lapce
StartupWMClass=obsidian
Comment=Text Editor
MimeType=text/plain;application/x-zerosize;
Keywords=write;notepad;
DBusActivatable=true
Categories=Utility;TextEditor;
EOF
}

optimize_png_dir() {
  # directory containing images
  input_dir="$1"

  if [[ -z "$input_dir" ]]; then
    echo "Please specify an input directory."
    exit 1
  fi

  find $input_dir -type f -iname "*.png" -print0 | while read -d $'\0' img
  do
    echo "Working on ${img}"
    optipng "${img}"
  done
}
