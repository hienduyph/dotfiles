" Hide some extentions
"let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.git$', '\.so$', '.vscode', '.mypy_cache', '\.swp$', 'node_modules', 'vendor', '.cache$', '.task', '\.idea$', '.next$', "\.direnv$", "target"]
"let NERDTreeRespectWildIgnore=1
"let NERDTreeShowHidden=1
"
"let NERDTreeMapOpenInTab='\r'
"let NERDTreeMinimalUI=1
"let g:NERDTreeHijackNetrw=0

" fzf
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Airline themes
" let g:airline_theme='luna'
" let g:airline_theme = 'codedark'
" Automatically displays all buffers when there's only one tab open.
let g:airline_powerline_fonts = 1

" enable extensions
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'short_path'

" Show clocks
let g:airline_section_b = 'mrq %{strftime("%H:%M")}'

" markdown config
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = []



" grid indent
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_setColors = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_showFirstIndentLevel = 1


" commenter
let g:NERDSpaceDelims = 1

" Floaterm
let g:floaterm_autoclose = 0
command! -nargs=+ FN FloatermNew <args>

" rnvimr
let g:rnvimr_ranger_cmd = '~/.venv/neovim/bin/ranger --cmd="set draw_borders both"'
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1
let g:rnvimr_ex_enable = 1
" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1
