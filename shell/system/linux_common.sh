u() {
  if command -v rustup > /dev/null; then
    rustup self update
    rustup update
  fi
  echo "Updating gopls"
  GO111MODULE=on go install golang.org/x/tools/gopls@latest

  echo "node pkg updates"
  npm i -g -u tree-sitter-cli pyright prettier typescript-language-server yaml-language-server typescript vscode-langservers-extracted bash-language-server

  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
