#!/bin/bash

mkdir ~/.backups

f_backups() {
  mv $1 ~/.backups/ || true
}

_neovim() {
  echo "Install Neovim Host"
  NEOVIM_HOST=$HOME/.venv/neovim
  python3 -m virtualenv $NEOVIM_HOST
  $NEOVIM_HOST/bin/pip install neovim pylint black flake8 mypy pydocstyle

  echo "Install neovim config"
  f_backups ~/.config/nvim/init.vim
  f_backups ~/.config/nvim/coc-settings.json

  mkdir -p ~/.config/nvim
  ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
  ln -s ~/dotfiles/vim/coc-settings.json ~/.config/nvim/

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
}

_dots() {
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
    .alacritty.yaml
  )
  platform="$(uname -s | tr '[:upper:]' '[:lower:]')"

  for f in "${platform_dots[@]}"; do
    fullpath="~/dotfiles/$platform/$f"
    if [ -f $fullpath ]; then
      f_backups $HOME/$f
      ln -s $fullpath $HOME/$f
    fi
  done
}

main() {
  _neovim
  _shell
  _dots
}

main
