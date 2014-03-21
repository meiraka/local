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
    let plugin_name = matchstr(a:label, '\/\([^'']\+\)', 0)[1:] "ugly
    let plugin_config_path = 'plugins-config/' . substitute(plugin_name, '\.vim', '', "g") . '.vim'
    let s:atr = neobundle#get(plugin_name)
    let s:atr.config_path = plugin_config_path
    let s:atr.config_full_path = '~/.vim/' . plugin_config_path
    function! s:atr.hooks.on_source(bundle)
        echom 'loading:' . self.config_path
        exec 'runtime! ' . self.config_path
    endfunction
    unlet s:atr
endfunction

" open plugin config file.
function! s:config_plugin (plugin_name)
    let plugin_name = a:plugin_name
    let s:atr = neobundle#get(plugin_name)
    if has_key(s:atr, 'config_full_path')
        exec 'new ' . s:atr.config_full_path
    else
        echoerr 'Plugin config for "' . plugin_name . '" is not found.'
    endif
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
