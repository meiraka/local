"""meiraka vim config."""

import os
import viimproved as vim

BUNDLE_DIR = '~/.vim-plugins'

if vim.functions.has('gui_running') == '1':
    vim.settings.background = 'light'
    vim.settings.guifont = "Migu 1M bold 12"
    vim.settings.guifontwide = "Migu 1M bold 12"
else:
    vim.settings.background = 'dark'

vim.settings.t_Co = 256
vim.settings.number = True
vim.settings.cursorline = True

vim.commands.syntax('on')
vim.settings.hlsearch = True
vim.settings.incsearch = True
vim.settings.backspace = 'start,eol,indent'
vim.settings.tabstop = 4
vim.settings.shiftwidth = 4
vim.settings.expandtab = True
# vim.settings.ambiwidth = 'single'

if vim.functions.has('vim_starting'):
    if vim.settings.compatible:
        vim.settings.compatible = False
    vim.settings.runtimepath = (vim.settings.runtimepath + ',' +
                                BUNDLE_DIR + '/neobundle.vim')
    vim.autoloads.neobundle.begin(os.path.expanduser(BUNDLE_DIR))
    vim.commands.NeoBundleFetch("'Shougo/neobundle.vim'")
    vim.commands.NeoBundle("'meiraka/vim-hysteric-colors'")
    vim.commands.NeoBundle("'Shougo/vimproc'")
    vim.commands.NeoBundle("'Shougo/vimshell.vim'")
    # vim.commands.NeoBundle("'Shougo/neocomplcache'")
    # vim.commands.NeoBundle("'Shougo/neocomplete.vim'")
    vim.commands.NeoBundle("'ujihisa/vimshell-ssh'")
    vim.commands.NeoBundle("'scrooloose/nerdtree'")
    # syntax checker.
    # :SyntasticInfo to show checkers
    vim.commands.NeoBundle("'scrooloose/syntastic'")
    vim.variables.syntastic_python_checkers = ['python', 'pylint',
                                               'flake8', 'pep257']
    vim.variables.syntastic_cpp_cpplint_args = ('"--verbose=3'
                                                'filter=-legal/copyright'
                                                '--extensions=hpp,cpp"')
    vim.variables.syntastic_cpp_check_header = 1
    vim.variables.syntastic_cpp_no_include_search = 1
    vim.variables.syntastic_cpp_auto_refresh_includes = 1
    # vim.commands.NeoBundle("'kien/ctrlp.vim'")
    vim.commands.NeoBundle("'nathanaelkane/vim-indent-guides'")
    vim.variables.indent_guides_enable_on_vim_startup = 1
    vim.variables.indent_guides_start_level = 2
    vim.variables.indent_guides_color_change_percent = 30
    vim.variables.indent_guides_guide_size = 1

    vim.commands.NeoBundle("'tpope/vim-fugitive'")
    vim.commands.NeoBundle("'davidhalter/jedi-vim'")
    vim.autocmd.bind('FileType python', '',
                     setattr, [vim.buffer.variables, 'did_ftplugin', '1'])
    setattr(vim.globals.variables, 'jedi#use_tabs_not_buffers', 0)
    vim.commands.NeoBundle("'nvie/vim-flake8'")
    # vim.commands.NeoBundle("'vim-jp/vimdoc-ja'")
    vim.commands.NeoBundle("'derekwyatt/vim-scala'")

    vim.autoloads.neobundle.end()
    vim.commands.filetype("plugin", "indent", "on")

vim.commands.colorscheme("tricolore")
vim.autocmd.bind('BufNewFile', '*', vim.commands.put, ["='hogehoge'"])
