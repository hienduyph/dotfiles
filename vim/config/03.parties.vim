" fzf
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" markdown config
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = []

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


" Enable inspector keymap
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]


" Nvim tree
let g:nvim_tree_width = 50

" Pandoc conf
let g:pandoc#spell#enabled = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ["python", "rust", "go", "yaml", "bash"]
