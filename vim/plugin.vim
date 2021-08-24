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

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme trying collections, put currenty used at top
Plug 'folke/tokyonight.nvim'
" Plug 'marko-cerovac/material.nvim'
" Plug 'rafalbromirski/vim-aurora'
" Plug 'ayu-theme/ayu-vim'
" Plug 'yashguptaz/calvera-dark.nvim'

Plug 'ryanoasis/vim-devicons'
Plug 'voldikss/vim-floaterm'

Plug 'preservim/nerdcommenter'
Plug 'kevinhwang91/rnvimr'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" work with ipython
if exists("g:slime_enable")  && g:slime_enable == 1
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
endif

" formatter
Plug 'rhysd/vim-clang-format'

" snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" code linter
" Plug 'dense-analysis/ale'

if g:lsp_enable == 1
  Plug 'neovim/nvim-lspconfig'
  Plug 'psf/black'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  " source for cmp
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'saadparwaiz1/cmp_luasnip'
else
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'

" Debug tools
" Plug 'puremourning/vimspector'
call plug#end()
