#!/usr/bin/env bash

pkgs=(
  gnome-tweak-tool
)

sudo dnf install -y "${pkgs[@]}"
