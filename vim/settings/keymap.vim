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
endif
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

"========== Tab
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
map <C-[> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <space> :w<CR>
