let g:EasyMotion_do_mapping = 0
" Leader + jump
"nmap <leader>j <Plug>(easymotion-overwin-f)
nmap F <Plug>(easymotion-overwin-f)
"nmap s <Plug>(easymotion-overwin-f2)
" Move to line
"map <Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
"map  <Leader>w <Plug>(easymotion-bd-w)
"nmap <Leader>w <Plug>(easymotion-overwin-w)
map  f <Plug>(easymotion-s)
"map  s <Plug>(easymotion-bd-w)
"nmap s <Plug>(easymotion-overwin-w)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
"EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

let g:EasyMotion_startofline = 1 " keep cursor column when JK motion
let g:EasyMotion_use_smartsign_us = 1 " smart case
" fuzzy search in easymotion
"function! s:config_easyfuzzymotion(...) abort
  "return extend(copy({
  "\   'converters': [incsearch#config#fuzzy#converter()],
  "\   'modules': [incsearch#config#easymotion#module()],
  "\   'keymap': {"\<CR>": '<Over>(easymotion)'},
  "\   'is_expr': 0,
  "\   'is_stay': 1
  "\ }), get(a:, 1, {}))
"endfunction
" space + /
"noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
"map <Leader>l <Plug>(easymotion-lineforward)
"map <Leader>h <Plug>(easymotion-linebackward)
