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
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'dracula/vim'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'altercation/vim-colors-solarized'
Plug 'rafalbromirski/vim-aurora'

Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'scrooloose/nerdtree'

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'


Plug 'voldikss/vim-floaterm'

Plug 'kevinhwang91/rnvimr'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'neoclide/jsonc.vim'

" work with ipython
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" snip
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

call plug#end()
