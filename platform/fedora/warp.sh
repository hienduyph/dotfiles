#!/bin/bash

set -e

# sudo rpm -ivh http://pkg.cloudflareclient.com/cloudflare-release-el8.rpm

sudo dnf install -y https://pkg.cloudflareclient.com/uploads/cloudflare_warp_2022_4_235_1_x86_64_aa859896da.rpm
sudo systemctl enable --now warp-svc

warp-cli register
warp-cli set-mode proxy
warp-cli set-proxy-port 1027
warp-cli enable-always-on
warp-cli connect
