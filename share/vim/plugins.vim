" require version 7.0 or later.
if v:version >= 700

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim-plugins/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim-plugins/'))

" Wrapper for NeoBundle command
function! s:plugin (label)
    call neobundle#parser#bundle(substitute(a:label, '\s"[^"]\+$', '', ''))
    let plugin_name = substitute(matchstr(a:label, '\/\([^'']\+\)', 0), '\.vim', '', "g")
    let plugin_path = 'plugins-config' . plugin_name . '.vim'
    exec 'runtime! ' . plugin_path
endfunction

command! -nargs=+ LoadPlugin call s:plugin(<q-args>)

LoadPlugin 'Shougo/neobundle.vim'
LoadPlugin 'Shougo/vimproc'
LoadPlugin 'Shougo/vimshell.vim'
LoadPlugin 'Shougo/neocomplcache'
LoadPlugin 'ujihisa/vimshell-ssh'
LoadPlugin 'scrooloose/nerdtree'
LoadPlugin 'kien/ctrlp.vim'
LoadPlugin 'nathanaelkane/vim-indent-guides'
" reStructuredText
LoadPlugin 'Rykka/riv.vim'
" python
LoadPlugin 'davidhalter/jedi-vim', { 'rev': '3934359'}

filetype on
endif
