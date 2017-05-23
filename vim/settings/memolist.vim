""""""Memolist""""""
let uname = system("uname -s")
"memolist path
if uname == "Darwin\n"
  let g:memolist_path = "/Users/mono/dropbox/memo"
elseif uname == "Linux\n"
  let g:memolist_path = "/home/".$USER."/Documents/md"
endif
