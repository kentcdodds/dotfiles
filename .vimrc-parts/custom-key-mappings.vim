" Insert carriage return in normal mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" copy current file's path
nmap rcp :let @+ = expand("%") <cr>
nmap cp :let @+ = expand("%:p") <cr>

" map F3 to toggle search highlighting
nnoremap <F3> :set hlsearch!<CR>

" source ~/.vimrc
nnoremap <F7> :so ~/.vimrc<CR>



" bind K to grep word under cursor - https://robots.thoughtbot.com/faster-grepping-in-vim
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut - https://robots.thoughtbot.com/faster-grepping-in-vim
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

