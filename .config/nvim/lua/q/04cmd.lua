vim.api.nvim_create_user_command("GD", "DiffviewOpen", { nargs = 0 })
vim.api.nvim_create_user_command("GDC", "DiffviewClose", { nargs = 0 })

vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({ async = false, timeout_ms = 30000 })
end, { nargs = 0 })

-- lsp import
-- refer https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
local function lsp_organize_imports(timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  for _, res in ipairs(result or {}) do
    for _, r in ipairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end
vim.api.nvim_create_user_command("OR", function()
  lsp_organize_imports(5000)
end, { nargs = 0 })

vim.api.nvim_create_user_command("List", vim.diagnostic.setloclist, { nargs = 0 })

vim.api.nvim_create_user_command("FormatJSON", "%!jq .", { nargs = 0 })
vim.api.nvim_create_user_command("MinifyJSON", "%!jq -c .", { nargs = 0 })

vim.api.nvim_create_user_command("BufOnly", '%bdelete!|edit #|normal `"', { nargs = 0 })
vim.api.nvim_create_user_command("Black", "!black %", { nargs = 0 })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {
    "*.go",
    "*.md",
    "*.lua",
    "*.py",
  },
  callback = function ()
    vim.lsp.buf.format { async = true }
  end,
})
