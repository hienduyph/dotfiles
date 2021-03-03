source "$HOME/dotfiles/shell/vars.sh"

alias nvim5="/opt/neovim/bin/nvim -u ~/dotfiles/vim/nvim.vim"
alias vim="nvim5"
alias vi="vim"
alias cat="bat"
alias ls="exa"
alias ll="ls -l"
alias l="ls -la"
alias tree="ls -T"

alias plz="sudo"
alias v="vim"
alias vimd="vim -u None"
alias tn="tmux new-session -A -s"
alias lala="tmux new -A -s Lala"
alias awm="aws --endpoint-url http://localhost:9000"
alias kk="$GOPATH/bin/kaf"
alias py="python"
alias ipy="ipython"
alias pycli="$PYCLI_HOME/bin/python"
alias pgcli="$PYCLI_HOME/bin/pgcli"
alias mycli="$PYCLI_HOME/bin/mycli"
alias gurl="grpcurl"

alias rr="echo 'Reload ~/.profile' && source ~/.profile"

# alias y2j="$HOME/.venv/cli/bin/python -c 'import sys, yaml, json; y=yaml.safe_load(sys.stdin.read()); json.dump(y, sys.stdout, indent=2)'"
alias y2j="yaml2json"
# alias j2y="$HOME/.venv/cli/bin/python -c 'import sys, yaml, json; sys.stdout.write(yaml.dump(json.load(sys.stdin)))'"
alias j2y="json2yaml"

alias i="istioctl"
alias ktz="kustomize"
alias kf="kfctl"
alias kdf="k diff -f"
alias kdfs="kubectl diff -f -"
alias kafs="kubectl apply -f -"
alias kpf="kubectl port-forward"
alias ktx="kubectx"
alias kns="kubens"
alias dk="docker"
alias dkm="docker-compose"
alias htop="htop -s PERCENT_MEM"

# git plugins

alias gpm="git pull origin master"
alias lgit="lazygit"
alias gcdd='git checkout dev'



fkill() {
  ps aux | grep  $1 | awk {'print $2'} | xargs kill -9
}

docker_rm_badimg() {
  docker rmi -f $(docker images -f "dangling=true" -q)
}

bqq() {
  if [ -z $1 ] || [ -z $2 ]; then
    echo 'Required table & sql'
    exit 1
  fi
  bq query --destination_table $1 --replace --use_legacy_sql=false $2
}

bqx() {
  if [ -z $1 ] || [ -z $2 ]; then
    echo 'Require table & dest'
    exit 1
  fi
  bq extract --destination_format NEWLINE_DELIMITED_JSON $1 $2
}
