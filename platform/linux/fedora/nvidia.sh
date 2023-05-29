#!/usr/bin/env bash

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update -y # and reboot if you are not on the latest kernel
sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support

