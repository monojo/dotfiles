"======Coc LSP======
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>r <Plug>(coc-references)
nmap <silent> <leader>i <Plug>(coc-implementation)

""======LanguageClient-neovim======
"let g:LanguageClient_loadSettings = 1
"let g:LanguageClient_diagnosticsEnable = 0
"let g:LanguageClient_settingsPath = expand('~/.vim/languageclient.json')
"let g:LanguageClient_selectionUI = 'quickfix'
"let g:LanguageClient_diagnosticsList = v:null
""let g:LanguageClient_hoverPreview = 'Never'

"let g:LanguageClient_serverCommands = {
            "\ 'c': ['ccls', '--log-file=/tmp/cc.log'],
            "\ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
            "\ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
            "\ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
            "\ }

"nn <silent> <leader>d :call LanguageClient#textDocument_definition()<cr>
"nn <silent> <leader>r :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"" bases
"nn <silent> xb :call LanguageClient#findLocations({'method':'$ccls/inheritance'})<cr>
"" bases of up to 3 levels
"nn <silent> xB :call LanguageClient#findLocations({'method':'$ccls/inheritance','levels':3})<cr>
"" derived
"nn <silent> xd :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true})<cr>
"" derived of up to 3 levels
"nn <silent> xD :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true,'levels':3})<cr>

"" caller
"nn <silent> xc :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
"" callee
"nn <silent> xC :call LanguageClient#findLocations({'method':'$ccls/call','callee':v:true})<cr>
"" $ccls/member
"" nested classes / types in a namespace
"nn <silent> xs :call LanguageClient#findLocations({'method':'$ccls/member','kind':2})<cr>
"" member functions / functions in a namespace
"nn <silent> xf :call LanguageClient#findLocations({'method':'$ccls/member','kind':3})<cr>
"" member variables / variables in a namespace
"nn <silent> xm :call LanguageClient#findLocations({'method':'$ccls/member'})<cr>
"nn xx x

"nnoremap <F5> :call LanguageClient_contextMenu()<CR>

"not working for vim
"augroup LanguageClient_config
  "au!
  "au BufEnter * let b:Plugin_LanguageClient_started = 0
  "au User LanguageClientStarted setl signcolumn=yes
  "au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
  "au User LanguageClientStopped setl signcolumn=auto
  "au User LanguageClientStopped let b:Plugin_LanguageClient_started = 0
  "au CursorMoved * if b:Plugin_LanguageClient_started | sil call LanguageClient#textDocument_documentHighlight() | endif
"augroup END

""======VIM-LSP======
""if executable('clangd')
""au User lsp_setup call lsp#register_server({
            ""\ 'name': 'clangd',
            ""\ 'cmd': {server_info->['cquery', '-background-index']},
            ""\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
            ""\ 'initialization_options': { 'cacheDirectory': '/tmp/clangd/cache' },
            ""\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            ""\ })
""endif

""if executable('cquery')
    ""au User lsp_setup call lsp#register_server({
                ""\ 'name': 'cquery',
                ""\ 'cmd': {server_info->['cquery']},
                ""\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
                ""\ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
                ""\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
                ""\ })
""endif
 "Register ccls C++ lanuage server.
"if executable('ccls')
   "au User lsp_setup call lsp#register_server({
      "\ 'name': 'ccls',
      "\ 'cmd': {server_info->['ccls']},
      "\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      "\ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
      "\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      "\ })
"endif
"set hidden
"nn <silent> <leader>d :LspDefinition<cr>
"nn <silent> <leader>r :LspReferences<cr>
"nnoremap <silent> K :call LspHover<CR>


"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
""Or map each action separately
"nn <f4> :call LanguageClient_textDocument_rename()<cr>
"nn <leader>ji :Denite documentSymbol<cr>
"nn <leader>jI :Denite workspaceSymbol<cr>
