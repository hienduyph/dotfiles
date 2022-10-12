vim.g.fzf = true
require("q.01init")

-- vscode neovim stuff
if vim.g.vscode then

else
  -- default nvim stuff
  require("q.02plugin")
  require("q.03config")
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
end
