local dap = require("dap")
require('dap-go').setup()
require("flutter-tools").setup{
  debugger = {
    enabled = true,
  },
}

require("dapui").setup{
  tray = {
    elements = { "repl" },
    size = 100,
    position = "right", -- Can be "left", "right", "top", "bottom"
  },
}

dap.adapters.python = {
  type = 'executable';
  command = '/opt/cli/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

-- Rust debugger setup
local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.6.7/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
require('rust-tools').setup({
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
  },
})

local M = {}
function M.reload_continue()
  package.loaded['dap_config'] = nil
  require('dap_config')
  dap.continue()
end

function M.stop()
  require("dap").disconnect()
  require("dap").close()
  require("dapui").close()
end

function M.start()
  require("dapui").open()
  require("dap").continue()
end

local opts = { noremap=false, silent=true }
vim.api.nvim_set_keymap('n', '<F6>', '<cmd>lua require"qdebug".start()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F3>', '<cmd>lua require"qdebug".stop()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', opts)

vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>B', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lp', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dr', '<cmd>lua require"dap".repl.toggle()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua require"dap".run_last()<CR>', opts)
vim.api.nvim_set_keymap('v', '<leader>ev', '<cmd>lua require("dapui").eval()<CR>', opts)

-- <Leader>eC to reload and then continue
vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>eC',
    '<cmd>lua require"qdebug".reload_continue()<CR>', opts)

vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua require("dapui").toggle()<CR>', opts)

return M
