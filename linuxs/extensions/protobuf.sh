#!/bin/bash

set -e

install() {
  version=$1
  curl -Lo /tmp/protobuf.zip https://github.com/google/protobuf/releases/download/v$version/protoc-$version-linux-x86_64.zip
  mkdir -p /tmp/protoc3
  unzip /tmp/protobuf.zip -d /tmp/protoc3

  # Move protoc to /usr/local/bin/
  sudo mv /tmp/protoc3/bin/* /usr/local/bin/

  # Move protoc3/include to /usr/local/include/
  sudo mv /tmp/protoc3/include/* /usr/local/include/
  rm -rf /tmp/protoc3 /tmp/protobuf.zip
}

install "3.13.0"
