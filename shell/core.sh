export EDITOR=vim
export VISUAL=vim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export NNN_USE_EDITOR=1
export NPM_PACKAGES="${HOME}/.npm-packages"
export RUSTC_WRAPPER=sccache
export GOPATH="$HOME/.go"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export PATH="$HOME/.local/bin:$GOPATH/bin:/usr/local/opt/qt/bin:$PATH:/usr/local/sbin:$HOME/google-cloud-sdk/bin:$NPM_PACKAGES/bin:$HOME/.deno/bin"

export XDG_CONFIG_HOME="$HOME/.config"

if [[ -f $HOME/.cargo/env ]]; then
  source $HOME/.cargo/env
fi

if [[ -f /usr/local/opt/python@3.9/bin/python3.9 ]]; then
  export PATH="$PATH:/usr/local/opt/python@3.9/bin/"
fi

if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin";
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore --follow -g "!{.git,node_modules,vendor,.direnv,.mypy_cache,__pycache__,target,.pytest_cache,.next}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"
