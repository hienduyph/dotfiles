#!/usr/bin/env bash
pkgs=(
  gnome-extensions-app
  gnome-tweak-tool
)

sudo dnf install -y "${pkgs[@]}"
