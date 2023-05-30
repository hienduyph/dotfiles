#!/usr/bin/env bash
_install() {
  sudo dnf install -y $@
}

sudo dnf update -y 

_install curl wget python3 python3-pip python3-devel liberation-fonts dnf-plugins-core
sudo dnf remove PackageKit fedora-chromium-config -y

_install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
_install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# albert for gnome
sudo rpm --import https://build.opensuse.org/projects/home:manuelschneid3r/public_key
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_38/home:manuelschneid3r.repo

sudo dnf config-manager --set-enabled google-chrome

sudo dnf copr enable atim/joshuto -y
sudo dnf copr enable atim/starship -y
sudo dnf copr enable atim/lazygit -y
sudo dnf copr enable pgaskin/zotero -y

sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo tee /etc/yum.repos.d/microsoft.repo << EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc

[edge]
name=Microsoft Edge
baseurl=https://packages.microsoft.com/yumrepos/edge
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
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

