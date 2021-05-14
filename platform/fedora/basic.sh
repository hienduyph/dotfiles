#/bin/bash

set -ex

_pkg() {
	sudo dnf "$@"
}

_pkg update && _pkg install -y curl wget python3.9 python3.9-pip liberation-fonts dnf-plugins-core

echo "Add brave"
_pkg config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/\
  && sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

echo 'Add Enpass Repo'
_pkg config-manager --add-repo  https://yum.enpass.io/enpass-yum.repo

echo 'Add Ibus Repo'
_pkg config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_Rawhide/home:lamlng.repo

echo 'Add albert'
sudo rpm --import https://build.opensuse.org/projects/home:manuelschneid3r/public_key
_pkg config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_33/home:manuelschneid3r.repo

echo 'Add Docker Repo'
_pkg config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -

packages=(
  zsh
  enpass
  ibus-bamboo
  flameshot
  dnscrypt-proxy
  git-lfs
  git
  albert
  docker-ce
  docker-ce-cli
  containerd.io
  g++ libstdc++-devel libstdc++
  nodejs
  java-11-openjdk
  java-11-openjdk-devel
  xclip
  brave-browser
)

# Install all
echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo usermod -aG docker $USER

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

ibus restart

services=(
  dnscrypt-proxy
  docker
)

for pkg in "${services[@]}"; do
  sudo systemctl start $pkg
  sudo systemctl enable $pkg
done

wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

npm config set prefix "${HOME}/.npm-packages"
