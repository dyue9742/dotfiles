set nocompatible
filetype plugin on

syntax enable

call plug#begin()
" SYNTAX
Plug 'othree/yajs.vim'
Plug 'herringtondarkholme/yats.vim'

"OTHER DISPLAY
Plug 'lifepillar/vim-solarized8'
Plug 'lifepillar/vim-gruvbox8'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/rainbow_parentheses.vim'

" LANGUAGE
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'vim-ruby/vim-ruby'
Plug 'rust-lang/rust.vim'
Plug 'python-mode/python-mode'

" PRETTIER
Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile --production' }

" AUTOCOMPLETE
Plug 'ycm-core/YouCompleteMe'

" GIT
Plug 'tpope/vim-fugitive'

" TOOLS
"
" Basic Usages
" 	select words with Ctrl-N
" 	create cursors vertically with Ctrl-Down/Ctrl-Up
" 	select one character at a time with Shift-Arrows
" 	press n/N to get next/previous occurrence
" 	press [/] to select next/previous cursor
" 	press q to skip current and get next occurrence
" 	press Q to remove current cursor/selection
" 	start insert mode with i,a,I,A
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Default bindings
" 	map <Leader> <Plug>(easymotion-prefix)
" 	Type <Leader><Leader>w to trigger the word motion w.
" 		When the motion is triggered, the text is updated by
" 		highlighting.
" 		Press ? to jump to the beginning of a word started by ?.
" 		If looking for a character ?, use the f motion. Type <Leader><Leader>f?.
Plug 'easymotion/vim-easymotion'

" INTERFACE
Plug 'junegunn/fzf', {'do': {-> fzf#install() }}

Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
call plug#end()

set backspace=indent,eol,start
set completeopt-=preview

set hidden

set mouse=a

set ruler

set number
set relativenumber

set t_Co=256
set termguicolors
set background=dark

set encoding=utf-8
set fileencoding=utf-8

set cmdheight=2
set pumheight=10
set laststatus=2
set conceallevel=0

set autoindent
set smartindent

set smarttab
set expandtab

set smartcase
set ignorecase

set showcmd
set showmode
set showmatch

set hlsearch
set incsearch

set tabstop=4
set softtabstop=4

set shiftwidth=4

set cursorline

set scrolloff=10

set timeoutlen=500

set wildmenu
set wildmode=list:longest
set wildignore=.DS_Store,*.pyc,*.exe,*/node_modules/*,*/__pycache__/*,*/.git/*,*/.next/*

set noerrorbells
set noswapfile
set nobackup
set nowrap

autocmd BufWrite * :%s/\s\+$//e
autocmd BufEnter * set indentexpr=

nnoremap [b :bprev<CR>
nnoremap b] :bnext<CR>

let mapleader = ","

let g:polyglot_disable = ['autoindent']

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

let g:go_highlight_operators = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

" if exists('$TMUX')
"   let g:fzf_layout = { 'tmux': '-p80%,80%' }
" else
"   let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'relative': v:true } }
" endif
let g:fzf_layout = {'down': '40%'}
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Prettier
nnoremap pretty :silent %!prettier --stdin-filepath %<CR>

" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[38;2;%lu;%lu;%lum"

let g:lightline = {
  \ 'colorscheme': 'sonokai',
  \ }

let g:everforest_background = 'hard'
let g:everforest_ui_contrast = 'high'
let g:everforest_spell_foreground = 'colored'
let g:everforest_diagnostic_text_highlight = 1
let g:everforest_diagnostic_line_highlight = 1
" colorscheme everforest
colorscheme sonokai

" n - normal
" i - insert
" v - visual and select
" s - select
" x - visual
" c - command-line
" o - operator pending
" nmap, nnoremap, numap
" imap, inoremap, iumap
" vmap, vnoremap, vumap
" xmap, xnoremap, xumap
" smap, snoremap, sumap
" cmap, cnoremap, cumap
" omap, onoremap, oumap
