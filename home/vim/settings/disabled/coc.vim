augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction
"%7*\[%n]                                  "buffernr
"%1*\ %<%F\                                "File+path
"%2*\ %y\                                  "FileType
"%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
"%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
"%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
"%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
"%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
"%9*\ col:%03c\                            "Colnr
"%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

" Show current function name in airline
"let g:airline_section_c = "%7*\[%n]  %{get(b:,'coc_current_function','')}"

"au CursorHold * sil call CocActionAsync('highlight')
"au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
nmap <F5> :CocRestart<CR>
" Remap for rename current word in all related files
"nmap <leader>rn <Plug>(coc-rename)
" Need virtual text support
nmap <leader>e <Plug>(coc-codelens-action)
nmap <leader>S <Plug>(coc-action-workspaceSymbols)

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:show_documentation()
if (index(['vim', 'help'], &filetype) >= 0)
  execute 'h' expand('<cword>')
else
  call CocAction('doHover')
endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Disable preview
" https://github.com/neoclide/coc.nvim/issues/2919#issuecomment-785550808
let g:coc_enable_locationlist = 0
autocmd User CocLocationsChange CocList --normal location
