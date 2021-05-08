exec 'source' '~/dotfiles/vim/shared.vim'

let g:plug_dir = '~/.local/share/nvim/plugged'
let g:lsp_enable = 0
let g:lsc = 0

exec 'source' '~/dotfiles/vim/plugin.vim'

exec 'source' '~/dotfiles/vim/config/02.0keymaps.vim'
exec 'source' '~/dotfiles/vim/config/02.init.vim'
exec 'source' '~/dotfiles/vim/config/03.parties.vim'
exec 'source' '~/dotfiles/vim/config/03.slime.vim'

if g:lsp_enable == 1
  exec 'source' '~/dotfiles/vim/neovim/lsp.vim'
elseif g:lsc == 1
  exec 'source' '~/dotfiles/vim/config/07.lsc.vim'
else
  exec 'source' '~/dotfiles/vim/config/07.coc.vim'
endif

if has('nvim-0.5')
  exec 'source' '~/dotfiles/vim/neovim/config.vim'
endif

set cmdheight=1
let g:rnvimr_ranger_cmd = '~/.venv/neovim/bin/ranger --cmd="set draw_borders both"'
set runtimepath+=g:plug_dir

" Show clocks
let g:airline_section_b = 'mrq %{strftime("%H:%M")}'
