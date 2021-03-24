call plug#begin(g:plug_dir)
" misc plugins
Plug 'bronson/vim-trailing-whitespace'
Plug 'nvim-lua/plenary.nvim'

Plug 'lewis6991/gitsigns.nvim'

Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editor config
Plug 'editorconfig/editorconfig-vim'

Plug 'rafalbromirski/vim-aurora'

Plug 'ryanoasis/vim-devicons'

Plug 'preservim/nerdcommenter'
" Plug 'tpope/vim-surround'


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

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'

" python specific
Plug 'psf/black', { 'branch': 'stable' }

" formatter
Plug 'rhysd/vim-clang-format'

Plug 'francoiscabrol/ranger.vim'

Plug 'rbgrouleff/bclose.vim'

Plug 'akinsho/nvim-bufferline.lua'

call plug#end()
