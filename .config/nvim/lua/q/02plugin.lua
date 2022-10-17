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
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require "nvim-web-devicons".setup {}
    end
  }

  use { 'echasnovski/mini.nvim', branch = 'stable' }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function() require("nvim-treesitter.install").update { with_sync = true } end,
  }
  use {
    "nvim-treesitter/nvim-treesitter-context",
  }

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end,
  }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'b3nj5m1n/kommentary',
    config = function()
      require("kommentary.config").use_extended_mappings()
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" }, -- it will not add a pair on that treesitter node
          javascript = { "template_string" },
          java = false, -- don"t check treesitter on java
        }
      })
    end
  }

  if vim.g.fzf then
    use { 'ibhagwan/fzf-lua',
      -- optional for icon support
      requires = { 'kyazdani42/nvim-web-devicons' },
    }
  else
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  end

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
  }

  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }

  use {
    'simrat39/rust-tools.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require("rust-tools").setup({})
    end
  }

  use "kylechui/nvim-surround"

  -- use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

