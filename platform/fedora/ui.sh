#!/usr/bin/env bash
set -e

TMP_DIR=$HOME/.tmp
mkdir -p $TMP_DIR

_clone_n_install() {
  cd $TMP_DIR
  NAME=gtk-work
  rm -rf ${TMP_DIR}/${NAME}
  git clone $1 ${NAME}
  cd ${TMP_DIR}/${NAME}
  ./install.sh
  rm -rf ${TMP_DIR}/${NAME}
}

_github_dl() {
  user=$1
  name=$2
  branch=$3
  wrap=$4
  sub=$5
  url="https://github.com/${user}/${name}/archive/refs/heads/${branch}.zip"
  echo "Downloading $url"
  curl -sfSL -o ${TMP_DIR}/download.zip "${url}"
  unzip ${TMP_DIR}/download.zip -d ${TMP_DIR}
  if [[ ${wrap} != "" ]]; then
    mkdir -p $HOME/.themes/${wrap}
    cp -r ${TMP_DIR}/${name}-${branch}/${sub}* $HOME/.themes/${wrap}/
  else
    cp -r ${TMP_DIR}/${name}-${branch}/${sub}* $HOME/.themes/
  fi
  rm -rf ${TMP_DIR}/*
}


main() {
  # themes
  _github_dl  EliverLara Juno master Juno
  _github_dl  daniruiz flat-remix-gtk master '' themes/
  # icons
  _clone_n_install https://github.com/cbrnix/Flatery.git
}

main
