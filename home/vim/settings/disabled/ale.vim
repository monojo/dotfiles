"call deoplete#custom#option('sources', {
            "\ '_': ['ale'],
            "\})
""let g:ale_completion_enabled = 1
"let g:ale_cpp_ccls_init_options = {
            "\ 'cache':{
            "\       'directory': '/tmp/ccls/cache'
            "\}
"\}
"nn <silent> <leader>d :ALEGoToDefinition<cr>
"nn <silent> <leader>r :ALEFindReferences<cr>
"nn <silent> gs :ALESymbolSearch<cr>
"nn <silent> K :ALEHover<cr>
" XOR with deoplete completions
let g:ale_enabled = 1
let g:ale_linters = {
            \    'javascript': ['jshint'],
            \    'c': ['cc', 'clangcheck', 'clangd'],
            \    'cpp': ['clangd'],
            \}
let g:ale_linters_ignore = {'cpp': ['ccls']}
let g:ale_completion_enabled = 1
"let g:ale_linters_explicit = 1
"let g:ale_disable_lsp = 1
let g:ale_cpp_clangd_executable = '/Users/xzhang/bin/clangd_15.0.6/bin/clangd'
"let g:ale_cpp_clangd_options = '--std=c++20'
"let g:ale_verbose = 1
