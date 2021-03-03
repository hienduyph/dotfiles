" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent execute \"!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\"
"   autocmd VimEnter * PlugInstall | source $MYVIMRC
" endif

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" misc plugins
Plug 'bronson/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Themes
"Plug 'joshdick/onedark.vim'
"Plug 'arzg/vim-colors-xcode'
"Plug 'tomasiser/vim-code-dark'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'dracula/vim'
" Plug 'NLKNguyen/papercolor-theme'
Plug 'rafalbromirski/vim-aurora'
" Plug 'altercation/vim-colors-solarized'

Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'scrooloose/nerdtree'

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'


Plug 'voldikss/vim-floaterm'

Plug 'kevinhwang91/rnvimr'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'neoclide/jsonc.vim'

" work with ipython
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" auto complete engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

call plug#end()
