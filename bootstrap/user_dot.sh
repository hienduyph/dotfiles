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
    starship.toml
    despell
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
    mako
    sway
    waybar
    sworkstyle
    fuzzel
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

  # k9s
  mkdir -p $HOME/.config/k9s/
  ln -sf $HOME/dotfiles/.config/k9s/skin.yml  $HOME/.config/k9s/

  mkdir -p $HOME/.config/lazygit
  ln -sf $HOME/dotfiles/.config/lazygit/config.yml  $HOME/.config/lazygit
}

_dots() {
  mkdir $HOME/.zsh/completions
  PLATFORM=$1
  dots=(
    .zshrc
    .profile
    .pylintrc
    .ideavimrc
    .tmux.common.conf
    .alacritty.common.yml
    .gitconfig
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
  mkdir -p "$HOME/Library/Application Support/Sublime Text/Packages"
  ln -sf ~/dotfiles/.config/sublime-text/User "$HOME/Library/Application Support/Sublime Text/Packages/"

  mkdir -m 0700 ~/.gnupg
  echo "pinentry-program $($HOMEBREW_PREFIX/bin/brew --prefix)/bin/pinentry-mac" | tee ~/.gnupg/gpg-agent.conf
  pkill -TERM gpg-agent
}

_linux() {
  mkdir -p $HOME/.config/sublime-text-3/Packages/
  ln -sf ~/dotfiles/.config/sublime-text/User $HOME/.config/sublime-text-3/Packages/

  mkdir -m 0700 ~/.gnupg
  echo "pinentry-program /usr/bin/pinentry-curses" | tee ~/.gnupg/gpg-agent.conf
  pkill -TERM gpg-agent
}

_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable --no-modify-path --profile default -y
}

_java() {
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install java 11.0.19-tem
}

_brew_bundle() {
  if [ -f $1 ]; then
  cp $1 /tmp
  CURR=$(pwd)
  cd /tmp && $HOMEBREW_PREFIX/bin/brew bundle && cd $CURR
  fi
}

_brew() {
  _brew_bundle "$APP_ROOT/platform/${PLATFORM}/Brewfile"
  _brew_bundle "$APP_ROOT/platform/${PLATFORM}/code.Brewfile"

  $($HOMEBREW_PREFIX/bin/brew --prefix)/opt/fzf/install --no-update-rc --key-bindings --completion

}

main() {
  _dots $PLATFORM
  _configs $PLATFORM
  _git
  _ranger

  if [[ ${PLATFORM} == "darwin" ]]; then
    # _brew
    _mac
  elif [[ ${PLATFORM} == "linux" ]]; then
    _linux
  fi
  _java
  _rust
}

main
