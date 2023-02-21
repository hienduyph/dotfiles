require("q.01init")

if vim.g.vscode then
else
	require("q.02plugin")
	require("q.04cmd")
	require("q.05keymap")
	require("q.completion")
end
