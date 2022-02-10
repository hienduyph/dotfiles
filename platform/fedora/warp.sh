#!/bin/bash

set -e

# sudo rpm -ivh http://pkg.cloudflareclient.com/cloudflare-release-el8.rpm

cat <<EOF | sudo tee /etc/yum.repos.d/cloudflare.repo
[cloudflare]
name=Cloudflare CentOS Packages
baseurl=https://pkg.cloudflareclient.com/dists/8/main/binary-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CLOUDFLARE-3
EOF

sudo dnf install cloudflare-warp -y
sudo systemctl enable warp-svc
sudo systemctl restart warp-svc

warp-cli register
warp-cli set-mode proxy
warp-cli set-proxy-port 1027
warp-cli enable-always-on
warp-cli connect
