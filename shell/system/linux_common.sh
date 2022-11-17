alias open="xdg-open"

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

  if command -v brew > /dev/null; then
    local CUR="$(pwd)"
    cd /tmp; brew update && brew upgrade && brew cleanup; cd ${CUR}
  fi
}
