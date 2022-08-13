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

nnoremap <C-f> <cmd>lua require('telescope.builtin').find_files({ hidden=true, file_ignore_patterns = { 'node_modules', '.git/.*', '.direnv', 'vendor' } })<cr>
nnoremap <C-g> <cmd>lua require('telescope.builtin').live_grep({ hidden=true, file_ignore_patterns = { 'node_modules', '.git/.*', '.direnv', 'vendor' } })<cr>
command! -bar -bang -nargs=* GitFiles :lua require('telescope.builtin').git_files()
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>t <cmd>lua require('telescope.builtin').file_browser({ cwd = require'telescope.utils'.buffer_dir(), hidden=true })<cr>

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
