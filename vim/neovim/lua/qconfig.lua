require('gitsigns').setup {
  use_internal_diff = false,
}

-- use tree sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  },
}

