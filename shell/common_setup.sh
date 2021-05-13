#!/bin/bash

mkdir -p ~/.backups

f_backups() {
  mv $1 ~/.backups/ || true
}

_neovim() {
  echo "Install Neovim Host"
  NEOVIM_HOST=$HOME/.venv/neovim
  python3 -m pip install virtualenv
  python3 -m virtualenv $NEOVIM_HOST
  $NEOVIM_HOST/bin/pip install pylint black flake8 mypy pydocstyle pynvim ranger-fm neovim-remote

  echo "Install neovim config"
  f_backups ~/.config/nvim/init.vim
  f_backups ~/.config/nvim/coc-settings.json

  mkdir -p ~/.config/nvim/lua
  ln -s ~/dotfiles/vim/nvim.vim ~/.config/nvim/init.vim
  ln -s ~/dotfiles/vim/coc-settings.json ~/.config/nvim/
  ln -s ~/dotfiles/vim/neovim/lua/ ~/.config/nvim/lua

  # for nvim
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  nvim +PlugInstall +qall
}

_shell() {
  mkdir -p ~/.zsh
  curl -fsSL git.io/antigen > ~/.zsh/antigen.zsh
  curl -fsSL https://starship.rs/install.sh | bash
  # zsh config
  mkdir -p ~/.zsh/completions/
  rustup completions zsh cargo > ~/.zsh/completions/_cargo
  mkdir -p ~/.config
  ln -s ~/dotfiles/shell/starship.toml  ~/.config
}

_dots() {
  PLATFORM=$1
  dots=(
    .zshrc
    .profile
    .gitconfig
    .pylintrc
    .htoprc
    .ideavimrc
    .tmux.conf
  )
  for f in "${dots[@]}"; do
    f_backups $HOME/$f
    ln -s ~/dotfiles/$f $HOME/$f
  done

  platform_dots=(
    .alacritty.yml
  )

  for f in "${platform_dots[@]}"; do
    echo ${PLATFORM}
    fullpath="$HOME/dotfiles/platform/${PLATFORM}/$f"
    echo $fullpath
    if [ -f $fullpath ]; then
      f_backups $HOME/$f
      ln -s $fullpath $HOME/$f
    fi
  done
}

_fonts() {
  FONT_DIR=""
  case "$PLATFORM" in
    darwin)
      FONT_DIR="/Library/Fonts"
      ;;
    linux)
      FONT_DIR="/usr/share/fonts/input-mono-nerd-fonts"
      ;;
    *)
      echo "Unsupport platform $PLATFORM"
      exit;
  esac
  rm -rf ${FONT_DIR}
  sudo mkdir -p ${FONT_DIR}
  sudo tar -xf ~/dotfiles/fonts/InputMonoNerdFont.tar.gz -C $FONT_DIR
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
