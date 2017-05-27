let s:bookmarkFile = expand('$HOME') . '/.NERDTreeBookmarks'

"Get working dir by read the bookmark file
function! s:GetWorkingDir()
    let workingpath = ' '
    if filereadable(s:bookmarkFile)
        let NERDTreeBookmarks = []
        let NERDTreeInvalidBookmarks = []
        let bookmarkStrings = readfile(s:bookmarkFile)
        let invalidBookmarksFound = 0
        for i in bookmarkStrings

            "ignore blank lines
            if i != ''

                let name = substitute(i, '^\(.\{-}\) .*$', '\1', '')
                let path = substitute(i, '^.\{-} \(.*\)$', '\1', '')
                let path = fnamemodify(path, ':p')
                call add(NERDTreeBookmarks, path)
            endif
        endfor
    else 
        echoerr 'not exist'
    endif
    for i in NERDTreeBookmarks
        if i != ''
            let workingpath = workingpath.i.' '
        endif
    endfor
    "echo workingpath
    "let cmd = ':CtrlSF '
    "let cmd = cmd.workingpath
    "echo cmd
    return workingpath
endfunction

func! s:SearchCwordCmd(type)
    let cmd = ":\<C-U>" . a:type
    let cmd .= " " . expand('<cword>')
    let cmd .= s:GetWorkingDir()
    return cmd
endf

"remap the CtrlSF command to use NerdTree Bookmark to indicate working directory
"so CtrlSF will search through working dir for word
nnoremap          <expr> <Plug>CtrlSFWorking    <SID>SearchCwordCmd('CtrlSF')
nmap <leader>w <Plug>CtrlSFWorking <CR>
"default
nmap <leader>f <Plug>CtrlSFCwordPath <CR>
vmap <leader>f <Plug>CtrlSFVwordPath <CR>
