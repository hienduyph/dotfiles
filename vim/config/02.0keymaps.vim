" Press jj to escape insert mode
inoremap jj <Esc>  """ jj key is <Esc> setting

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

" toggle nerdtree
map <C-e> :NERDTreeToggle<CR>
" map <C-e> :CHADopen<CR>
" let g:chadtree_settings = {"keymap": {  "tertiary": ["<S-t>"] }}

" resize pane"
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

nnoremap <C-g> :Rg<Cr>
map <C-f> :Files<CR>
map <C-p> :Buffers<CR>

" commenter
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" clear search results highlight
nnoremap <silent> <C-l> :nohl <CR>

nmap <leader>a= :Tabularize /= <CR>
vmap <leader>a= :Tabularize /= <CR>
nmap <leader>a: :Tabularize /:\zs <CR>
vmap <leader>a: :Tabularize /:\zs <CR>
nmap <leader>at :Tabularize /\|<CR>
vmap <leader>at :Tabularize /\|<CR>

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
