alias gurl="grpcurl"
alias l="ls -la"
alias ll="ls -l"
alias y2j="yq -o json"
alias j2y="yq -P"

alias ktz="kustomize"

alias yt-mp3="yt-dlp --extract-audio --audio-format mp3"
alias yt-lossless="yt-dlp --extract-audio --audio-format best"

alias tm="tmux new-session -A -s $(hostname -s)"

export BOX_NAME=q

box() {
	args=(
		--
		zsh
	)
	if [[ ! $# -eq 0 ]]; then
		args+=(-lc)
		distrobox enter ${BOX_NAME} ${args[@]} "$*"
	else
		distrobox enter ${BOX_NAME} ${args[@]}
	fi
}

qsh() {
  distrobox enter ${BOX_NAME} -- tmux -S ${XDG_RUNTIME_DIR}/tmux new-session -A -s $(hostname -s)-box
}

fetch_git_ignore() {
	langs=$1
	curl https://www.toptal.com/developers/gitignore/api/linux,macos,${langs} >>.gitignore
}
alias pipr="python -m pip install -r requirements.txt"
