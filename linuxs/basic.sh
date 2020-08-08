# Install main package echo 'Install basic package'
sudo apt-get update && sudo apt-get install curl wget python3-dev -y

# Sublime
echo 'Install Sublime'
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Chrome
echo 'Install Chrome'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
&& echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Albert

echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home:manuelschneid3r.gpg > /dev/null

# Git
echo 'Install Git'
sudo add-apt-repository ppa:git-core/ppa -y

# enpass
echo "deb https://apt.enpass.io/ stable main" | sudo tee /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo apt-key add -


# ibus
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo

# Numix Theme
# echo 'Install Numix Theme'
#sudo add-apt-repository ppa:numix/ppa -y

# Pomodo indicator
# echo 'Install pomodoro indicator'
# sudo add-apt-repository ppa:atareao/atareao -y

# Flat icons
# sudo add-apt-repository ppa:noobslab/icons -y

# Install all
echo 'Install all package'
sudo apt-get update
sudo apt-get install -y \
  zsh \
  google-chrome-stable\
  chrome-gnome-shell\
  gnome-tweak-tool \
  dconf-tools\
  ttf-mscorefonts-installer\
  enpass \
  albert \
  ibus-bamboo\
  snapd


# # copy style and desktop icon
# echo "Copy style and desktop icons"
# mkdir -p ~/.themes/Q/gnome-shell
# cp css/* ~/.themes/Q/gnome-shell/
# cp desktops/* ~/.local/share/applications/

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -sfL https://direnv.net/install.sh | bash

