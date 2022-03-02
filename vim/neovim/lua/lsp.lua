local M = {}
local nvim_lsp = require('lspconfig')

local opts = { noremap=true, silent=true }

-- set keymaps
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('x', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
vim.api.nvim_set_keymap('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


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

function M.nodels()
  M.setup_ls('tsserver')
end

local servers = {'clangd', 'yamlls', 'solang'}
for _, lsp in ipairs(servers) do
  M.setup_ls(lsp)
end

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

-- Golang setup
nvim_lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  on_new_config = function(config, root)
    local gomarker = nvim_lsp.util.path.join(root, '.go2')
    if nvim_lsp.util.path.exists(gomarker) then
      config.cmd = {"gopls2", "serve"}
    else
      config.cmd = {"gopls", "serve"}
    end
  end,
  filetypes = { "go", "gomod" },
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
  local context = { only = { "source.organizeImports" } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

return M
