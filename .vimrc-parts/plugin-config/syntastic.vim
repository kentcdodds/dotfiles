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
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

" setup es6 stuff for paypal/p2pnodeweb stuff
autocmd BufRead,BufNewFile \(*/paypal/p2pnodeweb/*/calculator/*.js$\)\|\(*paypal/p2pnodeweb/*.es6$\) call s:setupES6File()
autocmd BufWritePost \(*/paypal/p2pnodeweb/*/calculator/*.js$\)\|\(*paypal/p2pnodeweb/*.es6$\) silent !npm-run eslint -c "/Users/kdodds/Developer/paypal/p2pnodeweb/.eslintes6rc" --fix %

" https://github.com/jamischarles/dotfiles/commit/f907f3b66345b35d051061412d6bcb8b4b5a733d
function! s:setupES6File()
  setfiletype javascript
  set noexpandtab

  " Set the checkers for the current buffer to eslint
  " let b:syntastic_checkers = ["eslint"] " b: means for the current buffer only...
  " Set the arguments to pass to eslint to use the es6 ruleset...
  let b:syntastic_javascript_eslint_args = "-c /Users/kdodds/Developer/paypal/p2pnodeweb/.eslintes6rc"
  let b:syntastic_javascript_eslint_exec = "/Users/kdodds/Developer/paypal/p2pnodeweb/node_modules/.bin/eslint"
endfunction

