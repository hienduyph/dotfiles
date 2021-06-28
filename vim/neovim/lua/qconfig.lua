require('gitsigns').setup {
  watch_index = {
    interval = 1000
  },
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
  use_internal_diff = true,
}

-- use tree sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  autopairs = {enable = true},
  tree_docs = {enable = true},
  highlight = {
    enable = true
  },
}

