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

" snippet
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

if g:lsp_enable == 1 && has('nvim-0.5')
  " auto complete
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  " python specific
  Plug 'psf/black', { 'branch': 'stable' }

  Plug 'nvim-lua/lsp_extensions.nvim'
else
  " auto complete engine
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'
end

if has('nvim-0.5')
  "enable nvim features
  Plug 'akinsho/nvim-bufferline.lua'
  " lua utils
  Plug 'nvim-lua/plenary.nvim'

  " repalce for gitgutter
  Plug 'lewis6991/gitsigns.nvim'

  " better syntax highlight
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
else
  "fallback vim features
  Plug 'sheerun/vim-polyglot'
  Plug 'Yggdroot/indentLine'
endif

call plug#end()
