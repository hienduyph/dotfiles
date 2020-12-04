" Required for operations modifying multiple buffers like rename.
set hidden

" coc.nvim
set cmdheight=2
set updatetime=300
set signcolumn=yes

let g:coc_global_extensions = [
  \ 'coc-python',
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-rust-analyzer',
  \ 'coc-phpls',
  \ 'coc-go',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-flutter',
  \ 'coc-clangd',
  \]

" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#improve-the-completion-experience
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
