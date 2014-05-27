" require version 7.0 or later.
if v:version >= 700

runtime! prettyplugin.vim
LoadingPlugin ~/.vim-plugins/ plugins-config plugins.vim
    Load 'Shougo/neobundle.vim'
    Load 'Shougo/vimproc'
    Load 'Shougo/vimshell.vim'
    Load 'Shougo/neocomplcache'
    Load 'ujihisa/vimshell-ssh'
    Load 'scrooloose/nerdtree'
    Load 'kien/ctrlp.vim'
    Load 'nathanaelkane/vim-indent-guides'
    Load 'tpope/vim-fugitive'
    " reStructuredText
    Load 'Rykka/riv.vim'
    " python
    Load 'davidhalter/jedi-vim', { 'rev': '3934359'}
    Load 'nvie/vim-flake8'
    " Vim doc
    Load 'vim-jp/vimdoc-ja'
    " Scala
    Load 'derekwyatt/vim-scala'
EndLoadingPlugin


endif
