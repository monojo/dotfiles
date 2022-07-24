" ----------------------------------------------------------------------------
" tmux
" ----------------------------------------------------------------------------
function! s:tmux_send(content, dest) range
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  let tempfile = tempname()
  call writefile(split(a:content, "\n", 1), tempfile, 'b')
  call system(printf('tmux load-buffer -b vim-tmux %s \; paste-buffer -d -b vim-tmux -t %s',
        \ shellescape(tempfile), shellescape(dest)))
  call delete(tempfile)
endfunction

function! s:tmux_map(key, dest)
  execute printf('nnoremap <silent> %s "tyy:call <SID>tmux_send(@t, "%s")<cr>', a:key, a:dest)
  execute printf('xnoremap <silent> %s "ty:call <SID>tmux_send(@t, "%s")<cr>gv', a:key, a:dest)
endfunction

" Send vim's content to tmux pane
"call s:tmux_map('<leader>tt', '')
"call s:tmux_map('<leader>th', '.left')
"call s:tmux_map('<leader>tj', '.bottom')
"call s:tmux_map('<leader>tk', '.top')
"call s:tmux_map('<leader>tl', '.right')
"call s:tmux_map('<leader>ty', '.top-left')
"call s:tmux_map('<leader>to', '.top-right')
"call s:tmux_map('<leader>tn', '.bottom-left')
"call s:tmux_map('<leader>t.', '.bottom-right')

" ----------------------------------------------------------------------------
" TX: tmux execute
" ----------------------------------------------------------------------------
command! -nargs=1 TX
  \ call system('tmux split-window -d -l 16 '.<q-args>)
cnoremap !! TX<space>
" open a pane and git push
command! GP TX git push
