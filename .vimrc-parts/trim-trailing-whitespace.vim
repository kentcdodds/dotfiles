" start: automatically trim trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,js,less,styl,html,css autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

