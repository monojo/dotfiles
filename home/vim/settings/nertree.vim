augroup nerd_loader
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
                \  if isdirectory(expand('<amatch>'))
                \|   call plug#load('nerdtree')
                \|   execute 'autocmd! nerd_loader'
                \| endif
augroup END
