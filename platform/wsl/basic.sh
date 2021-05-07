#/bin/bash

set -ex

sudo apt update && sudo apt install -y curl wget python3-dev python3 python3-pip python3-venv

echo 'Add Git Repo'
sudo add-apt-repository ppa:git-core/ppa -y

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

echo 'Add Docker Repo'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable" -y

sudo apt-get remove gpg -y

packages=(
  zsh
  tmux
  htop
  zsh
  git-lfs
  git
  pinentry-tty
  openjdk-8-jdk
  openjdk-8-jre
  openjdk-11-jdk
  openjdk-11-jre
  jq
  nodejs
  gcc g++ make
  libmysqlclient-dev
  libssl-dev
  libpq-dev
  xsel # clipboard for vim
  docker-ce
  docker-ce-cli
  containerd.io
  gnupg1
)

# Install all
echo 'Install all package'
sudo apt-get update
sudo apt-get install -y "${packages[@]}"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo update-alternatives --config pinentry

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

sudo usermod -aG docker $USER
