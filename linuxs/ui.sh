_install_fonts_fn() {
  rm -rf /tmp/fonts
  mkdir -p rf /tmp/fonts
  curl -Lo /tmp/font.zip $1
  unzip /tmp/font.zip -d /tmp/fonts
  find /tmp/fonts -name \*.ttf -exec sudo cp {} /usr/share/fonts/truetype \;
}
_tar_url() {
  dest=$1
  url=$2
  rm -rf /tmp/download.tar.gz
  curl -Lo /tmp/download.tar.gz $url
  rm -rf $dest
  mkdir -p $dest
  tar -xf /tmp/download.tar.gz -C $dest --strip-components=1
}

fonts() {
  _install_fonts_fn "https://github.com/IBM/plex/releases/download/v5.1.0/TrueType.zip"
  _install_fonts_fn "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip"
  _install_fonts_fn "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/IBMPlexMono.zip"
  _install_fonts_fn "https://github.com/ToxicFrog/Ligaturizer/releases/download/v4/LigaturizedFonts.zip"
  _install_fonts_fn "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip"
  _install_fonts_fn "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.002/JetBrainsMono-2.002.zip"
  _install_fonts_fn "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip"
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
  _tar_url "/tmp/theme_src" "https://github.com/vinceliuice/Mojave-gtk-theme/archive/2020-03-24.tar.gz"
  cd /tmp/theme_src/ && ./install.sh -d $HOME/.local/share/themes -c dark
}

download_icons() {
  _tar_url /tmp/icon_src https://github.com/vinceliuice/McMojave-circle/archive/master.tar.gz
  cd /tmp/icon_src  && ./install.sh -d $HOME/.local/share/icons -a
}


main() {
  fonts
  theme_deps
  download_themes
  download_icons
}

_install_fonts_fn "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
