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


LINUX_BREW=/home/linuxbrew/.linuxbrew
HOMEBREW_PREFIX=/opt/homebrew

# set brew prefix
BREW_PREFIX=""
if [[ -f "${LINUX_BREW}/bin/brew" ]]; then
  BREW_PREFIX=$LINUX_BREW
elif [[ -f "${HOMEBREW_PREFIX}/bin/brew" ]]; then
  BREW_PREFIX=$HOMEBREW_PREFIX
elif [ -x "$(command -v brew)" ]; then
  BREW_PREFIX="$(brew --prefix)"
fi

export BREW_PREFIX=${BREW_PREFIX}
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
