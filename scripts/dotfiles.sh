#!/bin/bash

set -x

source $HOME/dotfiles/shell/vars.sh

_neovim() {
  set -x
  echo "Install Neovim Host"
  python3 -m pip install virtualenv
  python3 -m virtualenv $NEOVIM_HOST
  $NEOVIM_HOST/bin/pip install pylint black flake8 mypy pydocstyle pynvim ranger-fm neovim-remote

  echo "Install neovim config"
  rm -rf ~/.config/nvim && mkdir -p ~/.config/nvim

  ln -sf ~/dotfiles/vim/nvim.vim ~/.config/nvim/init.vim
  ln -sf ~/dotfiles/vim/coc-settings.json ~/.config/nvim/
  ln -sf ~/dotfiles/vim/neovim/lua/ ~/.config/nvim/
  ln -sf ~/dotfiles/vim/UltiSnips ~/.config/nvim

  nvi +PlugInstall +qall
}

_shell() {
  mkdir -p ~/.zsh
  # zsh config
  mkdir -p ~/.zsh/completions/
  rustup completions zsh cargo > ~/.zsh/completions/_cargo
  mkdir -p ~/.config
  ln -fs ~/dotfiles/shell/starship.toml  ~/.config
}

_configs() {
  mkdir -p $HOME/.config/
  PLATFORM=$1
  pkgs=(
    htop
  )
  for pk in "${pkgs[@]}"; do
    echo "Settings up ${pk}"
    rm -rf $HOME/.config/${pk}
    ln -sf $HOME/dotfiles/.config/${pk} $HOME/.config/${pk}
  done

  specifics=(
    kitty
  )

  for pk in "${specifics[@]}"; do
    fullpath="$HOME/dotfiles/platform/${PLATFORM}/.config/${pk}"
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
     .bashrc
    .profile
    .pylintrc
    .ideavimrc
    .tmux.common.conf
  )
  for f in "${dots[@]}"; do
    ln -sf ~/dotfiles/$f $HOME/$f
  done

  platform_dots=(
    .alacritty.yml
    .wezterm.lua
    .tmux.conf
  )

  for f in "${platform_dots[@]}"; do
    echo ${PLATFORM}
    fullpath="$HOME/dotfiles/platform/${PLATFORM}/$f"
    echo $fullpath
    if [ -f $fullpath ]; then
      ln -sf $fullpath $HOME/$f
    fi
  done
}

_fonts() {
  FONT_DIR=""
  case "$1" in
    darwin)
      FONT_DIR="/Library/Fonts"
      ;;
    linux)
      FONT_DIR="/usr/local/share/fonts"
      ;;
    *)
      echo "Unsupport platform $1"
      exit;
  esac
  sudo mkdir -p ${FONT_DIR}
  cd ${FONT_DIR} && {
    sudo curl -LO 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete.ttf'
    sudo curl -LO 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete%20Mono.ttf'
  cd -; }
}

_ranger() {
  DEST_DIR=$HOME/.config/ranger
  rm -rf $DEST_DIR/*
  PLUGIN_DIR=$DEST_DIR/plugins
  mkdir -p $PLUGIN_DIR
  git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
  ln -s ~/dotfiles/ranger/rc.conf $DEST_DIR/rc.conf
  ln -s ~/dotfiles/ranger/rifle.conf $DEST_DIR/
}

_py_cli() {
  sudo python3.9 -m ensurepip
  sudo python3.9 -m pip install virtualenv
  sudo python3.9 -m virtualenv $PYCLI_HOME
  sudo chown -R $(whoami) $PYCLI_HOME
  $PYCLI_HOME/bin/pip install --upgrade pip mycli pgcli pyyaml awscli ansible black darker
  bins=(
    mycli
    pgcli
  )
  for b in ${bins[@]}; do
    ln -sf $PYCLI_HOME/bin/$b $HOME/.local/bin
  done
}

_completions() {
  echo "Install completions"
}

_git() {
  git config --global init.defaultBranch main
}
