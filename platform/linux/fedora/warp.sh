#!/bin/bash

set -e

sudo dnf config-manager --add-repo https://pkg.cloudflare.com/cloudflared-ascii.repo

sudo dnf install cloudflare-warp -y

sudo systemctl enable --now warp-svc

warp-cli register
warp-cli set-mode proxy
warp-cli set-proxy-port 1027
warp-cli enable-always-on
warp-cli connect
