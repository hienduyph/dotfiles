alias vim="nvim"
alias vi="nvim"
alias gurl="grpcurl"
alias cl="curlie"
alias ls="_ls_cmd"
alias cat="_cat_cmd"
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

fetch_git_ignore() {
  langs=$1
  curl https://www.toptal.com/developers/gitignore/api/linux,macos,${langs} >> .gitignore
}
_ls_cmd() {
  if command -v lsd >/dev/null 2>&1; then
    lsd $@
  else
    /usr/bin/ls $@
  fi
}
_cat_cmd() {
  if command -v bat >/dev/null 2>&1; then
    bat $@
  else
    /usr/bin/cat $@
  fi
}


alias pipr="python -m pip install -r requirements.txt"
alias tb="toolbox run -c q tmux -S ${XDG_RUNTIME_DIR}/box-tmux new-session -A -s $(hostname -s)_box"
