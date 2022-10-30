#!/usr/bin/env bash

set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
APP_ROOT="$(dirname "$SCRIPT_DIR")"

source $APP_ROOT/scripts/dotfiles.sh
source $APP_ROOT/shell/func.sh
source $APP_ROOT/shell/vars.sh

_configs() {
  mkdir -p $HOME/.config/
  PLATFORM=$1
  pkgs=(
    htop
    mpv
    ranger
    nvim
    wezterm
    starship.toml
    helix
    nixpkgs
  )
  for pk in "${pkgs[@]}"; do
    echo "Settings up ${pk}"
    rm -rf $HOME/.config/${pk}
    ln -sf $APP_ROOT/.config/${pk} $HOME/.config/${pk}
  done

  specifics=(
    kitty
    i3
    i3status
    redshift
    sway
    fcitx5
  )

  for pk in "${specifics[@]}"; do
    fullpath="$APP_ROOT/platform/${PLATFORM}/.config/${pk}"
    echo "Settings ${fullpath}"
    if [ -d $fullpath ] || [ -f ${fullpath} ]; then
      rm -rf $HOME/.config/${pk}
      ln -sf ${fullpath} $HOME/.config/${pk}
    fi
  done
}

_dots() {
  PLATFORM=$1
  dots=(
    .zshrc
    .profile
    .pylintrc
    .ideavimrc
    .tmux.common.conf
    .alacritty.common.yml
  )
  for f in "${dots[@]}"; do
    ln -sf $APP_ROOT/$f $HOME/$f
  done

  locals=(
    .alacritty.yml
  )
  for f in "${locals[@]}"; do
    cp $APP_ROOT/$f $HOME
  done

  platform_dots=(
    .alacritty.sys.yml
    .tmux.conf
  )

  for f in "${platform_dots[@]}"; do
    echo ${PLATFORM}
    fullpath="$APP_ROOT/platform/${PLATFORM}/$f"
    echo $fullpath
    if [ -f $fullpath ]; then
      ln -sf $fullpath $HOME/$f
    fi
  done
}

_git() {
  if command -v pinentry-curses; then
    mkdir -p ~/.gnupg
    tee ~/.gnupg/gpg-agent.conf << EOF
pinentry-program $(which pinentry-curses)
EOF
  fi

  command -v git && git config --global init.defaultBranch main
}

_ranger() {
  DEST_DIR=$HOME/.config/ranger
  PLUGIN_DIR=$DEST_DIR/plugins
  rm -rf $PLUGIN_DIR
  mkdir -p $PLUGIN_DIR
  git clone https://github.com/alexanderjeurissen/ranger_devicons ${PLUGIN_DIR}/ranger_devicons
}

_nix() {
  if [ ! -d /nix ]; then
    echo "/nix path does not exist. Create it first and grant permission for $USER. Sudo is required."
    sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
  fi

  curl -L https://nixos.org/nix/install | sh

  # install home manager
  source $HOME/.nix-profile/etc/profile.d/nix.sh
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels${NIX_PATH:+:$NIX_PATH}
  nix-shell '<home-manager>' -A install
}


_mac() {
  echo "Setting mac links"
}

_linux() {
  echo "Linux"
}

main() {
  _dots $PLATFORM
  _configs $PLATFORM
  _git
  if [[ ${PLATFORM} == "darwin" ]]; then
    _mac
  elif [[ ${PLATFORM} == "linux" ]]; then
    _linux
    _nix
  fi
}

main
