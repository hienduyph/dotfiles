" ln -s ~/dotfiles/vim/neovim/lua ~/.config/nvim/lua
lua require("lsp")

" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" -------------------- LSP ---------------------------------
"
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :lua vim.lsp.buf.formatting_sync()
command! -nargs=0 OR :lua lsp_organize_imports()
command! -nargs=0 LspStop :lua vim.lsp.stop_client(vim.lsp.get_active_clients())
command! -nargs=0 List :lua vim.lsp.diagnostic.set_loclist()

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

" formatter config
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.proto execute ':ClangFormat'
