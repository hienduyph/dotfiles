#/bin/bash

set -ex

_pkg() {
	sudo dnf "$@"
}

_pkg update -y && _pkg install -y curl wget python3 python3-pip python3-devel liberation-fonts dnf-plugins-core

echo 'Add Enpass Repo'
_pkg config-manager --add-repo  https://yum.enpass.io/enpass-yum.repo


echo 'Add albert'
sudo rpm --import https://build.opensuse.org/projects/home:manuelschneid3r/public_key
_pkg config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_35/home:manuelschneid3r.repo

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

echo "Add Docker"
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

echo "Add Chrome"
sudo dnf config-manager --set-enabled google-chrome

echo "Add rpm fushion non free"
_pkg install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
_pkg install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


packages=(
  zsh
  enpass
  flameshot
  dnscrypt-proxy
  git-lfs
  git
  git-subtree
  albert
  g++ libstdc++-devel libstdc++
  java-11-openjdk
  java-11-openjdk-devel
  java-1.8.0-openjdk
  xclip
  code
  gnome-tweak-tool
  libgnome
  mysql-devel
  postgresql-devel
  clang
  clang-devel clang-tools-extra
  llvm
  hexyl
  icu
  transmission
  docker-ce docker-ce-cli containerd.io
  google-chrome-stable
  nodejs
  bat
  neovim
  alacritty
  cmake
  exa
  zoxide
  direnv
  fzf
  xprop
  pavucontrol
  jq
  dropbox
  calibre
  golang
  ripgrep
  fd-find
  htop
  git-delta
  blueman
  telnet
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

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

npm config set prefix "${HOME}/.npm-packages"

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub org.gnome.Extensions -y
