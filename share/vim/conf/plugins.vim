set nocompatible
filetype off


if has('vim_starting')
  set runtimepath+=~/.vim-plugins/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim-plugins/'))

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'ujihisa/vimshell-ssh'

filetype plugin indent on
filetype on
