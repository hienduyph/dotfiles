export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NNN_USE_EDITOR=1

export GOPATH="$HOME/go"

export PATH="$HOME/.local/bin:$GOPATH/bin:/usr/local/opt/qt/bin:$PATH:/usr/local/sbin:$HOME/google-cloud-sdk/bin"

if [[ -f $HOME/.cargo/env ]]; then
  source $HOME/.cargo/env
fi

if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  #$eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin";
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore --follow -g "!{.git,node_modules,vendor,.direnv,.mypy_cache,__pycache__}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"

case "$(uname -s)" in
   Darwin)
     ;;
   Linux)
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection c -o'
     ;;
   CYGWIN*|MINGW32*|MSYS*|MINGW*)
     ;;
esac

# alias config
alias plz="sudo"
alias emacs='emacs -nw'
alias vim="nvim"
alias vi="vim"
alias v="vim"
alias vimd="vim -u None"
alias cat="bat"
alias ls="exa"
alias tn="tmux new-session -A -s"
alias lala="tmux new -A -s Lala"
alias awm="aws --endpoint-url http://localhost:9000"
alias kk="$GOPATH/bin/kaf"

alias rr="echo 'Reload ~/.profile' && source ~/.profile"
alias rsync_git="rsync --exclude-from=.gitignore"
alias y2j="$HOME/.venv/python_packages/bin/python -c 'import sys, yaml, json; y=yaml.safe_load(sys.stdin.read()); json.dump(y, sys.stdout, indent=2)'"
alias json2yaml="$HOME/.venv/python_packages/bin/python -c 'import sys, yaml, json; sys.stdout.write(yaml.dump(json.load(sys.stdin)))'"
alias ktz="kustomize"
alias kdf="k diff -f"
alias kdfs="kubectl diff -f -"
alias kafs="kubectl apply -f -"
alias kpf="kubectl port-forward"
alias dk="docker"
alias dkm="docker-compose"

function docker_rm_badimg() {
  docker rmi -f $(docker images -f "dangling=true" -q)
}

export MANPAGER="sh -c 'col -bx | bat -l man -p'"


function bqq() {
  if [ -z $1 ] || [ -z $2 ]; then
    echo 'Required table & sql'
    exit 1
  fi
  bq query --destination_table $1 --replace --use_legacy_sql=false $2
}

function bqx() {
  if [ -z $1 ] || [ -z $2 ]; then
    echo 'Require table & dest'
    exit 1
  fi
  bq extract --destination_format NEWLINE_DELIMITED_JSON $1 $2
}

# source secrets files
export PROFILE_EXTRA_DIRS=$HOME/.profile_src

if [[ -d $PROFILE_EXTRA_DIRS ]]; then
  for filename in $PROFILE_EXTRA_DIRS/*.sh; do
    source $filename
  done
fi

fkill() {
  ps aux | grep  $1 | awk {'print $2'} | xargs kill -9
}

export GPG_TTY=${TTY}

tar_url() {
  dest=$1
  url=$2
  rm -rf /tmp/download.tar.gz
  curl -Lo /tmp/download.tar.gz $url
  rm -rf $dest/*
  mkdir -p $dest/
  tar -xf /tmp/download.tar.gz -C $dest --strip-components=1
}
