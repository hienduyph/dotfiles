#!/usr/bin/env bash

sudo apt install curl wget jq htop vim make flatpak git git-lfs sudo zsh unzip -y

sudo apt remove pulseaudio-module-bluetooth -y
sudo apt update
sudo apt dist-ugprade -y
sudo apt install sddm dnsmasq --no-install-recommends libpam-mount libfuse2 bat jq libpam-mount-bin -y
sudo apt install -y xdg-desktop-portal xdg-desktop-portal-wlr libglib2.0-bin fcitx5 fcitx5-unikey thunar xdg-desktop-portal-gtk
sudo apt install -y grim wf-recorder slurp wlr-randr sway dex waybar wev swayidle swaylock sway-notification-center wlsunset pavucontrol blueman network-manager-gnome libspa-0.2-bluetooth
sudo apt install -y podman crun slirp4netns netavark distrobox

sudo systemctl enable --now sddm
sudo systemctl set-default graphical.target

# set default browser
xdg-mime default com.google.Chrome.desktop x-scheme-handler/https x-scheme-handler/http
xdg-settings set default-web-browser com.google.Chrome.desktop

_install_gh() {
  curl -foL /tmp/gh.deb $1
  sudo apt install -y /tmp/gh.deb
  rm /tmp/gh.deb
}
_install_gh https://github.com/lsd-rs/lsd/releases/download/v1.1.5/lsd_1.1.5_amd64.deb
# https://github.com/starship/starship/releases/download/v1.20.1/starship-x86_64-unknown-linux-gnu.tar.gz

# https://software.opensuse.org/download/package?package=swappy&project=home%3ASunderland93%3Atileos-dev
# https://software.opensuse.org//download.html?project=home%3ASunderland93%3Atileos-dev&package=rofi-wayland
