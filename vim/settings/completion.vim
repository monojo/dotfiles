"let g:deoplete#enable_at_startup=1
"call deoplete#custom#source('LanguageClient',
            "\ 'min_pattern_length',
            "\ 2)
"set signcolumn=yes
"set completefunc=LanguageClient#complete

" Use Tab to select completion list
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent><expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
