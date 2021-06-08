source $HOME/.config/nvim/themes/airline.vim
source $HOME/.config/nvim/plug-config/coc.vim

set clipboard=unnamedplus
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
set encoding=utf-8
set number relativenumber
syntax enable
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
"set colorcolumn=81 "can write over column, not past it
set fileformat=unix
set clipboard=unnamedplus
set mouse=a
set splitbelow
set splitright

colorscheme paramount

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemode = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'minimalist'

filetype plugin indent on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set cindent

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
nmap <F2> :NERDTreeToggle<CR>

nnoremap <C-H> <C-W><C-W>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

map <ScrollWheelUp> <C-U>
map <ScrollWheelDown> <C-D>

nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>

nnoremap <C-p> :GFiles <CR>

nnoremap <leader><space> :History <CR>
nnoremap <leader>lf :Lf <CR>
nnoremap <leader>lc :Lfcd <CR>

nnoremap <leader>m :MaximizerToggle!<CR>

nnoremap <CR> :noh<CR>

nnoremap zn :tabnew<Space>
nnoremap zk :tabnext<CR>
nnoremap zj :tabprev<CR>
nnoremap zh :tabfirst<CR>
nnoremap zl :tablast<CR>

nnoremap K i<CR><Esc>k$

"tnoremap <ESC> <C-\><C-n>:bd!<CR>

let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

autocmd FileType fish compiler fish
