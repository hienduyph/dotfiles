vim.diagnostic.config({
  virtual_text = false
})

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

require'nvim-web-devicons'.setup {
}

require('kommentary.config').use_extended_mappings()


vim.g.indent_blankline_filetype_exclude = {'dashboard'}
vim.g.indent_blankline_buftype_exclude = {'dashboard', 'terminal'}

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

local navic = require("nvim-navic")

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
      },
      {
        navic.get_location,
        cond = navic.is_available,
      },
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

require'nvim-tree'.setup {
  update_focused_file = {
    enable = true,
  },
  filters = {
    dotfiles = false,
    custom = {  '.git', 'node_modules', '.cache', '__pycache__', '.direnv', '.ipynb_checkpoints', 'vendor' },
  },
  actions = {
    open_file = {
      resize_window = true,
      window_picker = {
        enable = false,
      },
    },
  },
}

require("lightspeed").setup {
  ignore_case = false,
}

require('rust-tools').setup({})
