vim.diagnostic.config({
  virtual_text = false
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require "nvim-web-devicons".setup {}
require("kommentary.config").use_extended_mappings()

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
});
require('mini.align').setup()

-- use tree sitter
require "nvim-treesitter.configs".setup {
  ensure_installed = { "c", "lua", "rust", "bash", "go", "python", "yaml", "dart", "nix", "java", "kotlin", "typescript",
    "javascript" },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  yati = {
    enable = true,
    -- Disable by languages, see `Supported languages`
    disable = { "python" },

    -- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
    default_lazy = true,

    -- Determine the fallback method used when we cannot calculate indent by tree-sitter
    --   "auto": fallback to vim auto indent
    --   "asis": use current indent as-is
    --   "cindent": see `:h cindent()`
    -- Or a custom function return the final indent result.
    default_fallback = "auto"
  },
}

require("indent_blankline").setup {
  char = "|",
  buftype_exclude = { "terminal", "dashboard" },
  space_char_blankline = " ",
  use_treesitter = true,
  char_list = { "|", "¦", "┆", "┊" },
  show_current_context = true,
  show_current_context_start = true,
}
vim.cmd [[highlight IndentBlanklineChar guifg=#dedede gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#cfcccc gui=nocombine]]

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
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress", "diff" },
    lualine_z = { "location" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
  },
})

require "nvim-tree".setup {
  view = {
    width = 40,
  },
  update_focused_file = {
    enable = true,
  },
  filters = {
    dotfiles = false,
    custom = { "^\\.git$", "node_modules", "^\\.cache", "__pycache__", "\\.direnv", "\\.ipynb_checkpoints", "vendor" },
  },
  actions = {
    open_file = {
      resize_window = false,
      window_picker = {
        enable = false,
      },
    },
  },
}

require("bufferline").setup {
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
}

require("nvim-surround").setup({})

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = { exclude = {} },
})

require 'fzf-lua'.setup {
  winopts = {
    preview = {
      delay = 60,
    },
  },
}
require('gitsigns').setup()

require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string" }, -- it will not add a pair on that treesitter node
    javascript = { "template_string" },
    java = false, -- don"t check treesitter on java
  }
})

require("rust-tools").setup({})

require('glow').setup({
  style = "light",
})

require("exrc").setup({
  files = {
    ".nvimrc.lua",
    ".nvimrc",
    ".exrc.lua",
    ".exrc",
  },
})
