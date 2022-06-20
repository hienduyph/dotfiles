alias vi="vim"
alias vim="nvim"
alias cat="bat --theme GitHub"
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
alias c="cheat"

alias rr="echo 'Reload ~/.profile' && source ~/.profile"

alias y2j="yaml2json"
alias j2y="json2yaml"


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
alias sc='sudo SYSTEMD_EDITOR=nvim /usr/bin/systemctl'
alias df="duf"
alias du="ncdu"


alias yt-mp3="yt-dlp --extract-audio --audio-format mp3"
