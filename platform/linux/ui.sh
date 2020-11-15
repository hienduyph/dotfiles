_install_fonts_fn() {
  rm -rf /tmp/fonts
  mkdir -p rf /tmp/fonts
  curl -Lo /tmp/font.zip $1
  unzip /tmp/font.zip -d /tmp/fonts
  find /tmp/fonts -name \*.ttf -exec sudo cp {} /usr/share/fonts/truetype \;
}

fonts() {
  sudo apt install -y fonts-roboto
  fc-cache -f -v
}

theme_deps() {
  sudo apt install -y\
    libcanberra-gtk-module libcanberra-gtk3-module\
    gtk2-engines-murrine\
    gtk2-engines-pixbuf\
    sassc\
    optipng\
    inkscape\
    gtk2-engines-murrine gtk2-engines-pixbuf\
    libglib2.0-dev-bin
  sudo apt remove gnome-shell-extension-ubuntu-dock -y
}


download_themes() {
  mkdir -p /tmp/theme_src
  curl -fsSL https://github.com/vinceliuice/Mojave-gtk-theme/archive/2020-03-24.tar.gz | tar xz -C /tmp/theme_src --strip-components=1
  cd /tmp/theme_src/ && ./install.sh -d $HOME/.local/share/themes -c dark
  rm -rf /tmp/theme_src
}

download_icons() {
  mkdir /tmp/icon_src
  curl -fsSL https://github.com/vinceliuice/McMojave-circle/archive/master.tar.gz | tar xz -C /tmp/icon_src --strip-components=1
  cd /tmp/icon_src  && ./install.sh -d $HOME/.local/share/icons -a
  rm -rf /tmp/icon_src
}


main() {
  fonts
  theme_deps
  download_themes
  download_icons
}

main
