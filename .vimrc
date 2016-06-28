set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Git wrapper
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" show line numbers
" set number

" Use relative line numbers
set relativenumber

" hides buffers instead of closing them
set hidden

" highlight current line number and line
set cursorline
hi CursorLine   cterm=NONE ctermbg=10 ctermfg=NONE
hi cursorlinenr ctermfg=13

" highlight column after 'textwidth'
set colorcolumn=+1
hi ColorColumn ctermbg=10

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

" show always airline statusline 
set laststatus=2

" set show matching parenthesis
set showmatch

" ignore case when searching
set ignorecase

" use + (CLIPBOARD) register, so we can just copy with yy
" requires +clipboard support
" set clipboard=unnamedplus


syntax on

" Key mappings

" Change the mapleader from \ to ,
let mapleader=","
set pastetoggle=<F2>

map <C-n> :NERDTreeToggle<CR>

" Copy with ctr+c
" map <C-c> "+y<CR>"

" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" disable ex mode
nnoremap Q <NOP>

" Easy window navigation
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l

" Airline
"
let g:airline_powerline_fonts = 1
let g:airline_theme='dark' 
"if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" vim javascript
" 
" Enables syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1
"Enables some additional syntax highlighting for NGDocs. Requires JSDoc plugin to be enabled as well.
let g:javascript_plugin_ngdoc = 1

" vim json
" disable conceal
let g:vim_json_syntax_conceal = 0
