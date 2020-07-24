#!/bin/bash

FILE="/tmp/kafctl.tar.gz"
INSTALL_DIR=$(pwd)/kfctl
URL=$(curl -s https://api.github.com/repos/kubeflow/kfctl/releases/latest \
  | grep "https://.*kfctl_.*_darwin.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \")

echo "Got File $URL"
curl -Lo $FILE $URL
rm -rf $INSTALL_DIR && mkdir -p $INSTALL_DIR
tar -xf $FILE -C $INSTALL_DIR --strip-components=1
rm -rf $FILE
mv $INSTALL_DIR/kfctl /usr/local/bin/
