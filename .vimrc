" be iMproved, required
set nocompatible

" filetype detection and settings
filetype plugin indent on

" syntax highlighting
syntax enable

" Git commits.
autocmd FileType gitcommit setlocal spell

" Create backup before write
set backup

" backup file directory
silent !mkdir ~/.vim/backup > /dev/null 2>&1
set backupdir=~/.vim/backup

" Swap file directory
set directory=~/.vim/backup

" enable timout for commands
set ttimeout
set ttimeoutlen=100

if has("termguicolors")
  set termguicolors
endif

set background=dark

"if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://sunaku.github.io/vim-256color-bce.html
    set t_ut=
"endif

" show line numbers
set number

" Use relative line numbers
set relativenumber

" hides buffers instead of closing them
set hidden

set textwidth=120

" highlight column after 'textwidth'
set colorcolumn=+1

" Copy indent from current line when starting a new line
set autoindent

set smarttab

" Use spaces insted tabs
set expandtab

" The width of a TAB is set to 4. Still it is a \t. It is just that Vim will
" interpret it to be having a width of 4.
set tabstop=4
" Indents will have a width of 4.
set shiftwidth=4
" Sets the number of columns for a tab
set softtabstop=4

" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" Char shown on wrapped line
set showbreak='↪'

" soft-wrap lines
set wrap

" always show statusline
set laststatus=2

" set show matching parenthesis
set showmatch

" incremental search rules
set incsearch

" highlight all search results
" vim-motions will show highlights
"set hlsearch

" ignore case when searching
set ignorecase

" case sensitive if one character is uppercase
set smartcase

" use + (CLIPBOARD) register, so we can just copy with yy
" requires +clipboard support
" set clipboard=unnamedplus
"
" let the backspace key work normally
set backspace=indent,eol,start

" better command line completion, shows a list of matches
set wildmenu

" show cursor and line position in status line
set ruler

" start scrolling x lines before view ends
if !&scrolloff
  set scrolloff=5
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

" as much as possible of the last line in a window will be displayed
set display+=lastline

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" search tags files efficiently
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread

if &history < 1000
  set history=1000
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

if !empty(&viminfo)
  set viminfo^=!
endif

" exclude options from storing in sessions
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Change the mapleader from \ to space
let mapleader="\<Space>"

set pastetoggle=<F2>

" Autocomplete on space
inoremap <Nul> <C-n>

" Use <C-L> to clear the highlighting of :set hlsearch.
nnoremap <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Copy with ctr+c
" map <C-c> "+y<CR>"

" disable arrow keys
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>

inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>

vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <PageUp> <Nop>
vnoremap <PageDown> <Nop>

" disable ex mode
nnoremap Q <NOP>

nmap <F3> :set invnumber<CR>:set invrelativenumber<CR>

" next/prev error
nmap <C-n> :cnext<CR>
nmap <C-m> :cprev<CR>
nnoremap <leader>a :cclose<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip 

" vim:set ft=vim et sw=2:
