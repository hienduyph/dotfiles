#!/bin/bash

# install neovim as root
set -ex

WORK_DIR=$(dirname $(realpath "$0"))
ROOT_CONF=$HOME/.config/nvim
NVIM=$HOME/.local/share/nvim

mkdir -p ${ROOT_CONF} $NVIM
sudo rm -rf ${ROOT_CONF}/lua

read -d '' content << EOF || true
exec 'source' '${WORK_DIR}/shared.vim'

let g:engine = \$LSP_ENGINE

if !exists("g:engine")
  let g:engine="coc"
endif

let g:lsp_enable = g:engine == "nvim"
let g:plug_dir = "${NVIM}/plugged/" . g:engine


exec 'source' '${WORK_DIR}/plugin.vim'
exec 'source' '${WORK_DIR}/config/02.0keymaps.vim'
exec 'source' '${WORK_DIR}/config/02.init.vim'
exec 'source' '${WORK_DIR}/config/03.parties.vim'
exec 'source' '${WORK_DIR}/config/03.slime.vim'

if has(g:lsp_enable == 1) && has('nvim-0.5')
  exec 'source' '${WORK_DIR}/neovim/lsp.vim'
else
  exec 'source' '${WORK_DIR}/config/07.coc.vim'
endif

if has('nvim')
  exec 'source' '${WORK_DIR}/neovim/config.vim'
endif

if \$WSL_ENABLED == "yes"
  exec 'source' '${WORK_DIR}/config/02.wsl.vim'
endif

let g:rnvimr_ranger_cmd = '/opt/cli/bin/ranger --cmd="set draw_borders both"'

set runtimepath+=g:plug_dir
let g:airline_section_b = 'mrq %{strftime("%H:%M")}'
EOF

echo "${content}" > ${ROOT_CONF}/init.vim
curl -fLo ${NVIM}/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


ln -s "${WORK_DIR}/neovim/lua" "${ROOT_CONF}/lua"
ln -s "${WORK_DIR}/coc-settings.json" "${ROOT_CONF}"
