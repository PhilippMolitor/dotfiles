" plugins with plugged
call plug#begin('~/.vim/plugged')
Plug 'vim-python/python-syntax'
Plug 'rust-lang/rust.vim'

Plug 'Yggdroot/indentLine'
Plug 'machakann/vim-highlightedyank'

Plug 'vim-airline/vim-airline'
Plug 'dylanaraps/wal.vim'

Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
call plug#end()

" basics
set title
set number
set relativenumber
set showmatch
set wrap
syntax on

" tabs
set softtabstop=2
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" enable mouse interaction
set selectmode+=mouse
set mouse=a

" disable swapfiles
set noswapfile
set nobackup
set nowritebackup

" yank & paste --> system clipboard
set clipboard=unnamedplus

" vim-airline
let g:airline_theme='wal'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" indent line guides
let g:indentLine_enabled = 1
let g:indentLine_char = '┆'

" highlighted yank & paste
let g:highlightedyank_highlight_duration = 3000

" restore cursor position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
