let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 0
let g:ale_linters = {
  \'go': ['golangci-lint'],
  \'c': ['clangd'],
  \'cpp': ['clangd'],
\}
let g:ale_linters_explicit = 1

call plug#begin(g:plug_dir)

" misc plugins
Plug 'bronson/vim-trailing-whitespace'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Plug 'morhetz/gruvbox'
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
if exists("g:slime_enable")  && g:slime_enable == 1
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
endif

" formatter
Plug 'rhysd/vim-clang-format'

" snippet
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" code linter
Plug 'dense-analysis/ale'

if g:lsp_enable == 1
  " auto complete
  Plug 'neovim/nvim-lspconfig'
  " Plug 'nvim-lua/completion-nvim'
  Plug 'hrsh7th/nvim-compe'
  " python specific
  Plug 'psf/black'
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'ray-x/lsp_signature.nvim'
elseif exists("g:lsc") &&  g:lsc == 1
  Plug 'natebosch/vim-lsc'
else
  " auto complete engine
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
endif

if has('nvim-0.5')
  "enable nvim features
  Plug 'akinsho/nvim-bufferline.lua'
  " lua utils
  Plug 'nvim-lua/plenary.nvim'

  " repalce for gitgutter
  Plug 'lewis6991/gitsigns.nvim'

  " better syntax highlight
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
else
  "fallback vim features
  Plug 'sheerun/vim-polyglot'
endif
Plug 'Yggdroot/indentLine'
call plug#end()
