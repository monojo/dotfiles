" If it's OSX aka Unix:Darwin, we have to map the functon key different
if has("unix")
    let s:uname = system("uname -s")
    "'\n' have to be used
    if s:uname == "Darwin\n"
        map <Esc>OP <F1>
        map <Esc>OQ <F2>
        map <Esc>OR <F3>
        map <Esc>OS <F4>
        map <Esc>[15~ <F5>
        map <Esc>[17~ <F6>
        map <Esc>[18~ <F7>
        map <Esc>[19~ <F8>
        map <Esc>[20~ <F9>
        map <Esc>[21~ <F10>
        map <Esc>[23~ <F11>
        map <Esc>[24~ <F12>
    else
        map <Esc>[15~ <F5>
        map <Esc>[17~ <F6>
        map <Esc>[18~ <F7>
        map <Esc>[19~ <F8>
        map <Esc>[20~ <F9>
        map <Esc>[21~ <F10>
        map <Esc>[23~ <F11>
        map <Esc>[24~ <F12>
    endif
endif

nnoremap <c-h> <c-w>h
if has('nvim')
    "osx use wrong terminfo
    nmap <BS> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
endif

"====== Tab ======
"use when too many window in a single tab
"open current buffer in a new tab
nnoremap tt :tab split<CR>
"close tab
nnoremap tc :tabc<CR>

"stop highlight from previous search
nnoremap <esc> :noh<CR><esc>
"use jk to exit insert
inoremap jk <esc>
"tag shortcut map
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"nnoremap <space> :w<CR>
"
" Add blank new line 
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>

if $TERM =~ 'screen'
    nnoremap <C-a> <nop>
    nnoremap <Leader><C-a> <C-a>
endif


"====== Tags ======
nnoremap <C-]> g<C-]>
nnoremap g[ :pop<cr>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Make Y behave like other capitals
nnoremap Y y$

"====== Quickfix =======
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

"====== Tabs ======
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

"====== Moving lines ======
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv

"" Quit
"inoremap <C-Q>     <esc>:q<cr>
"nnoremap <C-Q>     :q<cr>
"vnoremap <C-Q>     <esc>
"====== Markdown headings ======
"nnoremap <leader>1 m`yypVr=``
"nnoremap <leader>2 m`yypVr-``
"nnoremap <leader>3 m`^i### <esc>``4l
"nnoremap <leader>4 m`^i#### <esc>``5l
"nnoremap <leader>5 m`^i##### <esc>``6l


"nnoremap <silent> <C-k> :move-2<cr>
"nnoremap <silent> <C-j> :move+<cr>
"nnoremap <silent> <C-h> <<
"nnoremap <silent> <C-l> >>
"" Find TODO
"function! s:todo() abort
"let entries = []
"for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            "\ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
"let lines = split(system(cmd), '\n')
"if v:shell_error != 0 | continue | endif
"for line in lines
"let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
"call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
"endfor
"break
"endfor

"if !empty(entries)
"call setqflist(entries)
"copen
"endif
"endfunction
"command! Todo call s:todo()
"function! s:goog(pat, lucky)
"let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
"let q = substitute(q, '[[:punct:] ]',
            "\ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
"call system(printf('open "https://www.google.com/search?%sq=%s"',
            "\ a:lucky ? 'btnI&' : '', q))
"endfunction

"nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
"nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
"xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
"xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv

"function! RipgrepFzf(query, fullscreen)
"let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
"let initial_command = printf(command_fmt, shellescape(a:query))
"let reload_command = printf(command_fmt, '{q}')
"let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"if a:fullscreen
"let options = fzf#vim#with_preview(options)
"endif
"call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
"endfunction

"command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
