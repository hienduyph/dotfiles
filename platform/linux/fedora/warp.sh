#!/bin/bash

set -e

curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo
sudo yum install cloudflare-warp -y

sudo systemctl enable --now warp-svc

warp-cli register
warp-cli set-mode proxy
warp-cli set-proxy-port 1027
warp-cli enable-always-on
warp-cli connect
