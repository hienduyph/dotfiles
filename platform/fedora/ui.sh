#!/usr/bin/env bash

_dep() {
  sudo dnf install gtk-murrine-engine glib2-devel gtk2-engines -y
}
TMP_DIR=$HOME/.tmp
mkdir -p $TMP_DIR

_clone_n_install() {
  cd $TMP_DIR
  NAME=gtk-work
  rm -rf ${TMP_DIR}/${NAME}
  git clone $1 ${NAME}
  cd ${TMP_DIR/}${NAME}
  ./install.sh
  rm -rf ${TMP_DIR}/${NAME}
}

_github_dl() {
  user=$1
  name=$2
  branch=$3
  wrap=$4
  url="https://github.com/${user}/${name}/archive/refs/heads/${branch}.zip"
  echo "Downloading $url"
  curl -sfSL -o ${TMP_DIR}/download.zip "${url}"
  unzip ${TMP_DIR}/download.zip -d ${TMP_DIR}
  if [[ ${wrap} != "" ]]; then
    mkdir -p $HOME/.themes/${wrap}
    cp -r ${TMP_DIR}/${name}-${branch}/* $HOME/.themes/${wrap}/
  else
    cp -r ${TMP_DIR}/${name}-${branch}/* $HOME/.themes/
  fi
  rm -rf ${TMP_DIR}/*
}


main() {
  _dep
  # themes
  _github_dl  EliverLara Juno master Juno
  # icons
  _clone_n_install https://github.com/cbrnix/Flatery.git
}

main
