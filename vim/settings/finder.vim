"======fzf======
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nmap <leader><tab> <Plug>(fzf-maps-n)
nmap <leader>f :Files<CR>
nmap <leader>F :GFiles<CR>
nmap <leader>s :Snippets<CR>
imap <leader>s  <c-o>:call fzf#vim#snippets(0)<cr>
"search buffers
nmap <leader>b :Buffers<CR>
"search tag
nmap <leader>t :BTags<CR>
nmap <leader>T :Tags<CR>
nmap <leader>m :Marks<CR>
nmap <leader>M :GFiles?<CR>
nmap <leader>H :History<CR>
nmap <leader>l :BLines<CR>
nmap <leader>cmd :History:<CR>
nmap <leader>gc :Commits<CR>
nmap <leader>GC :BCommits<CR>
imap <c-x><c-k> <Plug>(fzf-complete-word)
"search current word with Rg
nnoremap <silent> <leader>w :Rg <C-R><C-W><CR>

" TODO: use rg search current word, with preview on the side
"nnoremap <silent> <leader>rp :call Rg_Preview()<CR>
"function! Rg_Preview()

    "function! s:files()
        "let l:cur_word = expand("<cword>")
        ""let s:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {} | rg '.l:cur_word. ' --context 3"'
        ""let s:fzf_files_options = '--preview "echo {} | sed "s/:.*//g" | rg '.l:cur_word. ' --context 3"'
        "let s:fzf_files_options = '--preview "echo {}'
        ""let s:fzf_files_options = '--preview "cat {}"'
        "let s:command = "rg -i -n --column --hidden --no-heading " . l:cur_word
        "let l:test = system(s:command)
        "let l:files = split(l:test, '\n')
        "return l:files
    "endfunction

    "function! s:edit_file(item)
        "let l:list = split(a:item, ':')
        "let l:file_path = l:list[0]
        "let l:line = l:list[1]
        "let l:col = l:list[2]
        "execute 'silent e' l:file_path
        "call cursor(l:line, l:col)
    "endfunction

    "call fzf#run({
                "\ 'source': <sid>files(),
                "\ 'sink':   function('s:edit_file'),
                "\ 'options': '-m ' . s:fzf_files_options,
                "\ 'left':    '40%' })
"endfunction
"======CtrlSF======
"Default
"nmap <leader>w <Plug>CtrlSFCwordPath <CR>
"vmap <leader>w <Plug>CtrlSFVwordPath <CR>
"let g:ctrlsf_ackprg='rg'
"press p for preview

"======Leaderf======
"nmap <leader><tab> <Plug>(fzf-maps-n)
"nmap <leader>f :Leaderf file<CR>
"search buffers
"nmap <leader>b :Leaderf buffer<CR>
"search tag
"nmap <leader>t :Leaderf tag<CR>
"nmap <leader>cd :Leaderf cmdHistory<CR>
"nmap <leader>mru :Leaderf mru<CR>
"nmap <leader>l :Leaderf line<CR>
"set cmdheight=2
