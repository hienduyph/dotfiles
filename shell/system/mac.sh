export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

u() {
  brew update && brew upgrade && brew cleanup
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  nvim --headless -c 'TSUpdateSync' -c 'quitall'
}
