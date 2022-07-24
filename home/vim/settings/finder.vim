" Vim Finder Provider: Fzf, CocList
" Here some functionalities are overlapped with FZF:
" Coc  vs   FZF
" ----------------
" files     Files
" gfiles    GFiles
" gstatus   GFiles?
" buffers   Buffers
" colors    Colors
" grep      Ag, Rg
" lines     BLines
" tags      Tags
" outline   BTags
" marks     Marks
" windows   Windows
" mru       History
" cmdhistory History:
" searchhistory History/
" snippet   Snippet
" commits   Commits
" bcommits  BCommits
" vimcommands Commands
" maps      Maps
" helptags  Helptags
" filetypes Filetypes
"
" === Fzf speical commands ===
" Lines: search all loaded buffers lines
" Locate: find a file path according to its name

" === coc speical commands(after install coc-list) ===
" ---donno when is Useful
" location: show location saved in g:coc_jump_locations
" locationlist: locationlist of current buffer
" quickfix: quickfix list
" actions: code actions of selected range
"
" ---Not that Useful
" output: show output of coc.nvim
" folders: current working folder
" links: links of current buffer(show include file list)
" services: show registered services of coc
" sources: show registered completion sources
"
" ---Relatively Useful
" yank:     yank history
" issues:   issues on github/gitlab
" sessions: session list
" words:    word matches of current buffer(search word in current buf)
" diagnostics: current workspace diagnostics
" branches: git branches
"
" ---Really Useful
" commands: registered commands of coc
" extensions: manage coc extensions
" marketplace:  coc extensions marketplace
" symbols: search symbols for current project
" On larget project, some functionalities could be really slow
" Like tags...

" ======fzf======
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" This part could be replaced by coc-list
nmap <leader><tab> <Plug>(fzf-maps-n)
"nmap <leader>f :Files<CR>
nmap <space><space> :Files<CR>
nmap <leader>F :GFiles<CR>
nmap <leader>s :Snippets<CR>
imap <leader>s  <c-o>:call fzf#vim#snippets(0)<cr>
"search buffers
nmap <leader>b :Buffers<CR>
"search tag
nmap <leader>t :BTags<CR>
nmap <leader>T :Tags<CR>
nmap <leader>m :Marks<CR>
nmap <leader>M :GFiles?<CR>
nmap <leader>H :History<CR>
nmap <leader>l :BLines<CR>
nmap <leader>cmd :History:<CR>
nmap <leader>gc :Commits<CR>
nmap <leader>gC :BCommits<CR>
imap <c-x><c-k> <Plug>(fzf-complete-word)
"FZF complete path
imap <c-x><c-f> <plug>(fzf-complete-path)
"search current word with Rg
nnoremap <silent> <leader>w :Rg <C-R><C-W><CR>

" ====== CocList ======
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Show CocList
nnoremap <silent> <space>l  :<C-u>CocList<cr>

" This part can be replaced by fzf
"nmap <leader><tab> :<C-u>CocList maps<cr>
"nmap <leader>f :<C-u>CocList files<CR>
"nmap <leader>F :CocList gfiles<CR>
""nmap <leader>s :CocList snippets<CR>
""imap <leader>s  <c-o>:call fzf#vim#snippets(0)<cr>
""search buffers
"nmap <leader>b :CocList buffers<CR>
"" Search workspace symbols
"nnoremap <silent> <leader>t  :<C-u>CocList -I symbols<cr>
""search tag
"nmap <leader>T :CocList tags<CR>
"nmap <leader>m :CocList marks<CR>
"nmap <leader>M :CocList gstatus<CR>
"nmap <leader>H :CocList mru<CR>
"nmap <leader>l :CocList lines<CR>
"nmap <leader>cmd :CocList cmdhistory<CR>
"nmap <leader>gc :CocList commits<CR>
"nmap <leader>GC :CocList bcommits<CR>
""search current word with Rg
"nnoremap <silent> <leader>w :CocList grep <C-R><C-W><CR>
