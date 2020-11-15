#!/bin/bash
set -e

VERSION=18.09.9
curl -Lo /tmp/docker.tar.gz https://download.docker.com/mac/static/stable/x86_64/docker-$VERSION.tgz
mkdir -p /tmp/dockerstages
tar -xf /tmp/docker.tar.gz --strip-components=1 -C /tmp/dockerstages
sudo mv /tmp/dockerstages/docker /usr/local/bin/docker
rm -rf /tmp/dockerstages
rm -rf /tmp/docker.tar.gz


COMPOSE_VERSION=1.27.0
curl -Lo /tmp/docker.tar.gz https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-Darwin-x86_64.tgz
sudo mkdir /opt/docker-compose
sudo tar -xf /tmp/docker.tar.gz -C /opt/docker-compose
rm -rf /tmp/docker.tar.gz
