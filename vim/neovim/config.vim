lua require("qconfig")
lua require("qdebug")

setlocal foldmethod=indent
" setlocal foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" disable auto fold by default
set nofoldenable
set foldlevel=99

if g:telescope == 1
  lua require('qtelescope')
endif

