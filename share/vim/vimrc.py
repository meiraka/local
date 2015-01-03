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
    neobundle = vim.autoloads.neobundle.functions
    NeoBundleFetch, NeoBundle, NeoBundleCheck = [
        getattr(vim.commands, i) for i in
        ['NeoBundleFetch', 'NeoBundle', 'NeoBundleCheck']]

    neobundle.begin(os.path.expanduser(BUNDLE_DIR))
    NeoBundleFetch("'Shougo/neobundle.vim'")
    NeoBundle("'meiraka/vim-hysteric-colors'")
    NeoBundle("'Shougo/vimproc'")
    NeoBundle("'Shougo/vimshell.vim'")
    # NeoBundle("'Shougo/neocomplcache'")
    # NeoBundle("'Shougo/neocomplete.vim'")
    NeoBundle("'ujihisa/vimshell-ssh'")
    NeoBundle("'scrooloose/nerdtree'")

    # syntax checker.
    # :SyntasticInfo to show checkers
    NeoBundle("'scrooloose/syntastic'")
    vim.variables.syntastic_python_checkers = ['python', 'pylint',
                                               'flake8', 'pep257']
    vim.variables.syntastic_cpp_cpplint_args = ('"--verbose=3'
                                                'filter=-legal/copyright'
                                                '--extensions=hpp,cpp"')
    vim.variables.syntastic_cpp_check_header = 1
    vim.variables.syntastic_cpp_no_include_search = 1
    vim.variables.syntastic_cpp_auto_refresh_includes = 1

    # NeoBundle("'kien/ctrlp.vim'")
    NeoBundle("'nathanaelkane/vim-indent-guides'")
    vim.variables.indent_guides_enable_on_vim_startup = 1
    vim.variables.indent_guides_start_level = 2
    vim.variables.indent_guides_color_change_percent = 30
    vim.variables.indent_guides_guide_size = 1

    NeoBundle("'tpope/vim-fugitive'")

    # Lang: Python
    NeoBundle("'davidhalter/jedi-vim'")
    vim.autocmd.bind('FileType python', '',
                     setattr, [vim.buffer.variables, 'did_ftplugin', '1'])
    vim.autoloads.jedi.variables.use_tabs_not_buffers = 0
    NeoBundle("'nvie/vim-flake8'")

    # Lang: Haskell
    NeoBundle("'kana/vim-filetype-haskell'")
    # NeoBundle("'raichoo/haskell-vim'")
    # vim.globals.variables.haskell_enable_quantification = 1
    # vim.globals.variables.haskell_enable_arrowsyntax = 1

    # Lang: Vim
    # NeoBundle("'vim-jp/vimdoc-ja'")

    # Lang: Scala
    NeoBundle("'derekwyatt/vim-scala'")

    neobundle.end()
    vim.commands.filetype("plugin", "indent", "on")
    NeoBundleCheck()

vim.commands.colorscheme("tricolore")


def reload():
    """Reload vimrc file."""
    vim.commands.source('~/.vimrc')
