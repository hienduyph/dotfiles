#!/bin/bash
set -e

_docker_cli() {
  DOCKER_VESION=$1
  echo "Download Docker compose $1"
  TMP_DIR=/tmp/dockerstages
  DEST_BIN=/usr/local/bin/docker
  sudo rm -rf $DEST_BIN
  mkdir -p $TMP_DIR
  curl -fsSL https://download.docker.com/mac/static/stable/x86_64/docker-$DOCKER_VESION.tgz | tar xz -C /tmp/dockerstages --strip-components=1
  sudo mv $TMP_DIR/docker $DEST_BIN
  rm -rf $TMP_DIR
}


_docker_compose() {
  echo "Download Docker-compose $1"
  COMPOSE_VERSION=$1
  INSTALL_DIR=/usr/local/docker-compose
  sudo rm -rf $INSTALL_DIR/ && sudo mkdir -p $INSTALL_DIR
  sudo rm -rf /usr/local/bin/docker-compose
  curl -fSSL https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-Darwin-x86_64.tgz | sudo tar xz -C $INSTALL_DIR
  sudo ln -s $INSTALL_DIR/docker-compose /usr/local/bin
}

_docker_cli "20.10.2"
_docker_compose "1.27.4"
