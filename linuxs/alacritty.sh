# prepare to build alacritty
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 -y
curl -Lo /tmp/ala_src.tar.gz https://github.com/alacritty/alacritty/archive/v0.5.0.tar.gz
mkdir -p ./alacritty_src
tar -xf /tmp/ala_src.tar.gz -C alacritty_src --strip-components=1

cd ./alacritty_src && PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig cargo build --release

sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

echo "Set alacritty"
mv ~/.alacritty.yml ~/.alacritty.yml.bak || true
ln -s $HOME/dotfiles/linuxs/alacritty.yml ~/.alacritty.yml
