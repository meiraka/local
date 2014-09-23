let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_cpp_cpplint_args = "--verbose=3 filter=-legal/copyright --extensions=hpp,cpp"
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_cpp_auto_refresh_includes = 1
