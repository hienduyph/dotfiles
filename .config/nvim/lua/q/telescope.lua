require('telescope').setup {
  defaults = {
    layout_config = {
      vertical = { width = 0.5 }
    },
    preview = {
      treesitter = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

vim.api.nvim_create_user_command('GitFiles ', require('telescope.builtin').git_files, { nargs = 0 })
