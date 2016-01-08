" https://robots.thoughtbot.com/faster-grepping-in-vim

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
