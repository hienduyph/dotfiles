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


```lua
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local tele = require("telescope")
      tele.setup({
        defaults = {
          file_ignore_patterns = { "^.git/" },
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
        },
      })
      tele.load_extension("fzf")

      vim.keymap.set("n", "<C-f>", function()
        require("telescope.builtin").find_files({ hidden = true })
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-g>", function()
        require("telescope.builtin").live_grep({ hidden = true })
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-i>", function()
        require("telescope.builtin").buffers()
      end, { noremap = true, silent = true })
    end,
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
```
