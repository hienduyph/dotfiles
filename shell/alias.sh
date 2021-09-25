alias vi="vim"
alias vim="nvim"
alias cat="bat"
alias ls="exa"
alias ll="ls -l"
alias l="ls -la"
alias tree="ls -T"
alias man="tldr"

alias plz="sudo"
alias v="vim"
alias tn="tmux new-session -A -s"
alias lala="tmux new -A -s Lala"
alias awm="aws --endpoint-url http://localhost:9000"
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
alias dk="podman"
alias dkm="podman-compose"
alias htop="htop -s PERCENT_MEM"

# git plugins

alias gpm="git pull origin master"
alias lgit="lazygit"
alias gcdd='git checkout dev'
alias gdf="forgit::diff"
alias se="sudoedit"
alias bytes="numfmt --to=iec-i"
alias sc='sudo SYSTEMD_EDITOR=nvim /usr/bin/systemctl'

input_fonts() {
  _TMP_FILE=/tmp/font_dl.zip
  rm -f ${_TMP_FILE}
  url="https://input.djr.com/build/?fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do&email="
  dir=$HOME/.local/share/fonts/
  echo "Downloading"
  curl -fsSL -o $_TMP_FILE $url
  unzip $_TMP_FILE -d /tmp
  echo "Extra"
  cp -r /tmp/Input_Fonts/InputMono  /tmp/Input_Fonts/InputSans /tmp/Input_Fonts/InputSerif $dir
  echo "Done"
}


fkill() {
  ps aux | grep  $1 | awk {'print $2'} | xargs kill -9
}

docker_rm_badimg() {
  podman rmi -f $(podman images -f "dangling=true" -q)
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

gch() {
 git checkout "$(git branch | fzf| tr -d '[:space:]')"
}

go_mod_update() {
  go list -f '{{if not (or .Main .Indirect)}}{{.Path}}{{end}}' -m all | xargs -n 1 bash -c 'echo $0; go get -d $0 || true'
}

git_large_file() {
  git rev-list --objects --all |
    git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
    sed -n 's/^blob //p' |
    sort --numeric-sort --key=2 |
    cut -c 1-12,41- |
    $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}
