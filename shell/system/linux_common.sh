export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
alias open="xdg-open"
alias br="sudo -Hu brew $HOMEBREW_PREFIX/bin/brew"

u() {
  if command -v rustup > /dev/null; then
    rustup update
  fi
  if command -v flatpak > /dev/null; then
    flatpak --user update -y
    flatpak --user uninstall --unused -y
  fi

  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  nvim --headless -c 'TSUpdateSync' -c 'quitall'

  if command -v nix-channel > /dev/null; then
    nix-channel --update
    home-manager build
    home-manager switch
  fi

  if command -v br > /dev/null; then
    local CUR="$(pwd)"
    cd /tmp; br update && br upgrade && br cleanup; cd ${CUR}
  fi
}
