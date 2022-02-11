export PYCLI_HOME=/opt/cli
export NEOVIM_HOST=$HOME/.venv/neovim
export NNN_USE_EDITOR=1
export NPM_PACKAGES="${HOME}/.npm-packages"
export RUSTC_WRAPPER=sccache
export GOPATH="$HOME/.go"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export LINUX_BREW=/home/linuxbrew/.linuxbrew

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
