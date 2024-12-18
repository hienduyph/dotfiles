alias vim="nvim"
alias vi="nvim"
alias gurl="grpcurl"
alias cl="curlie"
alias ls="lsd"
alias cat="bat"
alias l="ls -la"
alias ll="ls -l"
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

alias tm="tmux new-session -A -s $(hostname -s)"
alias q="tmux new-session -A -s Lala"
alias cmd="distrobox enter q --"

fetch_git_ignore() {
  langs=$1
  curl https://www.toptal.com/developers/gitignore/api/linux,macos,${langs} >> .gitignore
}
alias pipr="python -m pip install -r requirements.txt"
alias tb="distrobox enter q -- tmux -S ${XDG_RUNTIME_DIR}/tmux new-session -A -s $(hostname -s)-box"
