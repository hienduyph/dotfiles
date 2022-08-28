local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- delete without copy
map("n", '<leader>d' , '"_d')
map("x", '<leader>d' , '"_d')
map("x", '<leader>p' , '"_dP')

-- resize pane
map("n", "<leader>+", "<Cmd>vertical resize +5<CR>")
map("n", "<leader>-", "<Cmd>vertical resize -5<CR>")

-- clear search results highlight
map("n", "<C-l>", "<Cmd>nohl <CR>")

-- buffers
map("n", "1gt", function() require("bufferline").go_to_buffer(1, true) end)
map("n", "2gt", function() require("bufferline").go_to_buffer(2, true) end)
map("n", "3gt", function() require("bufferline").go_to_buffer(3, true) end)
map("n", "4gt", function() require("bufferline").go_to_buffer(4, true) end)
map("n", "5gt", function() require("bufferline").go_to_buffer(5, true) end)
map("n", "6gt", function() require("bufferline").go_to_buffer(6, true) end)
map("n", "7gt", function() require("bufferline").go_to_buffer(7, true) end)
map("n", "8gt", function() require("bufferline").go_to_buffer(8, true) end)
map("n", "9gt", function() require("bufferline").go_to_buffer(9, true) end)
map("n", "gb", function() require("bufferline").cycle(-1) end)
map("n", "gt", function() require("bufferline").cycle(1) end)
map("n", "gB", function() require("bufferline").cycle(1) end)
map("n", "gT", function() require("bufferline").cycle(-1) end)

map("n", "<C-y>", require"nvim-tree".toggle)

-- telescope
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

-- lsp stuff
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('x', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
map('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', 'g]', vim.diagnostic.goto_next)
map('n', '<leader>f', vim.lsp.buf.formatting_sync)

vim.diagnostic.config({
  virtual_text = false
})
-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
