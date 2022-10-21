export HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

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

u() {
  echo "Updating gopls"
  brew update && brew upgrade && brew cleanup

  if command -v rustup > /dev/null; then
    echo "Updating rust"
    rustup update
  fi
}
