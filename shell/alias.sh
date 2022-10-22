alias vim="nvim"
alias gurl="grpcurl"
alias ls="exa"
alias cat="bat"

alias y2j="yq -o json"
alias j2y="yq -P"

alias kdf="kubectl diff -f"
alias kdfs="kubectl diff -f -"
alias kafs="kubectl apply -f -"
alias kpf="kubectl port-forward"
alias ktx="kubectl ctx"
alias kns="kubectl ns"
alias ktz="kustomize"

alias se="sudoedit"
alias bytes="numfmt --to=iec-i"
alias yt-mp3="yt-dlp --extract-audio --audio-format mp3"

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
