#!/bin/bash

set -e

sudo rpm -ivh http://pkg.cloudflareclient.com/cloudflare-release-el8.rpm
sudo dnf install cloudflare-warp -y
sudo systemctl enable warp-svc
sudo systemctl restart warp-svc

warp-cli register
warp-cli set-mode proxy
warp-cli set-proxy-port 1027
warp-cli enable-always-on
warp-cli connect
