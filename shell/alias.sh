alias vim="nvim"
alias vi="nvim"
alias gurl="grpcurl"
alias cl="curlie"
alias ls="lsd"
alias l="ls -la"
alias ll="ls -l"
alias cat="bat --paging=never"
alias less="bat"
alias fm="yazi"
alias fp="flatpak --user"
alias k="kubectl"
alias cm="chezmoi"

alias y2j="yq -o json"
alias j2y="yq -P"

alias ktz="kustomize"

alias se="sudoedit"
alias yt-mp3="yt-dlp --extract-audio --audio-format mp3"
alias yt-lossless="yt-dlp --extract-audio --audio-format best"

alias q="tmux new-session -A -s Lala"

fetch_git_ignore() {
  langs=$1
  curl https://www.toptal.com/developers/gitignore/api/linux,macos,${langs} >> .gitignore
}

alias pipr="python -m pip install -r requirements.txt"
