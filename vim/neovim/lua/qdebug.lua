local dap = require('dap')


dap.adapters.python = {
  type = 'executable';
  command = '/opt/cli/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

-- require("dapui").toggle()
local opts = { noremap=false, silent=true }
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', opts)

require("dapui").setup{}
