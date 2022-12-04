# NVIM

## Requires

- git: for packer to work
- `C` & `C++` compiler: for nvim-treesitter compiles grammar.
- node & npm: needed for some language-server to install.
- go: to install gopls & work with go project

```lua
use 'jose-elias-alvarez/null-ls.nvim'

local null_ls = require("null-ls")
null_ls.setup({
  autostart = true,
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.buf,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.prettier,
  },
})
```
