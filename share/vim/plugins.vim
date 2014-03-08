" require version 7.0 or later.
if v:version >= 700

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim-plugins/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim-plugins/'))

function! s:Plugin (label, ...)
    let qlabel = "'" . a:label . "'"
    for i in a:000
        let qlabel = qlabel . ", " . i
    endfor
    call neobundle#parser#bundle(substitute(qlabel, '\s"[^"]\+$', '', ''))
endfunction

call s:Plugin('Shougo/neobundle.vim')
call s:Plugin('Shougo/vimproc')
call s:Plugin('Shougo/vimshell.vim')
call s:Plugin('Shougo/neocomplcache')
call s:Plugin('ujihisa/vimshell-ssh')
call s:Plugin('scrooloose/nerdtree')
call s:Plugin('kien/ctrlp.vim')
call s:Plugin('nathanaelkane/vim-indent-guides')
" reStructuredText
call s:Plugin('Rykka/riv.vim')
" python
call s:Plugin('davidhalter/jedi-vim', "{ 'rev': '3934359'}")

filetype on
endif
