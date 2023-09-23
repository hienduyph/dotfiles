alias vim="nvim"
alias vi="nvim"
alias gurl="grpcurl"
alias cl="curlie"
alias ls="exa"
alias l="ls -la"
alias cat="bat --paging=never"
alias less="bat"
alias fp="flatpak --user"
alias k="kubectl"
alias czm="chezmoi"

alias y2j="yq -o json"
alias j2y="yq -P"

alias ktz="kustomize"

alias se="sudoedit"
alias yt-mp3="yt-dlp --extract-audio --audio-format mp3"
alias yt-lossless="yt-dlp --extract-audio --audio-format best"

fetch_git_ignore() {
  langs=$1
  curl https://www.toptal.com/developers/gitignore/api/linux,macos,${langs} >> .gitignore
}

alias pipr="python -m pip install -r requirements.txt"
