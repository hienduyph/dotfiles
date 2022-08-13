lua require("q.lsp")

command! -nargs=0 Format :lua vim.lsp.buf.formatting_sync()
command! -nargs=0 OR :lua lsp_organize_imports(5000)
command! -nargs=0 List :lua vim.lsp.diagnostic.set_loclist()

" formatter config
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()

lua require('q.completion')
