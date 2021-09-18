" setup ale
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 0
let g:ale_linters = {
  \'go': ['golangci-lint'],
  \'c': ['clangd'],
  \'cpp': ['clangd'],
\}
let g:ale_linters_explicit = 1
" only run in manual mode
let g:ale_lint_on_enter = 0

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(g:plug_dir)

if has('nvim-0.5')
  " Theme trying collections, put currenty used at top
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'b3nj5m1n/kommentary'
  Plug 'windwp/nvim-autopairs'
  Plug 'folke/twilight.nvim'
else
  Plug 'airblade/vim-gitgutter'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'rafalbromirski/vim-aurora'
  Plug 'Yggdroot/indentLine'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'preservim/nerdcommenter'
endif

if g:telescope == 1
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
else
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'kevinhwang91/rnvimr'
endif

Plug 'voldikss/vim-floaterm'
Plug 'godlygeek/tabular'

" Markdown writting
" Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" formatter
Plug 'rhysd/vim-clang-format'

Plug 'editorconfig/editorconfig-vim'
" Debug tools
Plug 'puremourning/vimspector'
" code linter
Plug 'dense-analysis/ale'

" work with ipython
if exists("g:slime_enable")  && g:slime_enable == 1
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
endif


" LSP Config
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
call plug#end()
