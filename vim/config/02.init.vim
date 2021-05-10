if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:loaded_python_provider = 0
  let g:loaded_ruby_provider = 0
endif

set nocompatible

" Enable local vimrc
set exrc

" Basic configurations
syntax on
filetype plugin on
filetype indent plugin on
set number relativenumber
set signcolumn=yes
set synmaxcol=250
set nocursorline

" enbalbe limit 120 chars highlight
set colorcolumn=120

" Use gruvbox theme
if (has("termguicolors"))
  set termguicolors
endif

set t_Co=256
set cursorline

set background=dark

colorscheme aurora
" colorscheme gruvbox
" colorscheme onedark
" colorscheme xcodedark
" colorscheme codedark
" colorscheme onehalfdark
" colorscheme dracula
" colorscheme PaperColor

" Custom aurora theme
let s:accent_2 = '#1b1b24'
let s:aqua     = '#18ffe0'
execute 'highlight! MatchParen' . ' guifg=' . s:aqua
execute 'highlight! MatchParen' . ' guibg=' . s:accent_2


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
augroup END

" Golang config
augroup GO
  autocmd Filetype go setlocal tabstop=4
  autocmd Filetype go setlocal shiftwidth=4
  autocmd FileType go set list lcs=tab:\|\ 
  autocmd FileType go set expandtab
augroup END

" make
augroup Make
  autocmd Filetype make setlocal tabstop=4
  autocmd Filetype make setlocal shiftwidth=4
  autocmd FileType make set list lcs=tab:\|\ 
augroup END


augroup Markdown
  " hotfit for indent listing of vim-markdown plugin
  au filetype markdown set formatoptions+=ro
  au filetype markdown set comments=b:*,b:-,b:+,b:1.,n:>
augroup END


" Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

if has('nvim')
  "Setup venv for nvim
  let g:python_host_prog = "~/.venv/neovim/bin/python"
  let g:python3_host_prog = "~/.venv/neovim/bin/python"
  " editor config
  let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
  let g:EditorConfig_core_mode = 'external_command'
endif


" The length colum
highlight ColorColumn ctermbg=2

" Auto complete
set completeopt+=noinsert,menuone
set completeopt-=preview

let g:completion_enable_snippet = 'UltiSnips'
