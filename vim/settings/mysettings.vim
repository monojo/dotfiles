let s:uname = system("uname -s")
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""vim-airline""""""""
"make it work
"enable extention support
"let g:airline_enable_syntastic = 1  "deprecated
let g:airline#extentions#syntastic#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#tagbar#enabled = 1
"short leave insert mode
"bufferline
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#bufferline#overwrite_variables = 1
"make buuferline on status line
let g:bufferline_echo = 0
  autocmd VimEnter *
    \ let &statusline='%{bufferline#refresh_status()}'
      \ .bufferline#get_status_string()
"use powerline style fonts
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
"let g:airline#extensions#tmuxline#enabled = 1
"let g:tmuxline_theme = 'zenburn'
"select tab(actually its buffer)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extentions#tabline#fnamemod = ':t'
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"tagbar support
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 's' "show signature(parms)

""""""""YCM""""""""
if s:uname == "Darwin\n"
	"change to local one
	let g:ycm_path_to_python_interpreter="/usr/local/bin/python" 
	let g:ycm_python_binary_path = '/usr/local/bin/python3'
	"disalbe syntax checker
	let g:ycm_show_diagnositcs_ui = 0
endif
"go to referce
"only work for javascript & python
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
	"solve the ycm Value Error problem
if has('nvim') 
	let g:ycm_global_ycm_extra_conf = '~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' 
else
	let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' 
endif

"let g:ycm_filetype_blacklist = {
"	\ 'python' : 1,
"	\ 'py' : 1
"	\}
""""""""Session""""""""
let g:session_autosave = 'no'
"let g:session_autotsave = 'yes'
let g:session_autoload = 'no'

""""""""Utltisnips""""""""
let g:UltiSnipsExpandTrigger = "<leader>u"
let g:UltiSnipsJumpForwardTrigger = "<leader>j"
let g:UltiSnipsJumpBackwardTrigger = "<leader>k"
"
""""""""Indent guide""""""""
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 5
hi IndentGuidesEven ctermbg=lightgrey

"""""""Tagbar""""""""
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_left = 1

"""""""CtrlP"""""""""
"dont know why tab also trigger this
"cause c-i is mapped to jump
nnoremap <leader>i :CtrlPBufTagAll<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
"search tag
nnoremap <leader>t :CtrlPTag<CR>
"search current folder file
nnoremap <leader>c : CtrlPCurWD<CR>

""""""""Promptline""""""""
let g:promptline_preset = {
	\'a' : [ promptline#slices#host() ],
	\'x' : [ promptline#slices#cwd() ],
    \'y' : [ promptline#slices#vcs_branch() ],
    \'warn' : [ promptline#slices#last_exit_code() ]}

""""""""NerdTree"""""""""""""
"au VimEnter * NERDTree 		"auto start nerd tree
map <F7> :NERDTreeToggle<CR>

""""""""Vim-action-ag""""""""""
nmap gw <Plug>AgActionWord

""""""Save marks""""""
set viminfo='100,f1

""""""""Quickhl""""""""""
"highlight multiple words
nmap <leader>m <Plug>(quickhl-manual-this)
xmap <leader>m <Plug>(quickhl-manual-this)
nmap <leader>M <Plug>(quickhl-manual-reset)
xmap <leader>M <Plug>(quickhl-manual-reset)

""""""Limelight""""""
nmap <leader>l <Plug>(Limelight)
xmap <leader>l <Plug>(Limelight)


""""""CCTree""""""
let g:CCTreeOrientation = "above"

""""""Memolist""""""
"memolist path
if s:uname == "Darwin\n"
	let g:memolist_path = "/Users/mono/dropbox/memo"
elseif s:uname == "Linux\n"
	let g:memolist_path = "/home/".$USER."/Documents/md"
endif
"markdown preview
if s:uname == "Darwin\n"
	let g:mkdp_path_to_chrome = "open -a Google\\ Chrome "
elseif s:uname == "Linux\n"
	let g:mkdp_path_to_chrome = "chromium-browser"
endif
"markdown simply make a word strong
nnoremap <silent> <plug>MStrong :<C-U>normal! yiwciw**<CR>:<C-U>normal! pa**<CR>
"nmap <leader>s <Plug>MStrong

""""""python-mode""""""""
"let g:pymode = 1
"let g:pymode_folding = 1
""auto complete
"let g:pymode_rope = 1
"let g:pymode_rope_complete_on_dot = 1
"""Documentation
"let g:pymode_doc = 1
"let g:pymode_doc_key = 'K'
"""Linting
"let g:pymode_lint = 1
"let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
"""Auto check on save
""let g:pymode_lint_on_write = 1
"let g:pymode_lint_on_fly = 1
"let g:pymode_lint_message = 1
""Support virtualenv
"let g:pymode_virtualenv = 1
"
"""syntax highlighting
"let g:pymode_syntax = 1
"let g:pymode_syntax_all =1
"let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"let g:pymode_syntax_space_errors = g:pymode_syntax_all
"let g:pymode_trim_whitespaces = 1
"let g:pymode_options_colorcolumn = 1
""let g:pymode_python = 'python3'
"let g:pymode_indent = 1
"let g:pymode_run = 1
"let g:pymode_run_bind = '<leader>r'
