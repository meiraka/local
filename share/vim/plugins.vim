" require version 7.0 or later.
if v:version >= 700

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim-plugins/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim-plugins/'))

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kien/ctrlp.vim'
" reStructuredText
NeoBundle 'Rykka/riv.vim'
" python
NeoBundle 'davidhalter/jedi-vim', { 'rev': '3934359'}
filetype on
endif
