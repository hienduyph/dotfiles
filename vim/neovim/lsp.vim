
" ln -s ~/dotfiles/vim/neovim/lua ~/.config/nvim/lua
lua require("lsp")

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :lua vim.lsp.buf.formatting_sync()
command! -nargs=0 OR :lua lsp_organize_imports()
command! -nargs=0 List :lua vim.lsp.diagnostic.set_loclist()

" formatter config
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()

augroup pylsp
  autocmd Filetype python command! -nargs=0 Format :Black
augroup END

augroup prettier
  autocmd Filetype javascript,typescript,typescriptreact,css,less,scss,json,graphql,markdown,vue,svelte,yaml,html command! -nargs=0 Format :PrettierAsync
augroup END

autocmd BufWritePre *.proto execute ':ClangFormat'

lua require('qcompletion')
