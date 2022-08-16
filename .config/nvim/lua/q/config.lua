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
  ignore_install = {"norg"},
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
    -- workaround because python indent is bad!
    disable = {"python", "yaml", "solidity", "go"},
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


