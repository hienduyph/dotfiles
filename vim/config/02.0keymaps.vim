" Press jj to escape insert mode
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>

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


nnoremap <C-y> :NvimTreeToggle<CR>

if g:telescope == 1
  " Telescope (Replace FZF)
  nnoremap <C-f> <cmd>lua require('telescope.builtin').find_files({ hidden=true, file_ignore_patterns = { 'node_modules', '.git/.*', '.direnv', 'vendor' } })<cr>
  nnoremap <C-g> <cmd>lua require('telescope.builtin').live_grep({ hidden=true, file_ignore_patterns = { 'node_modules', '.git/.*', '.direnv', 'vendor' } })<cr>
  command! -bar -bang -nargs=* GitFiles :lua require('telescope.builtin').git_files()
  nnoremap <leader>b <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  nnoremap <leader>t <cmd>lua require('telescope.builtin').file_browser({ cwd = require'telescope.utils'.buffer_dir(), hidden=true })<cr>
else
  " FZF
  nnoremap <C-g> :Rg<Cr>
  map <C-f> :Files<CR>
  map <leader>b :Buffers<CR>
  " CTRL-A CTRL-Q to select all and build quickfix list
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  " say good bye with tab for now, old value `tab split`
  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'drop',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
  " Float filemanager
  map <silent> <leader>t :RnvimrToggle<CR>
endif

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
nmap <silent> <leader>l :ALELint <CR>

" Buffer navigations"
nnoremap <silent>gb :BufferLineCycleNext<CR>
nnoremap <silent>gB :BufferLineCyclePrev<CR>
nnoremap <silent>gt :BufferLineCycleNext<CR>
nnoremap <silent>gT :BufferLineCyclePrev<CR>
nnoremap <silent>1gb <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent>2gb <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent>3gb <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent>4gb <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent>5gb <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent>6gb <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent>7gb <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent>8gb <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent>9gb <Cmd>BufferLineGoToBuffer 9<CR>

" override tab behavior
nnoremap <silent>1gt <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent>2gt <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent>3gt <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent>4gt <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent>5gt <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent>6gt <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent>7gt <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent>8gt <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent>9gt <Cmd>BufferLineGoToBuffer 9<CR>

" Format keymap
nmap <silent> <leader>f :Format <CR>

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>
