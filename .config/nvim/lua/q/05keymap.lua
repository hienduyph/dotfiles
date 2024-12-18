local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<leader>sv", "<cmd>source $MYVIMRC<CR>")

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
	require("bufferline").go_to(1, true)
end)
map("n", "2gt", function()
	require("bufferline").go_to(2, true)
end)
map("n", "3gt", function()
	require("bufferline").go_to(3, true)
end)
map("n", "4gt", function()
	require("bufferline").go_to(4, true)
end)
map("n", "5gt", function()
	require("bufferline").go_to(5, true)
end)
map("n", "6gt", function()
	require("bufferline").go_to(6, true)
end)
map("n", "7gt", function()
	require("bufferline").go_to(7, true)
end)
map("n", "8gt", function()
	require("bufferline").go_to(8, true)
end)
map("n", "9gt", function()
	require("bufferline").go_to(9, true)
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
map("n", "<leader>t", "<cmd>NvimTreeFocus<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>NnnExplorer<CR>")

-- lsp stuff
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("x", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")

-- quickfix
-- learn keymap from https://github.com/tpope/vim-unimpaired
map("n", "]q", "<cmd>cn<CR>")
map("n", "[q", "<cmd>cp<CR>")

-- nvim dap config
-- https://www.reddit.com/r/neovim/comments/silikv/debugging_in_neovim/
map("n", "<F4>", ":lua require('dapui').toggle()<CR>")
map("n", "<F5>", ":lua require('dap').toggle_breakpoint()<CR>")
map("n", "<F9>", ":lua require('dap').continue()<CR>")

map("n", "<F1>", ":lua require('dap').step_over()<CR>")
map("n", "<F2>", ":lua require('dap').step_into()<CR>")
map("n", "<F3>", ":lua require('dap').step_out()<CR>")

map("n", "<Leader>dsc", ":lua require('dap').continue()<CR>")
map("n", "<Leader>dsv", ":lua require('dap').step_over()<CR>")
map("n", "<Leader>dsi", ":lua require('dap').step_into()<CR>")
map("n", "<Leader>dso", ":lua require('dap').step_out()<CR>")

map("n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
map("n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>")

map("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>")
map("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>")

map("n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>")
map("n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>")

map("n", "<Leader>di", ":lua require('dapui').toggle()<CR>")
