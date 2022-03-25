#!/bin/bash
set -e

_docker_cli() {
  DOCKER_VESION=$1
  echo "Download Docker compose $1"
  TMP_DIR=/tmp/dockerstages
  DEST_BIN=/usr/local/bin/docker
  sudo rm -rf $DEST_BIN
  mkdir -p $TMP_DIR
  curl -fsSL https://download.docker.com/mac/static/stable/aarch64/docker-$DOCKER_VESION.tgz | tar xz -C /tmp/dockerstages --strip-components=1
  sudo mv $TMP_DIR/docker $DEST_BIN
  rm -rf $TMP_DIR
}


_docker_compose() {
  echo "Download Docker-compose $1"
  COMPOSE_VERSION=$1
  sudo rm -f /usr/local/bin/docker-compose
  sudo curl -Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/v{COMPOSE_VERSION}/docker-compose-darwin-aarch64
  sudo chmod +x /usr/local/bin/docker-compose
}

_docker_cli "20.10.13"
_docker_compose "2.3.3"
