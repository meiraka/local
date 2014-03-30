" 
" prettyplugin.vim - neobundle with auto config loader.
"

" Global vars
let g:pretty_plugin_config = {}

" Setup plugin loader
function! g:pretty_plugin_load_init (plugins_path, config_path, pluginlist_path)
    set nocompatible
    filetype off
    let plugins_path = expand(a:plugins_path)
    if has('vim_starting')
        exec 'set runtimepath+=' . plugins_path . 'neobundle.vim/'
    endif
    call neobundle#rc(plugins_path)
    let config_path = a:config_path
    if config_path[-1] != '/'
        let config_path = config_path . '/'
    endif
        
    let g:pretty_plugin_config.dir = config_path
    let g:pretty_plugin_config.listpath = expand(a:pluginlist_path)
endfunction

" Load plugins.
" Wrapper NeoBundle command to load plugins config files.
function! g:pretty_plugin_load (label)
    exec 'NeoBundle ' . a:label
    let plugin_name = matchstr(a:label, '\/\([^'']\+\)', 0)[1:] "ugly
    let plugin_config_path = g:pretty_plugin_config.dir . substitute(plugin_name, '\.vim', '', "g") . '.vim'
    let s:atr = neobundle#get(plugin_name)
    let s:atr.config_path = plugin_config_path
    let s:atr.config_full_path = '~/.vim/' . plugin_config_path
    function! s:atr.hooks.on_source(bundle)
        exec 'runtime! ' . self.config_path
    endfunction
    unlet s:atr
endfunction

" Finalize plugin loader
function! g:pretty_plugin_load_finish ()
    filetype on
endfunction

" open plugin config file.
function! g:pretty_plugin_edit_config (plugin_name)
    let plugin_name = a:plugin_name
    let s:atr = neobundle#get(plugin_name)
    if has_key(s:atr, 'config_full_path')
        exec 'new ' . s:atr.config_full_path
    else
        echoerr 'Plugin config for "' . plugin_name . '" is not found.'
    endif
endfunction

" open pluginlist file.
function! g:pretty_plugin_edit_list ()
    exec 'new ' . '~/.vim/' . g:pretty_plugin_config.listpath
endfunction

function! g:pretty_plugin_load_init_with (plugins_path, config_path, pluginlist_path)
    call g:pretty_plugin_load_init(a:plugins_path, a:config_path, a:pluginlist_path)
    command! -nargs=+ Load call g:pretty_plugin_load(<q-args>)
endfunction

function! g:pretty_plugin_load_finish_with()
    call g:pretty_plugin_load_finish()
    delcommand Load
endfunction

command! -nargs=* LoadingPlugin call g:pretty_plugin_load_init_with(<f-args>)
command! EndLoadingPlugin  call g:pretty_plugin_load_finish_with()
command! -nargs=+ Config call g:pretty_plugin_edit_config(<q-args>)
command! PluginList call g:pretty_plugin_edit_list()
