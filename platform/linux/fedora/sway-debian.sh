#!/usr/bin/env bash

sudo apt install sddm dnsmasq --no-install-recommends -y
sudo apt remove pulseaudio-module-bluetooth -y
sudo apt install -y xdg-desktop-portal xdg-desktop-portal-wlr 
sudo apt install -y grim wf-recorder slurp wlr-randr sway dex waybar wev swayidle swaylock sway-notification-center
sudo apt install -y fcitx5 fcitx5-unikey wlsunset pavucontrol blueman network-manager-gnome libspa-0.2-bluetooth wofi

# https://software.opensuse.org/download/package?package=swappy&project=home%3ASunderland93%3Atileos-dev
# https://software.opensuse.org//download.html?project=home%3ASunderland93%3Atileos-dev&package=rofi-wayland
