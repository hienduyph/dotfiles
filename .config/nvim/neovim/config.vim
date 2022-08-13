setlocal foldmethod=indent
" setlocal foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" disable auto fold by default
set nofoldenable
set foldlevel=99

lua require("q.config")
lua require('q.telescope')
