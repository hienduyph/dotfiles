local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<C-y>", require"nvim-tree".toggle)

map("n", "<C-f>", function()
  require('telescope.builtin').find_files({ hidden=true, file_ignore_patterns = { 'node_modules', '.git/.*', '.direnv', 'vendor' } })
end);

map("n", "<C-g>", function()
  require('telescope.builtin').live_grep({ hidden=true, file_ignore_patterns = { 'node_modules', '.git/.*', '.direnv', 'vendor' } })
end);

map("n", "<leader>t", function()
  require('telescope.builtin').file_browser({ cwd = require'telescope.utils'.buffer_dir(), hidden=true })
end);

map("n", "<leader>b", function()
  require('telescope.builtin').buffers()
end);

map("n", "<leader>fh", function()
  require('telescope.builtin').help_tags()
end);
