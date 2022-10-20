-- custom fonts
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

vim.diagnostic.config({
  virtual_text = false
})


local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"}
  },
  filetype = "gotmpl",
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}

-- use tree sitter
require"nvim-treesitter.configs".setup {
  ensure_installed = { "c", "lua", "rust", "bash", "go", "python", "yaml", "dart" , "nix"},
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("indent_blankline").setup {
  char = "|",
  buftype_exclude = {"terminal", "dashboard"},
  space_char_blankline=" ",
  use_treesitter=true,
  char_list={"|", "¦", "┆", "┊"},
  show_current_context = true,
  show_current_context_start = true,
}
vim.cmd[[highlight IndentBlanklineChar guifg=#dedede gui=nocombine]]
vim.cmd[[highlight IndentBlanklineContextChar guifg=#cfcccc gui=nocombine]]

require("lualine").setup({
  options = {
    theme = "gruvbox",
    always_show_bufferline=true,
  },
  extensions = {"quickfix", "nvim-tree", "fzf"},
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch"},
    lualine_c = {
      {
        "filename",
        file_status=true,
        path=1,
      },
    },
    lualine_x = {"encoding", "fileformat", "filetype"},
    lualine_y = {"progress", "diff"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
  },
})

require "nvim-tree".setup {
  view = {
    width = 60,
  },
  update_focused_file = {
    enable = true,
  },
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", ".cache", "__pycache__", ".direnv", ".ipynb_checkpoints", "vendor" },
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

require("nvim-surround").setup({
})

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = { exclude = {} },
})