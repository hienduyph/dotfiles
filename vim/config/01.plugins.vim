if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" misc plugins
Plug 'bronson/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Themes
"Plug 'joshdick/onedark.vim'
"Plug 'arzg/vim-colors-xcode'
"Plug 'tomasiser/vim-code-dark'
Plug 'rafalbromirski/vim-aurora'

Plug 'ryanoasis/vim-devicons'

" Tree
Plug 'scrooloose/nerdtree'

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'

" auto complete engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

Plug 'sheerun/vim-polyglot'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()
