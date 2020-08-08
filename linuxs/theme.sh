
sudo apt install gtk2-engines-murrine gtk2-engines-pixbuf -y
sudo apt install sassc optipng inkscape -y
curl -Lo /tmp/theme.tar.gz https://github.com/vinceliuice/Mojave-gtk-theme/archive/2020-03-24.tar.gz
mkdir -p /tmp/theme_src
tar -xf /tmp/theme.tar.gz -C /tmp/theme_src --strip-components=1
cd /tmp/theme_src/ && ./install.sh -d $HOME/.local/share/themes

curl -Lo /tmp/icon.tar.gz https://github.com/vinceliuice/McMojave-circle/archive/master.tar.gz
mkdir -p /tmp/icon_src
tar -xf /tmp/icon.tar.gz -C /tmp/icon_src --strip-components=1
cd /tmp/icon_src  && ./install.sh -d $HOME/.local/share/icons -a
