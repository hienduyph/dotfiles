" Required for operations modifying multiple buffers like rename.
set hidden

" coc.nvim
set cmdheight=2
set updatetime=300
set signcolumn=yes

let g:coc_global_extensions = [
  \ 'coc-pyright',
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
  \ 'coc-sql',
  \ 'coc-omnisharp',
  \ 'coc-sh',
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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Golang config
augroup GO
  autocmd FileType go let b:coc_root_patterns = ['go.mod', '.git']
  autocmd FileType python let b:coc_root_patterns = ['.git', 'setup.py', '.envrc']
  autocmd FileType go nmap gtj :CocCommand go.tags.add json yaml<cr>
augroup END
