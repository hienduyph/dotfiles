set -e

INSTALL_DIR=$HOME/.local/nvim

DOWNLOAD_FILE=/tmp/nvim-macos.tar.gz

curl -Lo $DOWNLOAD_FILE https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
rm -rf $INSTALL_DIR $HOME/.local/bin/nvim && mkdir -p $INSTALL_DIR
tar -xf $DOWNLOAD_FILE -C $INSTALL_DIR --strip-components=1
rm -rf $DOWNLOAD_FILE
ln -s $INSTALL_DIR/bin/nvim $HOME/.local/bin

