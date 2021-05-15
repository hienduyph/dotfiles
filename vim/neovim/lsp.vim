set completeopt=menuone,noselect

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

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" enter to complete
function! Compe_select_confirm() abort
  if !exists('*complete_info')
    throw 'compe#_select_confirm requires complete_info function to work'
  endif
  let selected = complete_info()['selected']
  if selected != -1
     return compe#confirm()
  elseif pumvisible()
     call feedkeys("\<down>\<cr>")
     return compe#confirm()
  endif
  return ''
endfunction

inoremap <silent><expr> <cr> pumvisible() ? Compe_select_confirm() : '<cr>'
