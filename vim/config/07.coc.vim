let g:coc_global_extensions = [
  \ 'coc-pyright',
  \ 'coc-tsserver',
  \ 'coc-rust-analyzer',
  \ 'coc-go',
  \ 'coc-yaml',
  \ 'coc-clangd',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-vimlsp',
  \]

" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#improve-the-completion-experience
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> g] <Plug>(coc-diagnostic-next)
nmap <silent> g[ <Plug>(coc-diagnostic-prev)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Golang config
augroup GO
  autocmd FileType go let b:coc_root_patterns = ['.git', 'go.mod']
  autocmd FileType go nmap gtj :CocCommand go.tags.add json yaml<cr>
augroup END

augroup PYCOC
  autocmd FileType python let b:coc_root_patterns = ['.git', 'setup.py', '.envrc']
augroup END

" coc list
nnoremap <silent> <leader>a  :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <leader>b  :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <leader>c  :<C-u>CocFzfList commands<CR>
nnoremap <silent> <leader>e  :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <leader>l  :<C-u>CocFzfList location<CR>
nnoremap <silent> <leader>o  :<C-u>CocFzfList outline<CR>
nnoremap <silent> <leader>s  :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <leader>S  :<C-u>CocFzfList services<CR>
nnoremap <silent> <leader>p  :<C-u>CocFzfListResume<CR>
