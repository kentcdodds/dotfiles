" plugin management by vim-plug
call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-ctrlp-autoignore'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'moll/vim-node'

" emoji!!!
Plug 'kyuhi/vim-emoji-complete'

" syntastic
Plug 'scrooloose/syntastic'

" ES6 and JSX syntax support
Plug 'mxw/vim-jsx'
call plug#end()

" syntastic config
let g:loaded_syntastic_javascript_jshint_checker = 1

" vim-jsx config
let g:jsx_ext_required = 0

" ctrlp config
let g:ctrlp_extensions = ['autoignore']
