" Wrapper NeoBundle command to load plugins config files.
function! g:pretty_plugin_load (label)
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
function! g:pretty_plugin_config (plugin_name)
    let plugin_name = a:plugin_name
    let s:atr = neobundle#get(plugin_name)
    if has_key(s:atr, 'config_full_path')
        exec 'new ' . s:atr.config_full_path
    else
        echoerr 'Plugin config for "' . plugin_name . '" is not found.'
    endif
endfunction

function! g:pretty_plugin (plugins_path)
    set nocompatible
    filetype off
    let plugins_path = expand(a:plugins_path)
    if has('vim_starting')
        exec 'set runtimepath+=' . plugins_path . 'neobundle.vim/'
    endif
    call neobundle#rc(plugins_path)
endfunction

function! g:pretty_plugin_end ()
    filetype on
endfunction

command! -nargs=+ LoadingPlugin call g:pretty_plugin(<q-args>)
command! EndLoadingPlugin  call g:pretty_plugin_end()
command! -nargs=+ Load call g:pretty_plugin_load(<q-args>)
command! -nargs=+ Config call g:pretty_plugin_config(<q-args>)


