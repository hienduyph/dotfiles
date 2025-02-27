require("q.01init")

if vim.g.vscode then
	-- https://code.visualstudio.com/docs/getstarted/keybindings
	vim.api.nvim_create_user_command("Format", "call VSCodeNotify('editor.action.formatDocument')", { nargs = 0 })
	vim.api.nvim_create_user_command("OR", "call VSCodeNotify('editor.action.organizeImports')", { nargs = 0 })

	vim.keymap.set(
		"n",
		"<leader>f",
		"<Cmd>call VSCodeNotifyVisual('workbench.action.quickOpen', 1)<CR>",
		{ noremap = true, silent = true }
	)
	vim.keymap.set(
		"n",
		"za",
		"<Cmd>call VSCodeNotifyVisual('editor.toggleFold', 1)<CR>",
		{ noremap = true, silent = true }
	)
else
	require("q.02plugin")
	require("q.04cmd")
	require("q.05keymap")
	if os.getenv("DARK_MODE") == "on" then
		vim.cmd([[colorscheme tokyonight-moon]])
	else
		vim.cmd([[colorscheme Mini16]])
	end
end
