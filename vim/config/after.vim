augroup Markdown
  au filetype markdown set formatoptions+=ro
  au filetype markdown set comments=b:*,b:-,b:+,b:1.,n:>
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
  au filetype markdown.pandoc syntax enable
  au filetype markdown syntax enable
augroup END
