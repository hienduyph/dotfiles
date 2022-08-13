vim.api.nvim_create_user_command('GD', 'DiffviewOpen', { nargs = 0 })
vim.api.nvim_create_user_command('GDC', 'DiffviewClose', { nargs = 0 })

vim.api.nvim_create_user_command('GitFiles ', require('telescope.builtin').git_files, { nargs = 0 })
vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting_sync, { nargs = 0 })

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
vim.api.nvim_create_user_command('OR', function() lsp_organize_imports(5000) end, { nargs = 0 })

vim.api.nvim_create_user_command('List', vim.diagnostic.setloclist, { nargs = 0 })

vim.api.nvim_create_user_command("FormatJSON", "%!jq .", { nargs = 0 })
vim.api.nvim_create_user_command("MinifyJSON", "%!jq -c .", { nargs = 0 })

vim.api.nvim_create_user_command("BufOnly", '%bdelete!|edit #|normal `"', { nargs = 0 })
