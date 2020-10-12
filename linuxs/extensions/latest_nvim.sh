#!/bin/bash
set -e

dest=/opt/neovim
sudo mkdir -p $dest
tar_url $dest https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
