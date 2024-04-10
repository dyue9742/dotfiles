filetype plugin on

" if &term =~ '^\%(screen\|tmux\)'
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8f = "\<Esc>[48;2;%lu;%lu;%lum"
" endif
" set termguicolors

set nocompatible

set backspace=eol,start,indent

set bg=dark

set nu rnu

set laststatus=2

set expandtab
set autoindent
set cursorline

set shiftround
set shiftwidth=4
set tabstop=4

set re=0

set cmdheight=2
set pumheight=10

set nowrap
set nobackup
set noswapfile
set noerrorbells
set novisualbell


call plug#begin()
" Plug 'itchyny/lightline.vim'
" 
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'junegunn/fzf', {'do': { -> fzf#install()} }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'preservim/tagbar'
Plug 'preservim/vim-indent-guides'

" Plug 'bfrg/vim-cpp-modern'
" Plug 'vim-python/python-syntax'
" Plug 'HerringtonDarkholme/yats.vim'

Plug 'vim-test/vim-test'
Plug 'vim-ruby/vim-ruby'
Plug 'rust-lang/rust.vim'
" Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}

Plug 'sheerun/vim-polyglot'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'lifepillar/vim-solarized8'
call plug#end()


autocmd BufNewFile,BufReadPost *.m set filetype=objc

let g:fzf_layout = { 'down': '50%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" let g:lightline = {
"       \ 'colorscheme': 'solarized',
"       \ }
" 
" let g:python_highlight_all = 1
" 
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_generate_tags = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_function_parameters = 1
" let g:go_highlight_variable_assignments = 1
" let g:go_highlight_variable_declarations = 1
" 
" let g:cpp_function_highlight = 1
" let g:cpp_attributes_highlight = 1
" 
" let g:solarized_extra_hi_groups = 1
" let g:solarized_statusline = "flat"
" let g:solarized_visibility = "high"
" let g:solarized_diffmode = "high"
" colorscheme solarized8


" vipga=
xmap ga <Plug>(EasyAlign)
" gaip=
nmap ga <Plug>(EasyAlign)

nmap <F8> :TagbarToggle<CR>

nmap [b :bprevious<CR>
nmap ]b :bn<CR>

colorscheme gruvbox8
