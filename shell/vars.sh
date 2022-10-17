export PYCLI_HOME=/opt/cli
export NEOVIM_HOST=$HOME/.venv/neovim
export NNN_USE_EDITOR=1
export NPM_CONFIG_PREFIX="${HOME}/.npm-packages"
export RUSTC_WRAPPER=sccache
export GOPATH="$HOME/.go"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export BASHMAN_DIR=$HOME/.config/bashman
export ANDROID_HOME=$HOME/Android/Sdk

export BREW_PREFIX=$HOME/.local/brew
export HOMEBREW_PREFIX=$BREW_PREFIX
export HOMEBREW_CELLAR=$BREW_PREFIX/Cellar
export HOMEBREW_BUILD_FROM_SOURCE=0
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

export PORT_PREFIX=/opt/local

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

export EDITOR=nvim
export VISUAL=nvim
export SYSTEMD_EDITOR=nvim
export KUBE_EDITOR=nvim

alias pipcli=${PYCLI_HOME}/bin/pip

export PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"
export PROFILE_EXTRA_DIRS=$HOME/.profile_src
# ranger bat style
export BAT_THEME=GitHub

