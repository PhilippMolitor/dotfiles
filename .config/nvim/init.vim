" plugins with plugged
call plug#begin('~/.vim/plugged')
Plug 'vim-python/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'b4b4r07/vim-hcl'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-airline/vim-airline'
Plug 'dylanaraps/wal.vim'
call plug#end()

" basics
set title
set number
set relativenumber
set showmatch
set wrap
set showbreak=>>\ \ 
set cursorline
set ignorecase
set incsearch
set noshowmode
syntax on

" syntax highlighting
highlight Comment cterm=italic
highlight Constant cterm=italic
highlight Special cterm=italic
highlight PreProc cterm=italic

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

" highlighted yank & paste
let g:highlightedyank_highlight_duration = 3000

" switch to next/prev. buffer with tab/shift-tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" write with root privileges
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" restore cursor position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
