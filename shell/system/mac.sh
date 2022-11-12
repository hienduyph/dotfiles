export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

u() {
  brew update && brew upgrade && brew cleanup
}
