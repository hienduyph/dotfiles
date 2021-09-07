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
