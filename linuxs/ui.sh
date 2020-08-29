install_fonts() {
  rm -rf /tmp/fonts
  mkdir -p rf /tmp/fonts
  curl -Lo /tmp/font.zip $1
  unzip /tmp/font.zip -d /tmp/fonts
  find /tmp/fonts -name \*.ttf -exec sudo cp {} /usr/share/fonts/truetype \;
}

install_fonts "https://github.com/IBM/plex/releases/download/v5.1.0/TrueType.zip"
install_fonts "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip"
install_fonts "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/IBMPlexMono.zip"
sudo apt install -y fonts-roboto
fc-cache -f -v

sudo apt install -y\
  gtk2-engines-murrine\
  gtk2-engines-pixbuf\
  sassc\
  optipng\
  inkscape

tar_url() {
  dest=$1
  url=$2
  curl -Lo /tmp/download.tar.gz $url
  mkdir -p /tmp/theme_src
  tar -xf /tmp/theme.tar.gz -C $dest --strip-components=1
}

tar_url "/tmp/theme_src" "https://github.com/vinceliuice/Mojave-gtk-theme/archive/2020-03-24.tar.gz"
cd /tmp/theme_src/ && ./install.sh -d $HOME/.local/share/themes

tar_url  /tmp/icon_src https://github.com/vinceliuice/McMojave-circle/archive/master.tar.gz
cd /tmp/icon_src  && ./install.sh -d $HOME/.local/share/icons -a
