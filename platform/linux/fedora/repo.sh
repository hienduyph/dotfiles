#!/usr/bin/env bash

sudo dnf update -y 

sudo dnf install -y curl wget python3 python3-pip python3-devel liberation-fonts dnf-plugins-core https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm --import https://build.opensuse.org/projects/home:manuelschneid3r/public_key
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_36/home:manuelschneid3r.repo

sudo dnf remove PackageKit fedora-chromium-config -y
