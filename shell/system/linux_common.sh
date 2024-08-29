alias open="xdg-open"

u() {
  if command -v rustup > /dev/null; then
    rustup update
  fi
  if command -v flatpak > /dev/null; then
    flatpak --user update -y
    flatpak --user uninstall --unused -y
  fi

  # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  nvim --headless "+Lazy! update" +qa
  nvim --headless -c 'TSUpdateSync' -c 'quitall'

  if command -v nix-channel > /dev/null; then
    nix-channel --update
    home-manager build
    home-manager switch
  fi

  if command -v brew > /dev/null; then
    brew update && brew upgrade && brew cleanup
  fi
}

[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
addToPATH "$HOME/.local/share/coursier/bin"

ZSH_VERSION=$(zsh --version | awk '{print $2}')
export FPATH=${FPATH}:/usr/share/zsh/${ZSH_VERSION}/functions

