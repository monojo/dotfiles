" ========================================
" Vim plugin configuration
" ========================================
"
filetype off

set rtp+=~/.vim/            "path to search runtime files
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

"
ru myplug.plug

call plug#end()
