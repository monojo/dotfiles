let s:uname = system("uname -s")

""""""""Indent guide""""""""
"let g:indent_guides_enable_on_vim_startup = 0
"let g:indent_guides_guide_size = 1
"let g:indent_guides_color_change_percent = 5
"hi IndentGuidesEven ctermbg=lightgrey

""""""""Promptline""""""""
"let g:promptline_preset = {
	"\'a' : [ promptline#slices#host() ],
	"\'x' : [ promptline#slices#cwd() ],
    "\'y' : [ promptline#slices#vcs_branch() ],
    "\'warn' : [ promptline#slices#last_exit_code() ]}

""""""Save marks""""""
set viminfo='100,f1

" vim update time (for gitgutter)
set updatetime=100

""""""Limelight""""""
"hyperfocus writing in Vim
"nmap <leader>l <Plug>(Limelight)
"xmap <leader>l <Plug>(Limelight)


""""""CCTree""""""
"let g:CCTreeOrientation = "above"

"markdown preview
"if s:uname == "Darwin\n"
	"let g:mkdp_path_to_chrome = "open -a Google\\ Chrome "
"elseif s:uname == "Linux\n"
	"let g:mkdp_path_to_chrome = "chromium-browser"
"endif
""markdown simply make a word strong
"nnoremap <silent> <plug>MStrong :<C-U>normal! yiwciw**<CR>:<C-U>normal! pa**<CR>
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
