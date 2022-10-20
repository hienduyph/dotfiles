alias vi="vim"
alias vim="nvim"
alias cat="bat --theme GitHub"
alias ls="exa"

alias plz="sudo"
alias v="vim"
alias tn="tmux new-session -A -s"
alias lala="tmux new -A -s Lala"
alias awm="aws --endpoint-url http://localhost:9000"
alias py="python"
alias ipy="ipython"
alias gurl="grpcurl"
alias c="cheat"

alias pycli="source $PYCLI_HOME/bin/activate"

alias rr="echo 'Reload ~/.profile' && source ~/.profile"

alias y2j="yq -o json"
alias j2y="yq -P"


alias kdf="kubectl diff -f"
alias kdfs="kubectl diff -f -"
alias kafs="kubectl apply -f -"
alias kpf="kubectl port-forward"
alias ktx="kubectl ctx"
alias kns="kubectl ns"
alias ktz="kustomize"

alias dk="docker"
alias dkm="docker-compose"
alias pm="podman"
alias pmm="podman-compose"
alias spm="sudo podman"
alias sdkm="sudo podman-compose"

# git plugins

alias gpm="git pull origin master"
alias lgit="lazygit"
alias gcdd='git checkout dev'
alias gdf="forgit::diff"
alias se="sudoedit"
alias bytes="numfmt --to=iec-i"
alias df="duf"

alias yt-mp3="yt-dlp --extract-audio --audio-format mp3"

alias la="tmux new-session -A -s Lala"
alias q="tmux new-session -A -s q"
alias tm="tmux new-session -A -s"
alias f="ranger" # f=file

fetch_git_ignore() {
  langs=$1
  curl https://www.toptal.com/developers/gitignore/api/linux,macos,${langs} >> .gitignore
}

alias pipr="python -m pip install -r requirements.txt"

# setup env for warp as proxy
warpe() {
  export NO_PROXY=127.0.0.1,localhost
  export ALL_PROXY=socks5://127.0.0.1:1027
  export HTTPS_PROXY=socks5://127.0.0.1:1027
  export HTTP_PROXY=socks5://127.0.0.1:1027
}
