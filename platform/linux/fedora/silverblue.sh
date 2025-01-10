#!/usr/bin/env bash

set -ex

source /etc/os-release

_repo() {
	sudo curl -LO https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/repo/fedora-41/dsommers-openvpn3-fedora-41.repo
}

_install_pkg() {
	pkgs=(
		alacritty
		fcitx5-unikey
    fzf
		dex-autostart
		distrobox
		swappy
	)

	sudo rpm-ostree install ${pkgs[@]}
	sudo ln -sf /usr/bin/dex-autostart /usr/local/bin/dex
}

_flatpak() {
	flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	apps=(
		com.google.Chrome
		com.github.tchx84.Flatseal
		md.obsidian.Obsidian
		com.visualstudio.code
		org.telegram.desktop
		org.keepassxc.KeePassXC
		io.dbeaver.DBeaverCommunity
	)
	flatpak --user install flathub ${apps[@]} -y
}

# _repo
_install_pkg
_flatpak

