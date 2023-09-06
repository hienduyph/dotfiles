local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- delete without copy
map("n", "<leader>d", '"_d')
map("x", "<leader>d", '"_d')
map("x", "<leader>p", '"_dP')

-- resize pane
map("n", "<leader>+", "<Cmd>vertical resize +5<CR>")
map("n", "<leader>-", "<Cmd>vertical resize -5<CR>")

-- clear search results highlight
map("n", "<C-l>", "<Cmd>nohl <CR>")

-- buffers
map("n", "1gt", function()
  require("bufferline").go_to_buffer(1, true)
end)
map("n", "2gt", function()
  require("bufferline").go_to_buffer(2, true)
end)
map("n", "3gt", function()
  require("bufferline").go_to_buffer(3, true)
end)
map("n", "4gt", function()
  require("bufferline").go_to_buffer(4, true)
end)
map("n", "5gt", function()
  require("bufferline").go_to_buffer(5, true)
end)
map("n", "6gt", function()
  require("bufferline").go_to_buffer(6, true)
end)
map("n", "7gt", function()
  require("bufferline").go_to_buffer(7, true)
end)
map("n", "8gt", function()
  require("bufferline").go_to_buffer(8, true)
end)
map("n", "9gt", function()
  require("bufferline").go_to_buffer(9, true)
end)
map("n", "gb", function()
  require("bufferline").cycle(-1)
end)
map("n", "gt", function()
  require("bufferline").cycle(1)
end)
map("n", "gB", function()
  require("bufferline").cycle(1)
end)
map("n", "gT", function()
  require("bufferline").cycle(-1)
end)

-- fuzzy & tree stuff
map("n", "<C-y>", "<cmd>NvimTreeToggle<CR>")

-- lsp stuff
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("x", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<leader>f", function()
  -- vim.lsp.buf.format({ async = true })
  require('guard.format').do_fmt()
end)


-- Terminal stuff
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

map("n", "<leader>g", function()
  lazygit:toggle()
end)

function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
