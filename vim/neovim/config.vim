lua require("qconfig")
lua require("qdebug")

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

if g:telescope == 1
  lua require('qtelescope')
endif

