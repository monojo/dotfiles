"======LanguageClient-neovim======
"let g:LanguageClient_loadSettings = 1
"let g:LanguageClient_diagnosticsEnable = 0
"let g:LanguageClient_settingsPath = expand('~/.vim/languageclient.json')
"let g:LanguageClient_selectionUI = 'quickfix'
"let g:LanguageClient_diagnosticsList = v:null
"let g:LanguageClient_hoverPreview = 'Never'
"let g:LanguageClient_serverCommands = {}

"let g:LanguageClient_serverCommands = {
            "\ 'c': ['ccls', '--log-file=/tmp/cc.log'],
            "\ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
            "\ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
            "\ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
            "\ }
"let g:LanguageClient_serverCommands = {
            "\ 'c': ['cquery', '--log-file=/tmp/cc.log'],
            "\ 'cpp': ['cquery', '--log-file=/tmp/cc.log'],
            "\ 'cuda': ['cquery', '--log-file=/tmp/cc.log'],
            "\ 'objc': ['cquery', '--log-file=/tmp/cc.log'],
            "\ }
"let g:LanguageClient_serverCommands = {
            "\ 'c': ['clangd', '--log-file=/tmp/cc.log'],
            "\ 'cpp': ['clangd', '--log-file=/tmp/cc.log'],
            "\ 'cuda': ['clangd', '--log-file=/tmp/cc.log'],
            "\ 'objc': ['clangd', '--log-file=/tmp/cc.log'],
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

"======VIM-LSP======
"if executable('clangd')
"au User lsp_setup call lsp#register_server({
            "\ 'name': 'clangd',
            "\ 'cmd': {server_info->['cquery', '-background-index']},
            "\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
            "\ 'initialization_options': { 'cacheDirectory': '/tmp/clangd/cache' },
            "\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            "\ })
"endif

"if executable('cquery')
    "au User lsp_setup call lsp#register_server({
                "\ 'name': 'cquery',
                "\ 'cmd': {server_info->['cquery']},
                "\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
                "\ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
                "\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
                "\ })
"endif
"set hidden
"nn <silent> <leader>d :LspDefinition<cr>
"nn <silent> <leader>r :LspReferences<cr>


"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"" Or map each action separately
"nn <f4> :call LanguageClient_textDocument_rename()<cr>
"nn <leader>ji :Denite documentSymbol<cr>
"nn <leader>jI :Denite workspaceSymbol<cr>
"
"nmap <silent> <leader>d <Plug>(coc-definition)
"nmap <silent> <leader>r <Plug>(coc-references)


"======Coc======
"" bases
nn <silent> xb :call CocLocations('ccls','$ccls/inheritance')<cr>
"" bases of up to 3 levels
nn <silent> xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
"" derived
nn <silent> xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
"" derived of up to 3 levels
nn <silent> xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

"" caller
nn <silent> xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

"" $ccls/member
"" member variables / variables in a namespace
nn <silent> xm :call CocLocations('ccls','$ccls/member')<cr>
"" member functions / functions in a namespace
nn <silent> xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
"" nested classes / types in a namespace
nn <silent> xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

nmap <silent> xt <Plug>(coc-type-definition)<cr>
nn <silent> xv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> xV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>

nn xx x
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>r <Plug>(coc-references)

"inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

au CursorHold * sil call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
            "\ pumvisible() ? "\<C-n>" :
            "\ <SID>check_back_space() ? "\<TAB>" :
            "\ coc#refresh()


"function! s:check_back_space() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent><expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <silent><expr><c-cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <silent><expr> <c-cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"<CR> will insert text. disable it.
" Use <c-y> to select

"Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <F5> :CocRestart<CR>
