" Press jj to escape insert mode
inoremap jj <Esc>  """ jj key is <Esc> setting

" reload nvimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" save the current buffer
nnoremap <leader>w :w<cr>
" save and close all
nnoremap <leader>wa :wqa<cr>
nnoremap <leader>q :q!<cr>
nnoremap <leader>qa :qa!<cr>

" move lines around
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

" delete without copy
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" resize pane"
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>


if has('nvim-0.5')
  " Telescope (Replace FZF)
  nnoremap <C-f> <cmd>lua require('telescope.builtin').find_files({ hidden=true, file_ignore_patterns = { 'node_modules', '.git/.*' } })<cr>
  nnoremap <C-g> <cmd>lua require('telescope.builtin').live_grep({ hidden=true, file_ignore_patterns = { 'node_modules', '.git/.*' } })<cr>
  nnoremap <C-b> <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  map <silent> <C-e> <cmd>lua require('telescope.builtin').file_browser({ cwd = require'telescope.utils'.buffer_dir(), hidden=true })<cr>
  nnoremap <C-y> :NvimTreeToggle<CR>
else
  " FZF
  nnoremap <C-g> :Rg<Cr>
  map <C-f> :Files<CR>
  map <C-b> :Buffers<CR>
  " CTRL-A CTRL-Q to select all and build quickfix list
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
  " Float filemanager
  map <silent> <C-e> :RnvimrToggle<CR>
endif

" commenter
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" clear search results highlight
nnoremap <silent> <C-l> :nohl <CR>

nmap <leader>a= :Tabularize /= <CR>
vmap <leader>a= :Tabularize /= <CR>
nmap <leader>a: :Tabularize /:\zs <CR>
vmap <leader>a: :Tabularize /:\zs <CR>
nmap <leader>at :Tabularize /\|<CR>
vmap <leader>at :Tabularize /\|<CR>


" Format json
" com! FormatJSON %!python -m json.tool
com! FormatJSON %!jq '.'
com! MinifyJSON %!jq -c .


" Float windows
command! -bar -bang -nargs=* TERM FloatermNew <args>
command! -bar -bang -nargs=* LG FloatermNew --autoclose=1 lazygit
command! -bar -bang -nargs=* GC FloatermNew! git commit
command! -bar -bang -nargs=* GP FloatermNew! ggp
command! -bar -bang -nargs=* GD FloatermNew! git diff

if has('win32')
  " do nothing
elseif has('mac')
  let g:floaterm_keymap_new  = "<D-o>"
  let g:floaterm_keymap_toggle  = "<D-g>"
elseif has('unix')
  let g:floaterm_keymap_new  = "<M-o>"
  let g:floaterm_keymap_toggle  = "<M-g>"
endif

" delete all other buffer but this one
command! BufOnly execute '%bdelete!|edit #|normal `"'

" navigate ale fix
nmap <silent> <leader>g[ <Plug>(ale_next_wrap)
nmap <silent> <leader>g] <Plug>(ale_previous_wrap)
