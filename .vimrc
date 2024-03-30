set nocompatible
syntax enable
filetype plugin on


set bs=eol,start,indent

set bg=dark

set nu
set rnu

set laststatus=2

set expandtab
set autoindent
set cursorline
set cursorcolumn

set shiftround
set shiftwidth=2
set tabstop=2
set softtabstop=2

set re=0

" set nowrap
set nobackup
set noswapfile
set noerrorbells
set novisualbell

set termguicolors

call plug#begin()
Plug 'junegunn/fzf', {'do': { -> fzf#install()} }
Plug 'itchyny/lightline.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'vim-ruby/vim-ruby'
Plug 'rust-lang/rust.vim'

Plug 'bfrg/vim-cpp-modern'
Plug 'vim-python/python-syntax'
Plug 'HerringtonDarkholme/yats.vim'

Plug 'lifepillar/vim-solarized8'
call plug#end()


autocmd BufNewFile,BufReadPost *.m set filetype=objc

let g:fzf_layout = { 'down': '30%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

let g:python_highlight_all = 1

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

let g:cpp_function_highlight = 1
let g:cpp_attributes_highlight = 1

let g:solarized_extra_hi_groups = 1
let g:solarized_statusline = "flat"
let g:solarized_visibility = "high"
let g:solarized_diffmode = "high"
colorscheme solarized8
