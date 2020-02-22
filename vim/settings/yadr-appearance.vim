" Make it beautiful - colors and fonts

colorscheme dracula
" Enable true color
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

"hi CocHighlightText ctermbg=239
hi CocHighlightText guibg=#444444 ctermbg=239
let g:dracula_bold = 1
let g:dracula_italic = 1
let g:dracula_underline = 1
let g:dracula_undercurl = 1
let g:dracula_inverse = 1
let g:dracula_colorterm = 1
let g:airline_theme='dracula'

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
