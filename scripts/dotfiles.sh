#!/bin/bash

set -x

source $HOME/dotfiles/shell/vars.sh

# system stuff

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
    BASE=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures
    sudo curl -Lo 'JetBrains Mono Light Nerd Font Complete.ttf' "${BASE}/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete.ttf"
    sudo curl -Lo 'JetBrains Mono Light Nerd Font Complete Mono.ttf' "${BASE}/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete%20Mono.ttf"
    sudo curl -Lo 'JetBrains Mono ExtraLight Nerd Font Complete Mono.ttf' "${BASE}/ExtraLight/complete/JetBrains%20Mono%20ExtraLight%20Nerd%20Font%20Complete%20Mono.ttf"
  cd -; }
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

_cli() {
  source $HOME/.cargo/env
  pkgs=(
    jwt-cli
    --features vendored-openssl cargo-edit
  )
  for pk in "${pkgs[@]}"; do
    echo "[Cargo] installing $pk"
    eval "sudo cargo install --locked --root=/usr/local/ ${pk}"
  done
  # luals
  sudo mkdir -p /opt/LuaLS
  curl -fSsL 'https://github.com/sumneko/lua-language-server/releases/download/3.5.3/lua-language-server-3.5.3-linux-x64.tar.gz' | sudo tar xz -C /opt/LuaLS
  sudo ln -sf /opt/LuaLS/bin/lua-language-server /usr/local/bin/
}

_system() {
  sudo mkdir -p /etc/profile.d/
  sudo cp $HOME/dotfiles/shell/system.sh /etc/profile.d/
  sudo cp $HOME/dotfiles/shell/system/locale /etc/default/locale
}


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
    ln -sf $HOME/dotfiles/.config/${pk} $HOME/.config/${pk}
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
    .profile
    .pylintrc
    .ideavimrc
    .tmux.common.conf
    .alacritty.common.yml
  )
  for f in "${dots[@]}"; do
    ln -sf ~/dotfiles/$f $HOME/$f
  done

  locals=(
    .alacritty.yml
  )
  for f in "${locals[@]}"; do
    cp ~/dotfiles/$f $HOME
  done

  platform_dots=(
    .alacritty.sys.yml
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

_ranger() {
  DEST_DIR=$HOME/.config/ranger
  PLUGIN_DIR=$DEST_DIR/plugins
  rm -rf $PLUGIN_DIR
  mkdir -p $PLUGIN_DIR
  git clone https://github.com/alexanderjeurissen/ranger_devicons ${PLUGIN_DIR}/ranger_devicons
}

_cmp() {
  echo "Install completions"
  mkdir -p ~/.bash_completion.d/
  kubectl completion bash >> ~/.bash_completion.d/kubectl

  mkdir -p ~/.zsh/completions/
  rustup completions zsh cargo > ~/.zsh/completions/_cargo
  kubectl completion zsh >> ~/.zsh/completions/_kubectl
}

_git() {
  git config --global init.defaultBranch main
}
