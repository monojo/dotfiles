"let uname = system("uname -s")
"""""""""YCM""""""""
"if uname == "Darwin\n"
  ""change to local one
  "let g:ycm_path_to_python_interpreter="/usr/local/bin/python" 
  "let g:ycm_python_binary_path = '/usr/local/bin/python3'
  ""disalbe syntax checker
  "let g:ycm_show_diagnositcs_ui = 0
"endif
"go to referce
"only work for javascript & python
"nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
"nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>

"solve the ycm Value Error problem
"if has('nvim') 
  "let g:ycm_global_ycm_extra_conf = '~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' 
"else
  ""let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' 
"endif

"disalbe ycm
"let g:loaded_youcompleteme = 1

"let g:ycm_filetype_blacklist = {
"	\ 'python' : 1,
"	\ 'py' : 1
"	\}

" Use clangd
" Let clangd fully control code completion
"let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
"let g:ycm_clangd_binary_path = exepath("clangd")
