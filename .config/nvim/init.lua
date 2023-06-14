require("q.01init")

if vim.g.vscode then
  vim.keymap.set("n", "<leader>f", "<Cmd>call VSCodeNotifyVisual('workbench.action.quickOpen', 1)<CR>", { noremap = true, silent = true })
else
  require("q.02plugin")
  require("q.04cmd")
  require("q.05keymap")
  require("q.completion")
end
