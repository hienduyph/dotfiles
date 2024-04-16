#!/usr/bin/env bash

source /etc/os-release

sudo curl -Lo /etc/yum.repos.d/SwayNotificationCenter.repo https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-${VERSION_ID}/erikreider-SwayNotificationCenter-fedora-${VERSION_ID}.repo

sudo rpm-ostree install alacritty htop zsh grim wf-recorder slurp wlr-randr sway dex-autostart waybar rofi-wayland wev fcitx5 fcitx5-gtk fcitx5-qt fcitx5-unikey wlsunset pavucontrol blueman mako kvantum swappy network-manager-applet eog nautilus SwayNotificationCenter git-lfs -y dnscrypt-proxy podman-compose lm_sensors pam_mount tmux neovim cronie cronie-anacron telnet make cmake kernel-tools gcc gcc-g++ openssl openssl-devel -y

sudo rpm-ostree override remove firefox firefox-langpacks -y

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