local opt = vim.opt
local g = vim.g

vim.o.exrc = true


vim.diagnostic.config({
  virtual_text = false,
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
]])

-- enable filetype.lua
g.do_filetype_lua = 1
g.do_legacy_filetype = 0
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.number = true
opt.ruler = true
opt.encoding = "UTF-8"
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
opt.lazyredraw = true

-- show the matching part of the pair for [] {} and ()
opt.showmatch = true

-- This option forces Vim to source .vimrc file if it present in working directory,
-- thus providing a place to store project-specific configuration.
opt.exrc = false

opt.clipboard = "unnamedplus"

opt.laststatus = 2

opt.backspace = "indent,eol,start"
opt.background = "light"

opt.signcolumn = "yes"
opt.synmaxcol = 250
opt.cursorline = true
opt.termguicolors = true

-- fold setup
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.nofoldenable = true
opt.foldlevel = 99
-- https://github.com/nvim-telescope/telescope.nvim/issues/699#issuecomment-1159637962
-- vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx", })

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

local autocmd = vim.api.nvim_create_autocmd
local function use_tabs()
  vim.opt_local.tabstop = 4 -- Size of a hard tabstop (ts).
  vim.opt_local.shiftwidth = 4 -- Size of an indentation (sw).
  vim.opt_local.expandtab = false -- Always uses tabs instead of space characters (noet).
  vim.opt_local.autoindent = true -- Copy indent from current line when starting a new line (ai).
end

local function use_spaces(size)
  local s = 2
  if type(size) == "number" and size > 0 then
    s = size
  end
  vim.opt_local.tabstop = s -- Size of a hard tabstop (ts).
  vim.opt_local.shiftwidth = s -- Size of an indentation (sw).
  vim.opt_local.expandtab = true -- Always uses spaces instead of tab characters (et).
  vim.opt_local.softtabstop = 0 -- Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  vim.opt_local.autoindent = true -- Copy indent from current line when starting a new line.
  vim.opt_local.smarttab = true -- Inserts blanks on a <Tab> key (as per sw, ts and sts).
end

local function use_spaces_four()
  use_spaces(4)
end

-- do not auto add comment on new line

autocmd(
  { "BufNewFile", "BufRead", "FileReadPre", "FileType" },
  { pattern = { "*Makefile", "*.make" }, callback = use_tabs }
)
autocmd(
  { "BufNewFile", "BufRead", "FileReadPre", "FileType" },
  { pattern = ".envrc", command = [[ set filetype=bash ]] }
)
autocmd(
  { "BufNewFile", "BufRead", "FileReadPre", "FileType" },
  { pattern = "*.kdl", command = [[ set filetype=kdl ]] }
)

autocmd({ "BufNewFile", "BufRead", "FileReadPre", "FileType" }, { pattern = "*.go", callback = use_tabs })
autocmd(
  { "BufNewFile", "BufRead", "FileReadPre", "FileType" },
  { pattern = { "*.py", "*.rs", "*.kt" }, callback = use_spaces_four }
)
autocmd({ "BufReadPre", "BufRead", "FileReadPre", "FileType" }, {
  pattern = {
    "*.css",
    "*.js",
    "*.ts",
    "*.scss",
    "*.html",
    "*.json",
    "*.c",
    "*.cc",
    "*.cpp",
    "*.h",
    "*.sh",
    "*.bash",
    "*.dart",
    "*.lua",
  },
  callback = use_spaces,
})
autocmd(
  { "BufNewFile", "BufRead", "FileReadPre", "FileType" },
  { pattern = "*.md", command = [[set formatoptions+=ro comments=b:*,b:-,b:+,b:1.,n:>]] }
)

autocmd({ "BufRead", "BufNewFile", },
  { pattern = { "*/playbooks/*.yml", "*/playbooks/*.yaml" }, command = [[ set filetype=yaml.ansible ]] }
)
