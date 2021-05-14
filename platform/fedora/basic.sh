#/bin/bash

set -ex

_pkg() {
	sudo dnf "$@"
}

_pkg update -y && _pkg install -y curl wget python3.9 python3.9-pip liberation-fonts dnf-plugins-core

echo "Add brave"
_pkg config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/\
  && sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

echo 'Add Enpass Repo'
_pkg config-manager --add-repo  https://yum.enpass.io/enpass-yum.repo


echo 'Add albert'
sudo rpm --import https://build.opensuse.org/projects/home:manuelschneid3r/public_key
_pkg config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_33/home:manuelschneid3r.repo

echo 'Add Docker Repo'
_pkg config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf copr enable agriffis/neovim-nightly -y

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

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
  neovim
  kitty
  code
  gnome-tweaks
  gnome-shell-extension-user-theme
  gnome-shell-extension-appindicator
  libgnome
)

# Install all
echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo usermod -aG docker $USER

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

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
