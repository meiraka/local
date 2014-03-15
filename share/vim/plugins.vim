" require version 7.0 or later.
if v:version >= 700

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim-plugins/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim-plugins/'))

" get vim plugin config dir(dirty method).
function! s:get_plugin_dir ()
    return '~/.vim/plugins-config/'
endfunction

" Wrapper NeoBundle command to load plugins config files.
function! s:load_plugin (label)
    exec 'NeoBundle ' . a:label
    let plugin_name = substitute(matchstr(a:label, '\/\([^'']\+\)', 0)[1:], '\.vim', '', "g") "ugly
    let plugin_path = 'plugins-config/' . plugin_name . '.vim'
    exec 'runtime! ' . plugin_path
endfunction

" open plugin config file.
function! s:config_plugin (plugin_name)
    let plugin_name = substitute(a:plugin_name, '\.vim', '', "g")
    let plugin_path = s:get_plugin_dir() . plugin_name . '.vim'
    exec 'new ' . plugin_path
endfunction   
    

command! -nargs=+ LoadPlugin call s:load_plugin(<q-args>)
command! -nargs=+ ConfigPlugin call s:config_plugin(<q-args>)

LoadPlugin 'Shougo/neobundle.vim'
LoadPlugin 'Shougo/vimproc'
LoadPlugin 'Shougo/vimshell.vim'
LoadPlugin 'Shougo/neocomplcache'
LoadPlugin 'ujihisa/vimshell-ssh'
LoadPlugin 'scrooloose/nerdtree'
LoadPlugin 'kien/ctrlp.vim'
LoadPlugin 'nathanaelkane/vim-indent-guides'
LoadPlugin 'tpope/vim-fugitive'
" reStructuredText
LoadPlugin 'Rykka/riv.vim'
" python
LoadPlugin 'davidhalter/jedi-vim', { 'rev': '3934359'}

filetype on
endif
