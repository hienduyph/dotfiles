#/bin/bash

set -ex

sudo apt update && sudo apt install -y curl wget python3-dev python3 python3-pip python3-venv
echo 'Add Chrome Repo'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
&& echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

echo 'Add Git Repo'
sudo add-apt-repository ppa:git-core/ppa -y

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

# enpass
echo 'Add Enpass Repo'
echo "deb https://apt.enpass.io/ stable main" | sudo tee /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo apt-key add -


echo 'Add Docker Repo'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable" -y

echo 'Add Ibus Repo'
# ibus
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo -y

echo 'Add alacritty'
sudo add-apt-repository ppa:mmstick76/alacritty -y

echo 'Add vlc'
sudo add-apt-repository ppa:videolan/stable-daily -y

sudo add-apt-repository ppa:serge-rider/dbeaver-ce -y

packages=(
  zsh
  google-chrome-stable
  chrome-gnome-shell
  gnome-tweak-tool
  ttf-mscorefonts-installer
  enpass
  ibus-bamboo
  snapd
  docker-ce
  docker-ce-cli
  containerd.io
  gnome-shell-pomodoro
  tmux
  htop
  flameshot
  zsh
  ufw
  dnscrypt-proxy
  git-lfs
  git
  alacritty
  pinentry-tty
  openjdk-8-jdk
  openjdk-8-jre
  openjdk-11-jdk
  openjdk-11-jre
  jq
  lm-sensors
  psensor
  anki
  nodejs
  gcc g++ make
  libmysqlclient-dev
  libssl-dev
  libpq-dev
  dbeaver-ce
)

# Install all
echo 'Install all package'
sudo apt-get update
sudo apt-get install -y "${packages[@]}"

sudo usermod -aG docker $USER

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -sfL https://direnv.net/install.sh | sudo bash

ibus restart

services=(
  docker
  dnscrypt-proxy
)

for pkg in "${services[@]}"; do
  sudo systemctl start $pkg
  sudo systemctl enable $pkg
done

sudo update-alternatives --config pinentry

wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

sudo snap install intellij-idea-community --classic
sudo snap install code --classic

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -