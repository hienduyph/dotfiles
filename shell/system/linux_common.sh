u() {
  if command -v rustup > /dev/null; then
    rustup self update
    rustup update
  fi
  if command -v flatpak > /dev/null; then
    flatpak --user update -y
    flatpak --user uninstall --unused -y
  fi
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}
