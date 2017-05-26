let s:bookmarkFile = expand('$HOME') . '/.NERDTreeBookmarks'

function! g:GetWorkingDir()
    if filereadable(bookmarkFile)
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
    return NERDTreeBookmarks
endfunction
