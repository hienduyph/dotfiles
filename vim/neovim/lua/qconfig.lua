require('gitsigns').setup()

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
