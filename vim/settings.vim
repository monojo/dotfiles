let vimsettings = '~/.vim/settings'
let uname = system("uname -s")

" Load all the settings inside 'settings'
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  exe 'source' fpath
endfor
