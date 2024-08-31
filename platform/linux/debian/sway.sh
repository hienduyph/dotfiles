#!/usr/bin/env bash

sudo apt remove pulseaudio-module-bluetooth -y
sudo apt update
sudo apt dist-ugprade -y
sudo apt install sddm dnsmasq --no-install-recommends libpam-mount libfuse2 bat jq -y
sudo apt install -y xdg-desktop-portal xdg-desktop-portal-wlr libglib2.0-bin fcitx5 fcitx5-unikey
sudo apt install -y grim wf-recorder slurp wlr-randr sway dex waybar wev swayidle swaylock sway-notification-center wlsunset pavucontrol blueman network-manager-gnome libspa-0.2-bluetooth
sudo apt install -y podman crun slirp4netns netavark distrobox

sudo systemctl enable --now sddm
sudo systemctl set-default graphical.target

# https://software.opensuse.org/download/package?package=swappy&project=home%3ASunderland93%3Atileos-dev
# https://software.opensuse.org//download.html?project=home%3ASunderland93%3Atileos-dev&package=rofi-wayland
