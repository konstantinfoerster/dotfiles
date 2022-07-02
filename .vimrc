" be iMproved, required
set nocompatible

" install vim-plug if not exists
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
function FixupBase16(info)
    !sed -i '/Base16hi/\! s/a:\(attr\|guisp\)/l:\1/g' ~/.vim/plugged/base16-vim/colors/*.vim
endfunction
Plug 'chriskempson/base16-vim', { 'do': function('FixupBase16') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'  }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

Plug 'neomake/neomake'

Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'

" Add plugins to &runtimepath
call plug#end()

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

"let base16colorspace=256
colorscheme base16-atelier-dune

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

" highlight current line number and line
" error text is unreadable if enabled. https://github.com/chriskempson/base16-vim/issues/125
"set cursorline
" highlight only the firs 200 characters
"set synmaxcol=200

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

" show always airline statusline 
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

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Change the mapleader from \ to space
let mapleader="\<Space>"

set pastetoggle=<F2>

" Autocomplete on space
inoremap <Nul> <C-n>

" Nerdtree toggle
map <Leader>n :NERDTreeToggle<CR>

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

map <Leader> <Plug>(easymotion-prefix)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

" next/prev error
nmap <C-n> :cnext<CR>
nmap <C-m> :cprev<CR>
nnoremap <leader>a :cclose<CR>

"Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Airline
"
let g:airline_powerline_fonts = 1
let g:airline_theme='dark' 

" vim javascript
"
" Enables syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1
" Enables some additional syntax highlighting for NGDocs. Requires JSDoc plugin to be enabled as well.
let g:javascript_plugin_ngdoc = 1

" vim json
" disable conceal
let g:vim_json_syntax_conceal = 0

" ctrlp
"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " respect git ignore files
  "let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

  let g:ctrlp_working_path_mode = 'ra'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  "let g:ctrlp_extensions = ['line']
endif

"Neomake
"
"let g:neomake_javascript_enabled_makers = ['eslint']
"let g:neomake_autolint_cachedir = "/tmp"
"let g:neomake_open_list = 2

" vim:set ft=vim et sw=2:
