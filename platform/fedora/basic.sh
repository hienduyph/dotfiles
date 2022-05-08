#/bin/bash

set -ex

_pkg() {
	sudo dnf "$@"
}

_pkg update -y && _pkg install -y curl wget python3 python3-pip python3-devel liberation-fonts dnf-plugins-core

echo 'Add Enpass Repo'
_pkg config-manager --add-repo  https://yum.enpass.io/enpass-yum.repo


echo "Add ibus"
_pkg config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_35/home:lamlng.repo

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'


echo "Add Chrome"
sudo dnf config-manager --set-enabled google-chrome

echo "Add rpm fushion non free"
_pkg install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
_pkg install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Add albert"
sudo rpm --import https://build.opensuse.org/projects/home:manuelschneid3r/public_key
_pkg config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_35/home:manuelschneid3r.repo

_pkg copr enable robot/rust-analyzer -y

sudo rpm --import https://packages.cloud.google.com/yum/doc/yum-key.gpg
sudo rpm --import https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

echo "Add Signal repo"
_pkg copr enable luminoso/Signal-Desktop -y
_pkg copr enable atim/lazygit -y

packages=(
  zsh
  enpass
  dnscrypt-proxy
  git-lfs
  git
  git-subtree
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
  telnet
  python3.8
  python3.9
  mpv
  ibus-bamboo
  rust-analyzer
  httpie
  helm
  kubectl
  starship
  telegram
  editorconfig
  lazygit
  tokei
  unrar
  sysstat
  pipewire-codec-aptx
  gnome-sound-recorder
  https://github.com/wez/wezterm/releases/download/20220408-101518-b908e2dd/wezterm-20220408_101518_b908e2dd-1.fc35.x86_64.rpm
  https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.rpm
  cabextract xorg-x11-font-utils fontconfig
  albert
  signal-desktop
  podman-compose
  flameshot
)

# Install all
echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo dnf remove PackageKit fedora-chromium-config -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

services=(
  dnscrypt-proxy
  sysstat
)

for pkg in "${services[@]}"; do
  sudo systemctl start $pkg
  sudo systemctl enable $pkg
done

npm config set prefix "${HOME}/.npm-packages"

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpaks=(
  org.gnome.Extensions
  io.dbeaver.DBeaverCommunity
)
for pkg in "${flatpaks[@]}";do
  flatpak install flathub ${pkg} -y
done

_py() {
  python3.9 -m ensurepip --user
  python3.9 -m pip install virtualenv
  python3.8 -m ensurepip --user
  python3.8 -m pip install virtualenv
}

_py

# mpv
ln -sf $(pwd)/platform/linux/mpv $HOME/.config

echo "Jetbrain toolbox"

curl -fsSL 'https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-1.23.11680.tar.gz' | tar xz -C ~/.local/bin --strip-components=1
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
