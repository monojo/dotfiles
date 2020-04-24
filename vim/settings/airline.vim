""""""""vim-airline""""""""
"enable extention support
"let g:airline#extentions#syntastic#enabled = 1
"let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#whitespace#symbol = '!'
"let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]

" enable Tabline
let g:airline#extensions#tabline#formatter = 'default'
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
"" Warning: this could high affect the performance when open large files
"" Time to generate tags
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#coc#enabled = 1
