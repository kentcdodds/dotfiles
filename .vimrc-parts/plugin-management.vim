" plugin management by vim-plug
" ultisnips config
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-J>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="horizontal"

call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-ctrlp-autoignore'
Plug 'burke/matcher'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'moll/vim-node'

" emoji!!!
Plug 'kyuhi/vim-emoji-complete'

" syntastic
Plug 'scrooloose/syntastic'

" elm
Plug 'lambdatoast/elm.vim'

Plug 'othree/yajs.vim'

" markdown syntax
Plug 'jtratner/vim-flavored-markdown'

" auto-complete plugins
Plug 'Valloric/YouCompleteMe'
Plug 'marijnh/tern_for_vim'

" snippets
Plug 'SirVer/ultisnips'

" surround
Plug 'tpope/vim-surround'
call plug#end()

" syntastic config
let g:loaded_syntastic_javascript_jshint_checker = 1

" vim-jsx config
let g:jsx_ext_required = 0

" ctrlp config
let g:ctrlp_extensions = ['autoignore']

" NERDTree config
let NERDTreeIgnore = ['\.swp$', '\.DS_Store', '\.idea']
let NERDTreeShowHidden = 1


" vim-flavored-markdown config
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" YouCompleteMe stuff
" Do not display "Pattern not found" messages during YouCompleteMe completion
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
try
  set shortmess+=c
catch /E539: Illegal character/
endtry
