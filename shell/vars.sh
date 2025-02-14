export EDITOR=vi
export VISUAL=${EDITOR}
export SYSTEMD_EDITOR=${EDITOR}
export KUBE_EDITOR=${EDITOR}
export GIT_EDITOR=${EDITOR}
export LANG="en_US.UTF-8"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=-en_US.UTF-8

export NPM_CONFIG_PREFIX="${HOME}/.npm-packages"
export GOPATH="$HOME/.go"
export BASHMAN_DIR=$HOME/.config/bashman
export ANDROID_HOME=$HOME/Android/Sdk
export APP_HOME=/opt/apps
export BOX_NAME=q


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
if [[ $DARK_MODE == "on" ]]; then
  # no thing
else
  export BAT_THEME=GitHub
fi

if [[ "$PLATFORM" == "linux" ]]; then
  export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
  # brew() {
  #   CURR=$(pwd)
  #   cd /tmp; sudo -Hu brew $HOMEBREW_PREFIX/bin/brew $@; cd ${CUR}
  # }
elif [[ "$PLATFORM" == "darwin" ]]; then
  # mac intel, no no
  export HOMEBREW_PREFIX=/opt/homebrew
fi

export HOMEBREW_NO_AUTO_UPDATE=1
