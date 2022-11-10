local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- core libs
  use "nvim-lua/plenary.nvim"
  use 'kyazdani42/nvim-web-devicons'

  use {
    "nvim-treesitter/nvim-treesitter",
    run = function() require("nvim-treesitter.install").update { with_sync = true } end,
  }
  use { 'echasnovski/mini.nvim', branch = 'main' }
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use 'lewis6991/gitsigns.nvim'
  use "sindrets/diffview.nvim"
  use "kyazdani42/nvim-tree.lua"
  use "nvim-lualine/lualine.nvim"
  use 'akinsho/bufferline.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'b3nj5m1n/kommentary'

  use 'windwp/nvim-autopairs'

  use "ibhagwan/fzf-lua"

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
    'L3MON4D3/LuaSnip',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'jose-elias-alvarez/null-ls.nvim',
  }
  use 'simrat39/rust-tools.nvim'

  use "kylechui/nvim-surround"
  use "gpanders/editorconfig.nvim"

  if packer_bootstrap then
    require('packer').sync()
  end
end)
