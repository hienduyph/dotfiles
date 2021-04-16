" fzf
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Airline themes
" Automatically displays all buffers when there's only one tab open.
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1

" enable extensions
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'short_path'

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

" rnvimr
let g:ranger_open_new_tab = 1
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1
let g:rnvimr_ex_enable = 1
" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

let g:clang_format#code_style='google'

let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = "--fast"
