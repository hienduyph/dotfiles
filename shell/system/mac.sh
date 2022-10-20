# JAVA stuff
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"

# export BREW_PREFIX=$HOME/.local/brew
# export HOMEBREW_PREFIX=$BREW_PREFIX
# export HOMEBREW_CELLAR=$BREW_PREFIX/Cellar
# export HOMEBREW_BUILD_FROM_SOURCE=0
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

export PORT_PREFIX=/opt/local


nvim_nightly() {(
  DST_DIR=/opt/neovim-nightly
  if [ ! -d ${DST_DIR} ]; then
    echo "Init the dest folder first: ${DST_DIR}"
    sudo mkdir -p ${DST_DIR}
    sudo chown -R $(whoami) ${DST_DIR}
  fi
  set -e
  echo "update nvim nightly"
  TMP_DIR=/tmp/neovim
  rm -rf $TMP_DIR && mkdir -p $TMP_DIR
  echo "Downloading"
  curl -fsSL https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz | tar xz -C ${TMP_DIR} --strip-components=1
  echo "Extrating"
  rm -rf ${DST_DIR}/* || true && mv $TMP_DIR/* ${DST_DIR}/
  ln -sf ${DST_DIR}/bin/nvim $HOME/.local/bin/vv
  echo "Done!"
  )}

sysu() {
  sudo port selfupdate
  sudo port upgrade outdated
  if command -v rustup > /dev/null; then
    echo "Updating rust"
    rustup update
  fi
}

u() {
  echo "Updating gopls"
  GO111MODULE=on go install golang.org/x/tools/gopls@latest

  npm i --location=global pyright prettier typescript-language-server yaml-language-server typescript vscode-langservers-extracted bash-language-server
}
