exec 'source' '~/dotfiles/vim/shared.vim'

for f in split(glob('~/dotfiles/vim/config/*.vim'), '\n')
  exe 'source' f
endfor

set cmdheight=1
