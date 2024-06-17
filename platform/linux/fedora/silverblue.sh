#!/usr/bin/env bash

source /etc/os-release

_theme() {
  local workdir=/tmp/theme
  mkdir $workdir
  git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git $workdir
  $workdir/install.sh -t default -a -b
  rm -rf $workdir
}

_repo() {
  sudo curl -Lo /etc/yum.repos.d/SwayNotificationCenter.repo https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-${VERSION_ID}/erikreider-SwayNotificationCenter-fedora-${VERSION_ID}.repo
  sudo curl -Lo /etc/yum.repos.d/starship.repo https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-${VERSION_ID}/atim-starship-fedora-${VERSION_ID}.repo
}

_install_pkg() {
  pkgs=(
    alacritty
    htop
    lm_sensors
    zsh
    lsd
    bat
    fd-find
    starship
    neovim
    tmux
    telnet
    git-lfs
    grim wf-recorder slurp wev fcitx5-unikey wlsunset blueman swappy eog nautilus SwayNotificationCenter dnscrypt-proxy podman-compose pam_mount cronie cronie-anacron kernel-tools openssl
  )
  sudo rpm-ostree install ${pkgs[@]} -y
  sudo rpm-ostree override remove firefox firefox-langpacks -y
}

_flatpak() {
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  apps=(
    com.github.tchx84.Flatseal
    md.obsidian.Obsidian
    com.visualstudio.code
    org.mozilla.firefox
    org.telegram.desktop
    org.keepassxc.KeePassXC
    net.cozic.joplin_desktop
    com.google.Chrome
    com.vivaldi.Vivaldi
    io.dbeaver.DBeaverCommunity
    com.visualstudio.code.tool.podman/x86_64/23.08
    io.mpv.Mpv
  )
  flatpak install flathub ${apps[@]} -y
}
_repo
_install_pkg
_flatpak
_theme
