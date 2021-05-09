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

" Float filemanager
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
map <silent> <C-e> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>

" resize pane"
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

nnoremap <C-g> :Rg<Cr>
map <C-f> :Files<CR>
map <C-b> :Buffers<CR>

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
