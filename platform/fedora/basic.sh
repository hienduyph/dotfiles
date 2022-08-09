#/bin/bash

set -ex

_pkg() {
	sudo dnf "$@"
}

_pkg update -y && _pkg install -y curl wget python3 python3-pip python3-devel liberation-fonts dnf-plugins-core

echo 'Add Enpass Repo'
_pkg config-manager --add-repo  https://yum.enpass.io/enpass-yum.repo


echo "Add ibus"
_pkg config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_36/home:lamlng.repo

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'


echo "Add Chrome"
sudo dnf config-manager --set-enabled google-chrome
echo "Add Brave"
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

echo "Add rpm fushion non free"
_pkg install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
_pkg install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Add albert"
sudo rpm --import https://build.opensuse.org/projects/home:manuelschneid3r/public_key
_pkg config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_36/home:manuelschneid3r.repo

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

sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

_pkg copr enable atim/lazygit -y

_pkg copr enable vbatts/bazel -y

sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

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
  xclip
  code
  gnome-tweak-tool
  libgnome
  mysql-devel
  postgresql-devel
  clang
  clang-devel clang-tools-extra
  llvm lld
  hexyl
  icu
  qbittorrent
  google-chrome-stable
  nodejs
  bat
  neovim
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
  starship
  htop
  git-delta
  telnet
  python3.9
  mpv
  ibus-bamboo
  rust-analyzer
  httpie

  helm
  kubectl
  terraform


  telegram
  editorconfig
  lazygit
  tokei
  unrar
  sysstat
  pipewire-codec-aptx
  gnome-sound-recorder
  https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.rpm
  cabextract xorg-x11-font-utils fontconfig
  albert
  podman-compose
  flameshot
  ncdu
  onedrive
  gtk-murrine-engine
  glib2-devel
  gtk2-engines
  google-cloud-cli
  brave-browser
  bazel5
  # some math stuff
  openblas-devel lapack-devel

  blueman
  # term ftuff
  ranger
  cheat
)

# Install all
echo 'Install all package'
_pkg update
_pkg install -y "${packages[@]}"

sudo dnf remove PackageKit fedora-chromium-config -y

services=(
  dnscrypt-proxy
  sysstat
)

for pkg in "${services[@]}"; do
  sudo systemctl start $pkg
  sudo systemctl enable $pkg
done

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpaks=(
  org.gnome.Extensions
  io.dbeaver.DBeaverCommunity
)
for pkg in "${flatpaks[@]}";do
  flatpak install flathub ${pkg} -y
done
