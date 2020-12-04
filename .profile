export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NNN_USE_EDITOR=1

export GOPATH="$HOME/go"

export PATH="$HOME/.local/bin:$GOPATH/bin:/usr/local/opt/qt/bin:$PATH:/usr/local/sbin:$HOME/google-cloud-sdk/bin"
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

if [[ -f $HOME/.venv/cli/bin/python ]]; then
  export PATH="$PATH:$HOME/.venv/cli/bin";
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore --follow -g "!{.git,node_modules,vendor,.direnv,.mypy_cache,__pycache__,target,.pytest_cache}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"

export PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

case "$PLATFORM" in
   darwin)
     ;;
   linux)
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection c -o'
     ;;
   CYGWIN*|MINGW32*|MSYS*|MINGW*)
     ;;
esac

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# source secrets files
export PROFILE_EXTRA_DIRS=$HOME/.profile_src

if [[ -d $PROFILE_EXTRA_DIRS ]]; then
  for filename in $PROFILE_EXTRA_DIRS/*.sh; do
    source $filename
  done
fi

export GPG_TTY=${TTY}

source "$HOME/dotfiles/shell/alias.sh"
