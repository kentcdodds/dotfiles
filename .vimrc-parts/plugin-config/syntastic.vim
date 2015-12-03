" [buffer number] followed by filename:
set statusline=[%n]\ %F
" for Syntastic messages:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" show line#:column# on the right hand side
set statusline+=%=%l:%c

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" we should assume that the file is up to standard when opening
let g:syntastic_check_on_open = 0

let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_html_checkers=[''] " there's just too much weirdness with angular
