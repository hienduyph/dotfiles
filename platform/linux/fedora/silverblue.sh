#!/usr/bin/env bash

set -ex

source /etc/os-release

_repo() {
  sudo curl -Lo /etc/yum.repos.d/SwayNotificationCenter.repo https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-${VERSION_ID}/erikreider-SwayNotificationCenter-fedora-${VERSION_ID}.repo
  sudo curl -Lo /etc/yum.repos.d/starship.repo https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-${VERSION_ID}/atim-starship-fedora-${VERSION_ID}.repo
  sudo curl -Lo /etc/yum.repos.d/wezterm-nightly.repo https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-${VERSION_ID}/wezfurlong-wezterm-nightly-fedora-${VERSION_ID}.repo
}

_install_pkg() {
  pkgs=(
    git
    alacritty
    wezterm
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
    wf-recorder fcitx5-unikey swappy SwayNotificationCenter dex-autostart
    dnscrypt-proxy podman-compose pam_mount kernel-tools openssl
    cronie cronie-anacron
    # slurp grim wev wlsunset blueman eog 
  )
  sudo rpm-ostree install ${pkgs[@]}
  sudo rpm-ostree override remove firefox firefox-langpacks
  sudo ln -sf /usr/bin/dex-autostart /usr/local/bin/dex
}

_flatpak() {
  flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  apps=(
    com.google.Chrome
    com.vivaldi.Vivaldi
    com.github.tchx84.Flatseal
    md.obsidian.Obsidian
    com.visualstudio.code
    org.telegram.desktop
    org.keepassxc.KeePassXC
    net.cozic.joplin_desktop
    io.dbeaver.DBeaverCommunity
  )
  flatpak --user install flathub ${apps[@]} -y
}

_repo
_install_pkg
_flatpak
