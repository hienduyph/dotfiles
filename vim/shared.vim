" show line numbers
set number
set ruler
set encoding=UTF-8

" Set proper tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab "convert tab to spae"
set autoindent

" Case insensitive
set ignorecase
set smartcase

" Always show the status line
set laststatus=2

" show a visual line under the cursor's current line
set cursorline
set lazyredraw
set nowrap
" set hlsearch highlight search result

" show the matching part of the pair for [] {} and ()
set showmatch
" set guifont=DroidSansMono_Nerd_Font:h11

" This option forces Vim to source .vimrc file if it present in working directory,
" thus providing a place to store project-specific configuration.
set exrc
set secure

set clipboard+=unnamed,unnamedplus

" make delete works in macos
set backspace=indent,eol,start
