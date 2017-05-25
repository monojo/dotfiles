
"""""""CtrlP"""""""""
"dont know why tab also trigger this
"cause c-i is mapped to jump
nnoremap <leader>i :CtrlPBufTagAll<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
"search tag
nnoremap <leader>t :CtrlPTag<CR>
"search current folder file
nnoremap <leader>c : CtrlPCurWD<CR>
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
let g:ctrlp_user_caching = 0
let g:ctrlp_max_files = 200000
