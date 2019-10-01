" Helpful coc extensions
" Use :CocInstall to install all these extensions
" :CocInstall coc-yank coc-python coc-json coc-marketplace coc-highlight coc-list
" coc-git: gitgutter like sign

" coc-yank: provide yank history
"nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent> <space>y  :<C-u>CocList yank<cr>

" coc-python: python lsp and more

" coc-json: json lsp and more

" coc-marketplace: show all available coc extensions

" coc-highlight: highlight current cursor word and highlight colors in current
" buffer

" coc-snippets: coc snippet solution
imap <leader>u <Plug>(coc-snippets-expand)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-p>'
" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)

" coc-list: extra source  
