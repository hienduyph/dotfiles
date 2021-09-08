let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 0
let g:ale_linters = {
  \'go': ['golangci-lint'],
  \'c': ['clangd'],
  \'cpp': ['clangd'],
\}
let g:ale_linters_explicit = 1

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(g:plug_dir)

" misc plugins
Plug 'bronson/vim-trailing-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme trying collections, put currenty used at top
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" Plug 'marko-cerovac/material.nvim'
" Plug 'rafalbromirski/vim-aurora'
" Plug 'ayu-theme/ayu-vim'
" Plug 'yashguptaz/calvera-dark.nvim'


if has('nvim-0.5')
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
else
  Plug 'airblade/vim-gitgutter'
  Plug 'ryanoasis/vim-devicons'
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endif

Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdcommenter'
Plug 'kevinhwang91/rnvimr'


Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" work with ipython
if exists("g:slime_enable")  && g:slime_enable == 1
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
endif

" formatter
Plug 'rhysd/vim-clang-format'

" code linter
" Plug 'dense-analysis/ale'

if g:lsp_enable == 1
  Plug 'neovim/nvim-lspconfig'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'hrsh7th/nvim-cmp'
  " source for cmp
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'saadparwaiz1/cmp_luasnip'

  " snippets collections
  Plug 'rafamadriz/friendly-snippets'

  Plug 'psf/black'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
else
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" Debug tools
Plug 'puremourning/vimspector'
call plug#end()
