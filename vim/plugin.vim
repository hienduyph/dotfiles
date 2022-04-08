" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(g:plug_dir)

" Theme trying collections, put currenty used at top
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'sainnhe/gruvbox-material'
Plug 'kyazdani42/nvim-web-devicons'
" Lua libs
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

Plug 'nvim-lua/popup.nvim'

Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'b3nj5m1n/kommentary'
Plug 'windwp/nvim-autopairs'
Plug 'folke/twilight.nvim'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'leoluz/nvim-dap-go'
Plug 'simrat39/rust-tools.nvim'
Plug 'akinsho/flutter-tools.nvim'
" show function signature
Plug 'SmiteshP/nvim-gps'
" motion plugins
Plug 'ggandor/lightspeed.nvim'
Plug 'VonHeikemen/searchbox.nvim'

if g:telescope == 1
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-dap.nvim'
else
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
endif

Plug 'voldikss/vim-floaterm'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'

" Markdown writting
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" formatter
Plug 'rhysd/vim-clang-format'

Plug 'editorconfig/editorconfig-vim'
" code linter
Plug 'dense-analysis/ale'

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

Plug 'TovarishFin/vim-solidity'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()
