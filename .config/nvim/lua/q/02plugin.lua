local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = false,
  },
}

require("lazy").setup({
  -- core libs
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  { "nvim-tree/nvim-web-devicons", config = true },

  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "vim",
          "lua",
          "bash",
          "ruby",
          "python",
          "php",
          "c",
          "rust",
          "go",
          "gomod",
          "gosum",
          "gitignore",
          "dockerfile",
          "cpp",
          "dart",
          "yaml",
          "json",
          "jsonc",
          "json5",
          "terraform",
          "java",
          "kotlin",
          "typescript",
          "javascript",
          "html",
          "toml",
          "markdown",
          "markdown_inline",
          "css",
          "scss",
          "sql",
          "proto",
          "make",
          "cmake",
          "latex",
          "kdl",
        },
        autopairs = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { "yaml", "python" },
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  {
    "echasnovski/mini.nvim",
    branch = "main",
    config = function()
      require("mini.base16").setup({
        palette = {
          base00 = "#ffffff",
          base01 = "#f6f8eb",
          base02 = "#dbe1ac",
          base03 = "#73765a",
          base04 = "#324490",
          base05 = "#002a83",
          base06 = "#0000e4",
          base07 = "#080500",
          base08 = "#5e2200",
          base09 = "#a86400",
          base0A = "#008818",
          base0B = "#004500",
          base0C = "#b34aad",
          base0D = "#004b76",
          base0E = "#7d0077",
          base0F = "#0086ae",
        },
        use_cterm = {
          base00 = 254,
          base01 = 250,
          base02 = 246,
          base03 = 243,
          base04 = 60,
          base05 = 18,
          base06 = 4,
          base07 = 232,
          base08 = 52,
          base09 = 130,
          base0A = 28,
          base0B = 22,
          base0C = 133,
          base0D = 24,
          base0E = 90,
          base0F = 31,
        },
      })
      require("mini.align").setup()
    end,
  },
  { "numToStr/Comment.nvim",       config = true },
  { "lewis6991/gitsigns.nvim",     config = true },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        git = { enable = false },
        view = {
          width = 40,
        },
        update_focused_file = {
          enable = true,
        },
        filters = {
          dotfiles = false,
          custom = {
            "^\\.git$",
            "node_modules",
            "^\\.cache",
            "__pycache__",
            "\\.direnv",
            "\\.ipynb_checkpoints",
            "vendor",
          },
        },
        actions = {
          open_file = {
            resize_window = false,
            window_picker = {
              enable = false,
            },
          },
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          always_show_bufferline = true,
        },
        extensions = { "quickfix", "nvim-tree", "fzf" },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 1,
            },
          },
          lualine_x = { "encoding", "filetype" },
          lualine_y = { "progress", "diff" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "|",
        buftype_exclude = { "terminal", "dashboard" },
        space_char_blankline = " ",
        use_treesitter = true,
        char_list = { "|", "¦", "┆", "┊" },
        show_current_context = true,
        show_current_context_start = true,
      })
      vim.cmd([[highlight IndentBlanklineChar guifg=#dedede gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineContextChar guifg=#cfcccc gui=nocombine]])
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" }, -- it will not add a pair on that treesitter node
          javascript = { "template_string" },
          java = false,       -- don"t check treesitter on java
        },
      })
    end,
  },

  {
    'ibhagwan/fzf-lua',
    config = function()
      vim.keymap.set("n", "<C-f>", function()
        require('fzf-lua').files()
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-g>", function()
        require('fzf-lua').live_grep()
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-i>", function()
        require('fzf-lua').buffers()
      end, { noremap = true, silent = true })
    end,
    requires = { 'nvim-tree/nvim-web-devicons' },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",

      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      "SmiteshP/nvim-navic",
    },
  },

  { "b0o/schemastore.nvim" },

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    }
  },

  { "simrat39/rust-tools.nvim", config = true },
  { "kylechui/nvim-surround",   config = true },
  "gpanders/editorconfig.nvim",
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.buf,
          null_ls.builtins.formatting.jq,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.formatting.sqlfluff.with({
            extra_args = { "--dialect", "postgres" },
          }),
        },
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  },
}, opts)
