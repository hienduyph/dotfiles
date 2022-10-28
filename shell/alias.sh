alias vim="nvim"
alias gurl="grpcurl"
alias ls="exa"
alias cat="bat --paging=never"
alias less="bat"

alias y2j="yq -o json"
alias j2y="yq -P"

alias ktz="kustomize"

alias se="sudoedit"
alias yt-mp3="yt-dlp --extract-audio --audio-format mp3"

fetch_git_ignore() {
  langs=$1
  curl https://www.toptal.com/developers/gitignore/api/linux,macos,${langs} >> .gitignore
}

alias pipr="python -m pip install -r requirements.txt"
