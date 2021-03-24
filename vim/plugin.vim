call plug#begin(g:plug_dir)

" misc plugins
Plug 'bronson/vim-trailing-whitespace'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editor config
Plug 'editorconfig/editorconfig-vim'

Plug 'rafalbromirski/vim-aurora'
Plug 'ryanoasis/vim-devicons'

Plug 'preservim/nerdcommenter'
Plug 'voldikss/vim-floaterm'
Plug 'kevinhwang91/rnvimr'
Plug 'rbgrouleff/bclose.vim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'neoclide/jsonc.vim'

" work with ipython
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" formatter
Plug 'rhysd/vim-clang-format'

if has(g:lsp_enable)
  " auto complete
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/lsp-status.nvim'
else
  " auto complete engine
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'
end

if has('nvim')
  "enable nvim features
  Plug 'akinsho/nvim-bufferline.lua'
  Plug 'nvim-lua/plenary.nvim'

  " repalce for gitgutter
  Plug 'lewis6991/gitsigns.nvim'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

  " python specific
  Plug 'psf/black', { 'branch': 'stable' }
else
  "fallback vim features
  Plug 'sheerun/vim-polyglot'
  Plug 'Yggdroot/indentLine'
endif

call plug#end()
