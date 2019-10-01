" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

set number                      "Line numbers are good
set relativenumber              "Use relative line number to navigate
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vimplug starts loading all 
" the plugins.
let mapleader=","

" =============== Vimplug Initialization ===============
" This loads all the plugins specified in ~/.vim/vimplug.vim
" Use Vimplug plugin to manage all other plugins
if filereadable(expand("~/.vim/vimplug.vim"))
  source ~/.vim/vimplug.vim
endif
au BufNewFile,BufRead *.plug set filetype=vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowritebackup

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation & Folds======================

"Default Set
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set fdm=syntax
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
"set cindent             "indent for c
"set cinkeys=0{,0},:,!^F,o,O,e	" See "cinkeys"; this stops "#" from indenting

autocmd FileType python set tabstop=4|
      \ set expandtab|
      \ set shiftwidth=4|
      \ set softtabstop=4|
      \ set foldmethod=indent   "fold based on indent

autocmd FileType javascript set tabstop=2|
      \ set expandtab|
      \ set shiftwidth=2|
      \ set softtabstop=2|
      \ set foldmethod=indent   "fold based on indent

" Auto indent pasted text
if has('vim')
    nnoremap p p=`]<C-o>
    nnoremap P P=`]<C-o>
endif

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points


" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1


" ================ Mouse ===========================
set mouse=n
set mousefocus
" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
" =============== MISC ===================
set laststatus=2                "Make airline show at start
" Some other configuration
set complete-=i
set nrformats-=octal
set ttimeout
set ttimeoutlen=50
set sidescrolloff=5
set display+=lastline
set autoread            "auto read changed file
set tabpagemax=50
"set sessionoptions-=options
set fileformat=unix	" No crazy CR/LF
set nojoinspaces
set showmatch
set textwidth=80	" Maximum line width
if !empty(&viminfo)
  set viminfo^=!
endif
set whichwrap=<,>,[,],h,l " Allows for left/right keys to wrap across lines
set formatoptions=tcroql "Set text and comment formatting 
set formatoptions+=j
syn sync fromstart " Increase the highlighting accuracy
" Encoding
scriptencoding utf-8
set fenc=utf-8
set termencoding=utf-8

set cmdheight=2

set updatetime=300

set shortmess+=c
set signcolumn=yes


" ================ Custom Settings ========================
so ~/.yadr/vim/settings.vim
