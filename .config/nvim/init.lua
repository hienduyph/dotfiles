vim.g.fzf = true

require("q.plugin")
require("q.01init")
require("q.config")
require("q.cmd")
require("q.keymap")

if vim.g.fzf == False then
  require("q.telescope")
else
  require'fzf-lua'.setup {
    winopts = {
      preview = {
        delay = 60,
      },
    },
  }
end

require("q.lsp")
require("q.completion")
