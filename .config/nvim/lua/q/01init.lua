local opt = vim.opt
local g = vim.g

 -- enable filetype.lua
g.do_filetype_lua = 1
g.do_legacy_filetype = 0

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
opt.exrc = true
opt.secure = true

opt.clipboard = "unnamedplus"

opt.laststatus = 2

opt.backspace = "indent,eol,start"
opt.background = "light"

opt.signcolumn = "yes"
opt.synmaxcol = 250
opt.cursorline = true
opt.termguicolors = true

-- fold setup
vim.opt_local.foldmethod = "indent"
-- opt.nofoldenable = true
opt.foldlevel = 99
