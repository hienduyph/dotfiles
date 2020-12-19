if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:loaded_python_provider = 0
  let g:loaded_ruby_provider = 0
endif

" Basic configurations
syntax on
filetype plugin on
filetype indent plugin on
set number relativenumber


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

" Some group config
" Python pep 8
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set formatoptions-=t

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

augroup common
  autocmd Filetype sh,yaml,vim,typescript,javascript,json,html,css,scss,terraform,dockerfile,markdown,xml,sql call UseSpaces()
  autocmd Filetype python setlocal tabstop=4
  autocmd Filetype python setlocal shiftwidth=4
  autocmd FileType python let b:coc_root_patterns = ['.git', '.env', '.python_root', '.envrc', 'setup.py']
  autocmd BufNewFile,BufRead *.avsc set filetype=jsonc
  autocmd FileType json set filetype=jsonc
augroup END

" Golang config
augroup GO
  autocmd Filetype go setlocal tabstop=4
  autocmd Filetype go setlocal shiftwidth=4
  autocmd FileType go set list lcs=tab:\|\ 
augroup END

" make
augroup Make
  autocmd Filetype make setlocal tabstop=4
  autocmd Filetype make setlocal shiftwidth=4
  autocmd FileType make set list lcs=tab:\|\ 
augroup END

augroup php
  autocmd FileType php setlocal omnifunc=phpactor#Complete
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

" Use gruvbox theme
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
try
  " colorscheme onedark
  " colorscheme xcodedark
  " colorscheme codedark
  colorscheme aurora
catch
endtry

" Custom aurora theme
let s:accent_2 = '#1b1b24'
let s:aqua     = '#18ffe0'
execute 'highlight! MatchParen' . ' guifg=' . s:aqua
execute 'highlight! MatchParen' . ' guibg=' . s:accent_2

" The length colum
highlight ColorColumn ctermbg=2

" Auto complete
set completeopt+=noinsert,menuone
set completeopt-=preview

" Nerdtree config
" show as tree like
let g:netrw_liststyle = 3
let g:netrw_banner = 0
" open new file in vertical split
let g:netrw_browse_split = 4
" 25% of width
let g:netrw_winsize = 25
let g:netrw_altv = 1
