let g:nvim_config_root = stdpath('config')

exec 'source' g:nvim_config_root . '/shared.vim'
exec 'source' g:nvim_config_root . '/config/01.pre.vim'

let data_dir = has('nvim') ? stdpath('data') : '~/.vim'
let g:plug_dir = data_dir . "/plugged"

let g:slime_enable = 0
let g:telescope = 1

exec 'source' g:nvim_config_root . '/plugin.vim'
exec 'source' g:nvim_config_root . '/config/02.0keymaps.vim'
exec 'source' g:nvim_config_root . '/config/02.init.vim'
exec 'source' g:nvim_config_root . '/neovim/lsp.vim'
exec 'source' g:nvim_config_root . '/neovim/config.vim'

set cmdheight=1
set runtimepath+=g:plug_dir

" Include after hook
exec 'source' g:nvim_config_root . '/config/after.vim'
