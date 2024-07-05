vim.api.nvim_create_user_command("GD", "DiffviewOpen", { nargs = 0 })
vim.api.nvim_create_user_command("GDC", "DiffviewClose", { nargs = 0 })

local codefmt = function()
	-- vim.lsp.buf.format({ async = false, timeout_ms = 30000 })
	require("guard.format").do_fmt()
	-- require("conform").format({ timeout_ms = 30000, async = false })
end

vim.api.nvim_create_user_command("Format", codefmt, { nargs = 0 })

-- lsp import
-- refer https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
vim.api.nvim_create_user_command("OR", function()
	vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" }, diagnostics = {} }, apply = true })
end, { nargs = 0 })

vim.api.nvim_create_user_command("List", vim.diagnostic.setloclist, { nargs = 0 })

vim.api.nvim_create_user_command("FormatJSON", "%!jq .", { nargs = 0 })
vim.api.nvim_create_user_command("MinifyJSON", "%!jq -c .", { nargs = 0 })

vim.api.nvim_create_user_command("BufOnly", "%bd|e#|bd#", { nargs = 0 })

vim.api.nvim_create_user_command("Black", "!black %", { nargs = 0 })
vim.api.nvim_create_user_command("Lint", "lua require('lint').try_lint()", { nargs = 0 })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = {
		"*.go",
		"*.md",
		"*.lua",
		"*.rs",
		"*.css",
		"*.scss",
		"*.js",
		"*.jsx",
		"*.tsx",
		"*.html",
		"*.proto",
		"*.py",
		"*.scala",
		"*.sbt",
		"*.cs",
		-- "*.yaml",
		-- "*.yml",
	},
	callback = codefmt,
})
vim.cmd([[
  hi LspDiagnosticsVirtualTextError guifg=red gui=bold,italic,underline
  hi LspDiagnosticsVirtualTextWarning guifg=orange gui=bold,italic,underline
  hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,underline
  hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,underline
]])
