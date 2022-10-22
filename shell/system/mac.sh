export HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

u() {
  brew update && brew upgrade && brew cleanup
}
