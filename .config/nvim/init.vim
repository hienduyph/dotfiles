let g:nvim_config_root = stdpath('config')

exec 'source' g:nvim_config_root . '/shared.vim'

let data_dir = has('nvim') ? stdpath('data') : '~/.vim'
let g:plug_dir = data_dir . "/plugged"

let g:slime_enable = 0
let g:telescope = 1

exec 'source' g:nvim_config_root . '/plugin.vim'
exec 'source' g:nvim_config_root . '/config/02.0keymaps.vim'
exec 'source' g:nvim_config_root . '/config/02.init.vim'

lua require("q.config")
lua require("q.cmd")
lua require("q.keymap")
lua require('q.telescope')
lua require("q.lsp")
lua require('q.completion')

set cmdheight=1
set runtimepath+=g:plug_dir

" Include after hook
exec 'source' g:nvim_config_root . '/config/after.vim'
