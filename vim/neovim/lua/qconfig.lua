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

-- use tree sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
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

require'nvim-web-devicons'.setup {
}

-- require('telescope').setup {
--   defaults = {
--     layout_config = {
--       vertical = { width = 0.5 }
--     },
--   },
--   extensions = {
--     fzf = {
--       fuzzy = true,                    -- false will only do exact matching
--       override_generic_sorter = false, -- override the generic sorter
--       override_file_sorter = true,     -- override the file sorter
--       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
--                                        -- the default case_mode is "smart_case"
--     }
--   }
-- }
-- -- To get fzf loaded and working with telescope, you need to call
-- -- load_extension, somewhere after setup function:
-- require('telescope').load_extension('fzf')
--
require('kommentary.config').use_extended_mappings()

require("indent_blankline").setup {
  char = "|",
  buftype_exclude = {"terminal"},
  space_char_blankline=' ',
  use_treesitter=true,
  char_list={'|', '¦', '┆', '┊'},
}

require('lualine').setup({
  options = {
    theme = 'palenight',
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
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})

require("twilight").setup { }

require("bufferline").setup{
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
}
