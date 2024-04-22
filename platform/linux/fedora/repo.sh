#!/usr/bin/env bash
_install() {
  sudo dnf install -y $@
}

sudo dnf update -y 

_install curl wget python3 python3-pip python3-devel  dnf-plugins-core
sudo dnf remove PackageKit fedora-chromium-config -y

_install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
_install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf copr enable atim/joshuto -y
sudo dnf copr enable atim/starship -y
sudo dnf copr enable atim/lazygit -y

sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

# sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

cat <<EOF | sudo tee /etc/yum.repos.d/hashicorp.repo
[hashicorp]
name=Hashicorp Stable - \$basearch
baseurl=https://rpm.releases.hashicorp.com/fedora/39/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://rpm.releases.hashicorp.com/gpg
EOF

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
EOF

sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
