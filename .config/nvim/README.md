# NVIM

## Requires

- git: for packer to work
- `C` & `C++` compiler: for nvim-treesitter compiles grammar.
- node & npm: needed for some language-server to install.
- go: to install gopls & work with go project



## Formatter
- Python: black (`brew install black`)
- Lua:  https://github.com/JohnnyMorganz/StyLua (`brew install stylua`)
- Protobuf: https://github.com/bufbuild/buf `brew install bufbuild/buf/buf`
- Json: jq (`brew install jq`)
- SQL: https://github.com/sqlfluff/sqlfluff (`pip install sqlfluff`)


```lua
{
  "ibhagwan/fzf-lua",
  config = function()
    require 'fzf-lua'.setup {
      fzf_colors = {
        ["fg"] = { "fg", "Normal" },
        ["bg"] = { "bg", "Normal" },
        ["gutter"] = { "bg", "Normal" },
      },
      winopts = {
        preview = {
          delay = 60,
        },
      },
    }
    vim.keymap.set("n", "<C-f>", require('fzf-lua').files, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-g>", require('fzf-lua').live_grep, { noremap = true, silent = true })
  end
};

```
