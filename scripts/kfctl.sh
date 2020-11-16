#!/bin/bash

_install() {
  downloads_urls=$(curl -fsSL https://api.github.com/repos/kubeflow/kfctl/releases/latest | jq -r '.assets[].browser_download_url')
  for url in $downloads_urls; do
    if echo "$url" | grep -q $PLATFORM; then
      echo "Downloading $url"
      curl -fsSL $url | sudo tar xz -C /usr/local/bin --strip-components=1
    fi
  done
}

sudo rm -rf /usr/local/bin/kfctl
_install
