sudo apt update && sudo apt install -y  curl wget python3-dev python3 python3-pip 
echo 'Add Chrome Repo'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
&& echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Albert
# echo 'Add Albert repo'
# echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
# curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home:manuelschneid3r.gpg > /dev/null
# 
# Git
echo 'Add Git Repo'
sudo add-apt-repository ppa:git-core/ppa -y

# enpass
echo 'Add Enpass Repo'
echo "deb https://apt.enpass.io/ stable main" | sudo tee /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo apt-key add -


echo 'Add Docker Repo'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"

echo 'Add Ibus Repo'
# ibus
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo

# Install all
echo 'Install all package'
sudo apt-get update
sudo apt-get install -y \
  zsh \
  google-chrome-stable\
  chrome-gnome-shell\
  gnome-tweak-tool \
  ttf-mscorefonts-installer\
  enpass \
  ibus-bamboo\
  snapd \
  telegram-desktop\
  docker-ce\
  docker-ce-cli\
  containerd.io\
  gnome-shell-pomodoro\
  tmux\
  htop\
  flameshot\
  zsh

sudo usermod -aG docker $USER

sudo systemctl start docker
sudo systemctl enable docker

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -sfL https://direnv.net/install.sh | sudo bash

ibus restart

