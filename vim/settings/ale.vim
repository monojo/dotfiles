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
""nn <silent> gs :ALESymbolSearch<cr>
"nn <silent> K :ALEHover<cr>
""let g:ale_linters = {'javascript': ['jshint']}
