call plug#begin('~/.local/share/nvim5/plugged')
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
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'

Plug 'neovim/nvim-lspconfig'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

Plug 'sheerun/vim-polyglot'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()