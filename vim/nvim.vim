exec 'source' '~/dotfiles/vim/shared.vim'
exec 'source' '~/dotfiles/vim/config/01.pre.vim'

let g:plug_dir = "~/.local/share/nvim/plugged/nvim"

let g:slime_enable = 0
let g:telescope = 1

exec 'source' '~/dotfiles/vim/plugin.vim'
exec 'source' '~/dotfiles/vim/config/02.0keymaps.vim'
exec 'source' '~/dotfiles/vim/config/02.init.vim'
exec 'source' '~/dotfiles/vim/config/02.theme.vim'
exec 'source' '~/dotfiles/vim/config/03.parties.vim'
exec 'source' '~/dotfiles/vim/neovim/lsp.vim'
exec 'source' '~/dotfiles/vim/neovim/config.vim'

if $WSL_ENABLED == "yes"
  exec 'source' '~/dotfiles/vim/config/02.wsl.vim'
endif

set cmdheight=1
let g:rnvimr_ranger_cmd = '~/.venv/neovim/bin/ranger --cmd="set draw_borders both"'
set runtimepath+=g:plug_dir

" Show clocks
let g:airline_section_b = 'mrq %{strftime("%H:%M")}'

" Include after hook
exec 'source' '~/dotfiles/vim/config/after.vim'
if exists("g:neovide")
  exec 'source' '~/dotfiles/vim/neovim/neovide.vim'
endif
