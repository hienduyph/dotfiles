#!/bin/bash

# install neovim as root

WORK_DIR=$(dirname $(realpath "$0"))
ROOT_CONF=/root/.config/nvim
NVIM=/root/.local/share/nvim/

mkdir -p ${ROOT_CONF} ${ROOT_CONF}/lua $NVIM

read -d '' content << EOF || true
let g:nvim_system_wide = 1
exec 'source' '${WORK_DIR}/shared.vim'

let g:plug_dir = '$NVIM/plugged'

exec 'source' '${WORK_DIR}/neovim/01.plugins.vim'
exec 'source' '${WORK_DIR}/config/02.0keymaps.vim'
exec 'source' '${WORK_DIR}/config/02.init.vim'
exec 'source' '${WORK_DIR}/config/03.parties.vim'
exec 'source' '${WORK_DIR}/config/03.slime.vim'
exec 'source' '${WORK_DIR}/neovim/lsp.vim'
exec 'source' '${WORK_DIR}/neovim/formatter.vim'
let g:rnvimr_ranger_cmd = '/opt/cli/bin/ranger --cmd="set draw_borders both"'
EOF

echo "${content}" > ${ROOT_CONF}/init.vim
curl -fLo ${NVIM}/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


ln -s "${WORK_DIR}/neovim/lua/lsp.lua" "${ROOT_CONF}/lua"
