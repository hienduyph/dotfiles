
" ln -s ~/dotfiles/vim/neovim/lua ~/.config/nvim/lua
lua require("lsp")

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :lua vim.lsp.buf.formatting_sync()
command! -nargs=0 OR :lua lsp_organize_imports()
command! -nargs=0 List :lua vim.lsp.diagnostic.set_loclist()
" formatter config
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.proto execute ':ClangFormat'

lua require('qcompletion')

