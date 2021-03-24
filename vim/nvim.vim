exec 'source' '~/dotfiles/vim/shared.vim'

let g:plug_dir = '~/.local/share/nvim/plugged'

exec 'source' '~/dotfiles/vim/neovim/01.plugins.vim'
exec 'source' '~/dotfiles/vim/config/02.0keymaps.vim'
exec 'source' '~/dotfiles/vim/config/02.init.vim'
exec 'source' '~/dotfiles/vim/config/03.parties.vim'
exec 'source' '~/dotfiles/vim/config/03.slime.vim'
exec 'source' '~/dotfiles/vim/neovim/lsp.vim'
exec 'source' '~/dotfiles/vim/neovim/formatter.vim'

set cmdheight=1
let g:rnvimr_ranger_cmd = '~/.venv/neovim/bin/ranger --cmd="set draw_borders both"'
set runtimepath+=g:plug_dir
