#!/usr/bin/env bash

_dep() {
  sudo dnf install gtk-murrine-engine glib2-devel gtk2-engines -y
}

_clone_n_install() {
  cd /tmp
  NAME=gtk-work
  rm -rf /tmp/${NAME}
  git clone $1 ${NAME}
  cd /tmp/${NAME}
  ./install.sh
}

main() {
  _dep
}
_clone_n_install https://github.com/vinceliuice/Orchis-theme.git

