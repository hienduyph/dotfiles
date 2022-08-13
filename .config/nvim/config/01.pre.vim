" setup ale
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 0
let g:ale_linters = {
  \'go': ['golangci-lint'],
  \'c': ['clangd'],
  \'cpp': ['clangd'],
\}
let g:ale_linters_explicit = 1
" only run in manual mode
let g:ale_lint_on_enter = 0

let g:better_whitespace_filetypes_blacklist=['dashboard']
