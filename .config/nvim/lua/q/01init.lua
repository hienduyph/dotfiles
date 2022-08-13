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
opt.encoding =  "UTF-8"
opt.tabstop =  4
opt.softtabstop = 4
opt.shiftwidth =  4
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
opt.listchars = {eol = "↵", trail = "~", tab = ">-", nbsp = "␣"}

-- fold setup
vim.opt_local.foldmethod = "indent"
-- opt.nofoldenable = true
opt.foldlevel = 99

vim.cmd([[
augroup Markdown
  au filetype markdown set formatoptions+=ro
  au filetype markdown set comments=b:*,b:-,b:+,b:1.,n:>
augroup END

" custom function
function! UseTabs()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set noexpandtab   " Always uses tabs instead of space characters (noet).
  set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction

function! UseSpaces()
  set tabstop=2     " Size of a hard tabstop (ts).
  set shiftwidth=2  " Size of an indentation (sw).
  set expandtab     " Always uses spaces instead of tab characters (et).
  set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  set autoindent    " Copy indent from current line when starting a new line.
  set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

function! SpaceFour()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set expandtab     " Always uses spaces instead of tab characters (et).
  set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  set autoindent    " Copy indent from current line when starting a new line.
  set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

" C and C++ indent
augroup cpp
  autocmd Filetype c,cpp setlocal tabstop=2
  autocmd Filetype c,cpp setlocal softtabstop=2
  autocmd Filetype c,cpp setlocal shiftwidth=2
augroup END

" Web stuff: js, ts, css, scss, html
augroup web
  autocmd BufReadPre,FileReadPre  *.css,*.js,*.ts,*.scss,*.html,*.json set tabstop=2
  autocmd BufReadPre,FileReadPre  *.css,*.js,*.ts,*.scss,*.html,*.json set softtabstop=2
  autocmd BufReadPre,BufRead,FileReadPre *.css,*.js,*.ts,*.scss,*.html,*.json set shiftwidth=2
  autocmd BufReadPre,FileReadPre  *.css,*.js,*.ts,*.scss,*.html,*.json set autoindent
augroup END

augroup python
  autocmd Filetype python set tabstop=4
  autocmd Filetype python set shiftwidth=4
  autocmd Filetype python set softtabstop=4
  autocmd Filetype python set shiftwidth=4
  autocmd Filetype python set expandtab
  autocmd Filetype python set formatoptions-=t
augroup END

augroup common
  autocmd Filetype sh,yaml,vim,typescript,javascript,json,html,css,scss,terraform,dockerfile,markdown,xml,sql,lua,zsh,bash call UseSpaces()
  autocmd BufNewFile,BufRead *.avsc set filetype=jsonc
  autocmd FileType json set filetype=jsonc
  autocmd BufNewFile,BufRead *.sol set filetype=solidity syntax=solidity
  autocmd BufNewFile,BufRead *.carbon set syntax=rust
  autocmd BufNewFile,BufRead Caddyfile set syntax=tf
augroup END

" Golang config
augroup GO
  autocmd Filetype go setlocal tabstop=4
  autocmd Filetype go setlocal shiftwidth=4
  autocmd FileType go set expandtab
augroup END

" make
augroup Make
  autocmd Filetype make setlocal tabstop=4
  autocmd Filetype make setlocal shiftwidth=4
augroup END

augroup direnv
  au!
  autocmd BufNewFile,BufRead *.envrc set filetype=bash
augroup END
]])
