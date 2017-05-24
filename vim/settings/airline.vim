""""""""vim-airline""""""""
"enable extention support
let g:airline#extentions#syntastic#enabled = 1
"let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#whitespace#symbol = '!'
"let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#tagbar#enabled = 1

"short leave insert mode
"bufferline
"let g:airline#extensions#bufferline#enabled = 0
"let g:airline#extensions#bufferline#overwrite_variables = 1
"make buferline on status line
"let g:bufferline_echo = 0
"autocmd VimEnter *
"\ let &statusline='%{bufferline#refresh_status()}'
"\ .bufferline#get_status_string()

"use powerline style fonts
"let g:airline_powerline_fonts = 1
"let g:airline_theme = 'molokai'
"let g:airline#extensions#tmuxline#enabled = 1
"let g:tmuxline_theme = 'zenburn'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1 "display buffers in a tab
let g:airline#extensions#tabline#show_tabs =1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extentions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

""tagbar support
"let g:airline#extensions#tagbar#enabled = 1
"let g:airline#extensions#tagbar#flags = 's' "show signature(parms)
