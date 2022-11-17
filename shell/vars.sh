export NPM_CONFIG_PREFIX="${HOME}/.npm-packages"
export GOPATH="$HOME/.go"
export BASHMAN_DIR=$HOME/.config/bashman
export ANDROID_HOME=$HOME/Android/Sdk
export APP_HOME=$HOME/Applications

prependToPATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

addToPATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$PATH:$1";; # or PATH="$PATH:$1"
  esac
}

export PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"
export PROFILE_EXTRA_DIRS=$HOME/.profile_src
export BAT_THEME=GitHub
# export HOMEBREW_INSTALL_FROM_API=1


if [[ "$PLATFORM" == "linux" ]]; then
  export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
  brew() {
    sudo -Hu brew $HOMEBREW_PREFIX/bin/brew $@
  }
elif [[ "$PLATFORM" == "darwin" ]]; then
  # mac intel, no no
  export HOMEBREW_PREFIX=/opt/homebrew
fi
