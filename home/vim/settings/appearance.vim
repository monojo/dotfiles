" Make it beautiful - colors and fonts

" Enable true color
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif


" statusline
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

"colorscheme dracula
"let g:dracula_bold = 1
"let g:dracula_italic = 1
"let g:dracula_underline = 1
"let g:dracula_undercurl = 1
"let g:dracula_inverse = 1
"let g:dracula_colorterm = 1
"let g:airline_theme='dracula'

"hi CocHighlightText ctermbg=239
"hi CocHighlightText guibg=#444444 ctermbg=239
"====== LspCxxHl ======
" LspCxxHlSym... highlight groups
"preprocessor
"hi LspCxxHlSkippedRegion ctermfg=239 guifg=#4e4e4e
hi LspCxxHlSymStructField  gui=italic
"hi LspCxxHlSymClass guifg=#A4FFFF
"hi LspCxxHlSymClassMethod guifg=#d7afaf
hi LspCxxHlSymClassFiled  gui=italic
" ccls and cquery's extension
"hi LspCxxHlSymParameter guifg=#ffd787

"====== semshi python ======
if has("nvim")
"hi semshiLocal           ctermfg=209 guifg=#ff875f
hi semshiGlobal          ctermfg=214 guifg=#ffaf00
hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
"hi semshiParameter       ctermfg=75  guifg=#5fafff
hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
hi semshiFree            ctermfg=218 guifg=#ffafd7
hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
"hi semshiAttribute       ctermfg=49  guifg=#00ffaf
hi semshiSelf            ctermfg=249 guifg=#b2b2b2
hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
sign define semshiError text=E> texthl=semshiErrorSign
" Customized highlilght
hi semshiParameter guifg=#ffd787
hi semshiAttribute       ctermfg=49  guifg=#00ffaf gui=italic
endif

" Dracula color palette
"let g:dracula#palette.fg        = ['#F8F8F2', 253]

"let g:dracula#palette.bglighter = ['#424450', 238]
"let g:dracula#palette.bglight   = ['#343746', 237]
"let g:dracula#palette.bg        = ['#282A36', 236]
"let g:dracula#palette.bgdark    = ['#21222C', 235]
"let g:dracula#palette.bgdarker  = ['#191A21', 234]

"let g:dracula#palette.comment   = ['#6272A4',  61]
"let g:dracula#palette.selection = ['#44475A', 239]
"let g:dracula#palette.subtle    = ['#424450', 238]

"let g:dracula#palette.cyan      = ['#8BE9FD', 117]
"let g:dracula#palette.green     = ['#50FA7B',  84]
"let g:dracula#palette.orange    = ['#FFB86C', 215]
"let g:dracula#palette.pink      = ['#FF79C6', 212]
"let g:dracula#palette.purple    = ['#BD93F9', 141]
"let g:dracula#palette.red       = ['#FF5555', 203]
"let g:dracula#palette.yellow    = ['#F1FA8C', 228]

"
" ANSI
"
"let g:dracula#palette.color_0  = '#21222C'
"let g:dracula#palette.color_1  = '#FF5555'
"let g:dracula#palette.color_2  = '#50FA7B'
"let g:dracula#palette.color_3  = '#F1FA8C'
"let g:dracula#palette.color_4  = '#BD93F9'
"let g:dracula#palette.color_5  = '#FF79C6'
"let g:dracula#palette.color_6  = '#8BE9FD'
"let g:dracula#palette.color_7  = '#F8F8F2'
"let g:dracula#palette.color_8  = '#6272A4'
"let g:dracula#palette.color_9  = '#FF6E6E'
"let g:dracula#palette.color_10 = '#69FF94'
"let g:dracula#palette.color_11 = '#FFFFA5'
"let g:dracula#palette.color_12 = '#D6ACFF'
"let g:dracula#palette.color_13 = '#FF92DF'
"let g:dracula#palette.color_14 = '#A4FFFF'
"let g:dracula#palette.color_15 = '#FFFFFF'

if has('nvim')
  " https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
  let g:terminal_color_0 = '#4e4e4e'
  let g:terminal_color_1 = '#d68787'
  let g:terminal_color_2 = '#5f865f'
  let g:terminal_color_3 = '#d8af5f'
  let g:terminal_color_4 = '#85add4'
  let g:terminal_color_5 = '#d7afaf'
  let g:terminal_color_6 = '#87afaf'
  let g:terminal_color_7 = '#d0d0d0'
  let g:terminal_color_8 = '#626262'
  let g:terminal_color_9 = '#d75f87'
  let g:terminal_color_10 = '#87af87'
  let g:terminal_color_11 = '#ffd787'
  let g:terminal_color_12 = '#add4fb'
  let g:terminal_color_13 = '#ffafaf'
  let g:terminal_color_14 = '#87d7d7'
  let g:terminal_color_15 = '#e4e4e4'

  set fillchars=vert:\|,fold:-
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

"if has('gui_running')
  ""set guifont=Menlo:h14 columns=80 lines=40
  "set columns=80 lines=40
"endif

"======seoul256======
"set t_Co=256
" Use seoul256 color scheme
"let g:seoul256_background = 234
"set background=dark
"colorscheme seoul256
"hi CocHighlightText ctermbg=237
"hi Normal ctermbg=NONE cterm=NONE term=NONE

"colorscheme wal

"======Old dracula======
"hi SpecialKey ctermbg=none ctermfg=none
"let g:dracula_colorterm=0
"let g:dracula_italic = 0

"======Other colorscheme======
"colorscheme kolor
"colorscheme Monokain
"colorscheme zenburn
"hi Normal ctermbg=333333
"colorscheme Tender
"colorscheme apprentice
"colorscheme dracula
"colorscheme inkpot
"colorscheme jellybeans
"colorscheme badwolf
"colorscheme Tomorrow
"colorscheme vividchalk
"colorscheme gruvbox
"colorscheme spacegray
"colorscheme PaperColor

"hi CocHighlightText ctermbg=Green
"colorscheme space-vim-dark
  " Make VIM transparent
"hi Normal ctermbg=NONE

"set termguicolors
"let ayucolor="light"
"let ayucolor="mirage"
"let ayucolor="dark"
"colorscheme ayu

" TODO Somehow Fix the buggy float bg color
autocmd colorscheme github hi CocErrorFloat guibg=#166666
set background=light
colorscheme github
"if has("gui_running")
  ""tell the term has 256 colors
  "set t_Co=256

  "" Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  "" For some reason this doesn't work as a regular set command,
  "" (the numbers don't show up) so I made it a VimEnter event
  "autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  "set lines=60
  "set columns=190

  "if has("gui_gtk2")
    "set guifont=Inconsolata\ XL\ 12,Inconsolata\ 15,Monaco\ 12
  "else
    "set guifont=Inconsolata\ XL:h17,Inconsolata:h20,Monaco:h17
  "end
"else
  "let g:CSApprox_loaded = 1
"endif
