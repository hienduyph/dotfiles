#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null)
if [[ $SCRIPT_DIR == "" ]]; then
  APP_ROOT=${HOME}/dotfiles
else
  APP_ROOT="$(dirname "$SCRIPT_DIR")"
fi

source $APP_ROOT/shell/func.sh
source $APP_ROOT/shell/vars.sh

_configs() {
  mkdir -p $HOME/.config/
  PLATFORM=$1
  pkgs=(
    mpv
    ranger
    nvim
    tmux
    starship.toml
    lapce-stable
    k9s
    lsd
  )
  for pk in "${pkgs[@]}"; do
    echo "Settings up ${pk}"
    rm -rf $HOME/.config/${pk}
    ln -sf $APP_ROOT/.config/${pk} $HOME/.config/${pk}
  done

  copies=(
    htop
  )
  for pk in "${copies[@]}"; do
    rm -rf $HOME/.config/${pk}
    cp $APP_ROOT/.config/${pk} $HOME/.config/${pk}
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

  mkdir -p $HOME/.config/lazygit
  ln -sf $HOME/dotfiles/.config/lazygit/config.yml  $HOME/.config/lazygit

  mkdir -p $HOME/apps
  git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git $HOME/apps/ble.sh
  make -C $HOME/apps/ble.sh
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
    .alacritty.common.toml
    .bashrc
  )
  for f in "${dots[@]}"; do
    ln -sf $APP_ROOT/$f $HOME/$f
  done

  copies=(
    .alacritty.toml
    .gitconfig
  )
  for f in "${copies[@]}"; do
    cp $APP_ROOT/$f $HOME
  done

  platform_dots=(
    .alacritty.sys.toml
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

  # tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
  mkdir -m 0700 ~/.gnupg
  echo "pinentry-program $($HOMEBREW_PREFIX/bin/brew --prefix)/bin/pinentry-curses" | tee ~/.gnupg/gpg-agent.conf
  pkill -TERM gpg-agent
}

_linux() {
  mkdir -m 0700 ~/.gnupg
  echo "pinentry-mode loopback" | tee  ~/.gnupg/gpg.conf
  pkill -TERM gpg-agent
}

_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable --no-modify-path --profile default -y
}

_java() {
  curl -s "https://get.sdkman.io?rcupdate=false" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install java 21.0.4-tem
  sdk install maven
  sdk install gradle
}

_scala() {
  chmod +x /tmp/cs
  /tmp/cs setup --env --apps=bloop,scalafix,coursier,sbt,metals
  rm -f /tmp/cs
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

_user_py_cli() {
  mkdir -p $HOME/.local/bin/
  python3 -m venv $HOME/.virtualenvs/cli
  $HOME/.virtualenvs/cli/bin/pip install -U uv mycli pgcli ansible podman-compose s3cmd pip
  bins=(
    uv
    mycli
    pgcli
    ansible-playbook
    podman-compose
    s3cmd
  )
  for b in ${bins[@]}; do
    ln -sf $HOME/.virtualenvs/cli/bin/$b $HOME/.local/bin/
  done
}

main() {
  _dots $PLATFORM
  _configs $PLATFORM
  _git
  # _ranger
  if [[ ${PLATFORM} == "darwin" ]]; then
    curl -fL https://github.com/VirtusLab/coursier-m1/releases/latest/download/cs-aarch64-apple-darwin.gz | gzip -d > /tmp/cs
    _mac
  elif [[ ${PLATFORM} == "linux" ]]; then
    curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > /tmp/cs
    _linux
  fi
  _user_py_cli
  _java
  _scala
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   _brew_bundle Brewfile

  _rust
}


if [[ $_ == $0 ]]; then
  main
fi
