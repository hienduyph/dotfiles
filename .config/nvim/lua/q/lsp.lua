local M = {}
local nvim_lsp = require('lspconfig')

local flags = {
  debounce_text_changes = 150,
}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
end

function M.setup_ls(lsp)
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flags,
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

local servers = { 'clangd', 'solang', 'jsonls', 'html', 'cssls', 'texlab', 'bashls' }
for _, lsp in ipairs(servers) do
  M.setup_ls(lsp)
end

-- Rust setups
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = flags,
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
        disabled = { "missing-unsafe" },
      },
    },
  },
}

nvim_lsp.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = flags,
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.0-standalone-strict/all.json"] = "/*.k8s.yaml",
      },
    },
  }
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
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
  flags = flags,
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end
})

-- Golang setup
nvim_lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = flags,
  settings = {
    gopls = {
      analyses = {
        unusedparams = false,
      },
      buildFlags = { "-tags=integration,wireinject,unit" },
      staticcheck = false,
    },
  }
}


local null_ls = require("null-ls")
null_ls.setup({
  autostart = true,
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.buf,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.prettier,
  },
})

-- lua with nvim
require 'lspconfig'.sumneko_lua.setup {
  flags = flags,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

return M