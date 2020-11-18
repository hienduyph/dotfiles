#!/bin/bash

set -e

_install() {
  sudo curl -fSL -o /usr/local/bin/gnome-shell-extension-installer "https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer"
  sudo chmod +x /usr/local/bin/gnome-shell-extension-installer
}

_install
