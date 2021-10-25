require('gitsigns').setup()

local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},-- it will not add a pair on that treesitter node
    javascript = {'template_string'},
    java = false,-- don't check treesitter on java
  }
})

local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"}
  },
  filetype = "gotmpl",
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}

-- use tree sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
    -- workaround because python indent is bad!
    disable = {"python", "yaml", },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-web-devicons'.setup {
}

require('kommentary.config').use_extended_mappings()

require("indent_blankline").setup {
  char = "|",
  buftype_exclude = {"terminal"},
  space_char_blankline=' ',
  use_treesitter=true,
  char_list={'|', '¦', '┆', '┊'},
}

require("bufferline").setup{
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
}

require('lualine').setup({
  options = {
    theme = 'gruvbox',
    always_show_bufferline=true,
  },
  extensions = {'quickfix', 'nvim-tree', 'fzf'},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      {
        'filename',
        file_status=true,
        path=1,
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress', 'diff'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
  },
})

require("twilight").setup { }


-- tree
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', '__pycache__', '.direnv', '.ipynb_checkpoints', 'vendor'}
vim.g.nvim_tree_disable_window_picker = 1
require'nvim-tree'.setup {
  update_focused_file = {
    enable = true,
  },
}
