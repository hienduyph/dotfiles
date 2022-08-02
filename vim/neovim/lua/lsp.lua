local M = {}
local nvim_lsp = require('lspconfig')

local opts = { noremap=true, silent=true }

-- set keymaps
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', opts)
vim.keymap.set('n', 'gD', '<Cmd>Lspsaga signature_help<CR>', opts)

vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)


-- hover docs
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
local action = require("lspsaga.action")
-- scroll down hover doc or scroll in definition preview
vim.keymap.set("n", "<C-n>", function() action.smart_scroll_with_saga(1) end, { silent = true })
-- scroll up hover doc
vim.keymap.set("n", "<C-p>", function() action.smart_scroll_with_saga(-1) end, { silent = true })

vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', 'g[', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', 'g]', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local navic = require("nvim-navic")


local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- show function signature with lsp
  navic.attach(client, bufnr)
end

function M.setup_ls(lsp)
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

function M.angularls()
  M.setup_ls('angularls')
end
function M.node()
  M.setup_ls('tsserver')
  M.setup_ls('eslint')
end

function M.deno()
  M.setup_ls('denols')
end

local servers = {'clangd', 'yamlls', 'solang', 'jsonls', 'html', 'cssls', 'texlab'}
for _, lsp in ipairs(servers) do
  M.setup_ls(lsp)
end

local servers_lsp = servers
table.insert(servers_lsp, "rust_analyzer")
table.insert(servers_lsp, "tsserver")
table.insert(servers_lsp, "eslint")
table.insert(servers_lsp, "gopls")
table.insert(servers_lsp, "pyright")

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers_lsp,
  automatic_installation = true,
})

-- Rust setups
nvim_lsp.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
        allFeatures = true,
        runBuildScripts = true
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
      },
      diagnostics = {
        disabled = {"missing-unsafe"},
      },
    },
  },
}


-- Pyright
local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return nvim_lsp.util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end
  return exepath('python3') or exepath('python') or 'python'
end

nvim_lsp.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end
})

function custom_market(config, root)
  local gomarker = nvim_lsp.util.path.join(root, '.go2')
  if nvim_lsp.util.path.exists(gomarker) then
    config.cmd = {"gopls2", "serve"}
  else
    config.cmd = {"gopls", "serve"}
  end
end

-- Golang setup
nvim_lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  -- on_new_config = custom_market,
  settings = {
    gopls = {
      analyses = {
        unusedparams = false,
      },
      buildFlags={"-tags=integration,wireinject,unit"},
      staticcheck = false,
    },
  }
}

-- omnisharp setups
local omnisharp_bin = "/opt/omnisharp/run"
require'lspconfig'.omnisharp.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) };
}

-- lsp import
-- refer https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
function lsp_organize_imports(timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})


local saga = require 'lspsaga'
saga.init_lsp_saga({
  symbol_in_winbar = {
    in_custom = false,
  },
  finder_action_keys = {
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
})

return M
