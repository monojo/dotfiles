"prepend ~/.vim to rtp, then append ~/.vim/after
set rtp^=~/.vim rtp+=~/.vim/after
"directory to find packages
let &pp = &rtp
source ~/.vimrc
