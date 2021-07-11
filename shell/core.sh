export NNN_USE_EDITOR=1
export NPM_PACKAGES="${HOME}/.npm-packages"
export RUSTC_WRAPPER=sccache
export GOPATH="$HOME/.go"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

SYSTEM="/usr/local/sbin:$HOME/.local/bin:$HOME/.bin"
THIRD_PARTIES="$GOPATH/bin:$HOME/.local/google-cloud-sdk/bin:$NPM_PACKAGES/bin:$HOME/.deno/bin"
export PATH="$PATH:${SYSTEM}:${THIRD_PARTIES}"

export XDG_CONFIG_HOME="$HOME/.config"

if [[ -f $HOME/.cargo/env ]]; then
  source $HOME/.cargo/env
fi

if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin";
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore --follow -g "!{.git,node_modules,vendor,.direnv,.mypy_cache,__pycache__,target,.pytest_cache,.next}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"


py_core_setup() {
  /usr/bin/env python -m pip install black pylint ipdb wheel pynvim --upgrade
}

# https://github.com/cheat/cheat
export CHEAT_USE_FZF=true
