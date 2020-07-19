" Use quick fix window for result
let g:rtagsUseLocationList = 0
"let g:rtagsRdmCmd = "/home/monojo/bin/rtags/bin/rdm"
let g:rtagsAutoLaunchRdm = 1
let g:rtagsUseDefaultMappings = 0

" Jump to definition
noremap <space>d :call rtags#JumpTo(g:SAME_WINDOW)<CR>
" Jump to declaration
noremap <space>D :call rtags#JumpTo(g:SAME_WINDOW, { '--declaration-only' : '' })<CR>
" Find references
noremap <space>rr :call rtags#FindRefs()<CR>
noremap <space>R :call rtags#FindRefsCallTree()<CR>
" Jump to current scope
noremap <space>rp :call rtags#JumpToParent()<CR>

noremap <space>ri :call rtags#SymbolInfo()<CR>
noremap <space>rS :call rtags#JumpTo(g:H_SPLIT)<CR>
noremap <space>rV :call rtags#JumpTo(g:V_SPLIT)<CR>
"noremap <Leader>rT :call rtags#JumpTo(g:NEW_TAB)<CR>

noremap <space>rn :call rtags#FindRefsByName(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <space>rs :call rtags#FindSymbols(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <space>rB :call rtags#ReindexFile()<CR>
noremap <space>rl :call rtags#ProjectList()<CR>
noremap <space>rw :call rtags#RenameSymbolUnderCursor()<CR>
noremap <space>rv :call rtags#FindVirtuals()<CR>
noremap <space>rb :call rtags#JumpBack()<CR>
noremap <space>rh :call rtags#ShowHierarchy()<CR>
noremap <space>rC :call rtags#FindSuperClasses()<CR>
noremap <space>rc :call rtags#FindSubClasses()<CR>
"noremap <Leader>rD :call rtags#Diagnostics()<CR>
