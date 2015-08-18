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
