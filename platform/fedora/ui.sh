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

_github_dl() {
  user=$1
  name=$2
  branch=$3
  wrap=$4
  url="https://github.com/${user}/${name}/archive/refs/heads/${branch}.zip"
  echo "Downloading $url"
  curl -sfSL -o /tmp/download.zip "${url}"
  unzip /tmp/download.zip -d /tmp
  if [[ ${wrap} != "" ]]; then
    mkdir -p $HOME/.themes/${wrap}
    cp -r /tmp/${name}-${branch}/* $HOME/.themes/${wrap}/
  else
    cp -r /tmp/${name}-${branch}/* $HOME/.themes/
  fi
}


main() {
  _dep
  _clone_n_install https://github.com/vinceliuice/Orchis-theme.git
  _clone_n_install https://github.com/cbrnix/Flatery.git
  _clone_n_install https://github.com/vinceliuice/Mojave-gtk-theme.git
  _github_dl  rtlewis88 rtl88-Themes material-black-COLORS
  _github_dl  paullinuxthemer Prof-Gnome master
  _github_dl  EliverLara Juno master Juno
}

main
