local opt = vim.opt
local g = vim.g

g.vim_version = vim.version().minor

if g.vim_version < 8 then
  g.did_load_filetypes = 0
  g.do_filetype_lua = 1
end
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.python3_host_prog = "~/.venv/neovim/bin/python"

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

-- Enable local vimrc
opt.exrc = true
opt.secure = true
opt.signcolumn = "yes"
opt.synmaxcol = 250
opt.cursorline = true
opt.termguicolors = true

-- highlight whitespace
opt.listchars = { eol = "↵", trail = "~", tab = ">-", nbsp = "␣" }

-- fold setup
vim.opt_local.foldmethod = "indent"
-- opt.nofoldenable = true
opt.foldlevel = 99


local autocmd = vim.api.nvim_create_autocmd

local function use_tabs()
  vim.opt_local.tabstop     = 4 -- Size of a hard tabstop (ts).
  vim.opt_local.shiftwidth  = 4 -- Size of an indentation (sw).
  vim.opt_local.noexpandtab = true -- Always uses tabs instead of space characters (noet).
  vim.opt_local.autoindent  = true -- Copy indent from current line when starting a new line (ai).
end

local function use_spaces(size)
  size                      = size or 2
  vim.opt_local.tabstop     = size -- Size of a hard tabstop (ts).
  vim.opt_local.shiftwidth  = size -- Size of an indentation (sw).
  vim.opt_local.expandtab   = true -- Always uses spaces instead of tab characters (et).
  vim.opt_local.softtabstop = 0 -- Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  vim.opt_local.autoindent  = true -- Copy indent from current line when starting a new line.
  vim.opt_local.smarttab    = true -- Inserts blanks on a <Tab> key (as per sw, ts and sts).
end

local function use_spaces_four()
  use_spaces(4)
end

autocmd("FileType", { pattern = "*Makefile", callback = use_tabs, });

autocmd({ "BufNewFile", "BufRead" }, { pattern = ".envrc", command = [[ set filetype=bash ]], })
autocmd("FileType", { pattern = "*.go", callback = use_tabs, })
autocmd("FileType", { pattern = "*.py", callback = use_spaces_four, })
autocmd({ "BufReadPre", "BufRead", "FileReadPre" },
  { pattern = { "*.css", "*.js", "*.ts", "*.scss", "*.html", "*.json", "*.c", "*.cc", "*.cpp", "*.h" }, callback = use_spaces,
})
-- do not auto add comment on new line
autocmd("FileType", { pattern = "*", command = [[ set formatoptions-=cro ]], })
autocmd("FileType", { pattern = "*.md", command = [[set formatoptions+=ro comments=b:*,b:-,b:+,b:1.,n:>]], })
