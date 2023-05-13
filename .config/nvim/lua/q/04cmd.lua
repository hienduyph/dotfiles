vim.api.nvim_create_user_command("GD", "DiffviewOpen", { nargs = 0 })
vim.api.nvim_create_user_command("GDC", "DiffviewClose", { nargs = 0 })

vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({ async = false, timeout_ms = 30000 })
end, { nargs = 0 })

-- lsp import
-- refer https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
vim.api.nvim_create_user_command("OR", function()
  vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
end, { nargs = 0 })

vim.api.nvim_create_user_command("List", vim.diagnostic.setloclist, { nargs = 0 })

vim.api.nvim_create_user_command("FormatJSON", "%!jq .", { nargs = 0 })
vim.api.nvim_create_user_command("MinifyJSON", "%!jq -c .", { nargs = 0 })

vim.api.nvim_create_user_command("BufOnly", '%bd|e#|bd#', { nargs = 0 })

vim.api.nvim_create_user_command("Black", "!black %", { nargs = 0 })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {
    "*.go",
    "*.md",
    "*.lua",
    -- "*.py",
  },
  callback = function()
    vim.lsp.buf.format { async = true }
  end,
})
