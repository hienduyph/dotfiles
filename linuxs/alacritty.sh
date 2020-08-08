# prepare to build alacritty

sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 -y
curl -Lo /tmp/ala_src.tar.gz https://github.com/alacritty/alacritty/archive/v0.5.0.tar.gz
mkdir -p ./alacritty_src
tar -xf /tmp/ala_src.tar.gz -C alacritty_src --strip-components=1

cd ./alacritty_src && cargo build --release

sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database


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




fc-cache -f -v
