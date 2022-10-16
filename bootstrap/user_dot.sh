#!/usr/bin/env bash

set -x

APP_ROOT="$(dirname "$(dirname "$(readlink -fm "$0")")")"

source $APP_ROOT/scripts/dotfiles.sh
source $APP_ROOT/shell/func.sh
source $APP_ROOT/shell/vars.sh

# user stuff
_neovim() {
  set -x
  echo "Install Neovim Host"
  python3 -m pip install virtualenv
  python3 -m virtualenv $NEOVIM_HOST
  $NEOVIM_HOST/bin/pip install pylint black flake8 mypy pydocstyle pynvim ranger-fm neovim-remote
}

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
  command -v git && git config --global init.defaultBranch main
}

_ranger() {
  DEST_DIR=$HOME/.config/ranger
  PLUGIN_DIR=$DEST_DIR/plugins
  rm -rf $PLUGIN_DIR
  mkdir -p $PLUGIN_DIR
  git clone https://github.com/alexanderjeurissen/ranger_devicons ${PLUGIN_DIR}/ranger_devicons
}


_mac() {
  echo "Setting mac links"
}

_linux() {
  if command -v pinentry-curses; then
    mkdir -p ~/.gnupg
    tee ~/.gnupg/gpg-agent.conf << EOF
pinentry-program $(which pinentry-curses)
EOF
  fi
}

_brew() {
  mkdir ${BREW_PREFIX} && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $BREW_PREFIX
}

main() {
  _dots $PLATFORM
  _configs $PLATFORM
  _git
  _ranger
  _neovim
  if [[ ${PLATFORM} == "darwin" ]]; then
    _mac
  elif [[ ${PLATFORM} == "linux" ]]; then
    _linux
  fi
}

main
