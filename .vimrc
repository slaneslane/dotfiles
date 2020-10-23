set encoding=utf-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'tmhedberg/SimpylFold'
" Super searching
Plugin 'kien/ctrlp.vim'
" Git integration
Plugin 'tpope/vim-fugitive'
" Powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" File browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" Colors
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
" Syntax checking
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
" Autocomplete
Bundle 'Valloric/YouCompleteMe'
" Indentation
Plugin 'vim-scripts/indentpython.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" tab navigation mappings
map tt :tabnew
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
"filetype off
filetype plugin on
filetype indent on

" always show status bar
set ls=2

" incremental search
set incsearch
" highlighted search results
set hlsearch
" clear search results
nnoremap <silent> // :noh<CR>

" better backup, swap and undos storage for vim (nvim has nice ones by
" default)
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" create needed directories if they don't exist
if !isdirectory(&backupdir)
call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
call mkdir(&undodir, "p")
endif

" show line numbers
set nu

" remove ugly vertical lines on window division
set fillchars+=vert:\ 


" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1


" PEP 8 indentation
"au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=119
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix
" tabs and spaces handling
"set expandtab
"set tabstop=4
"set softtabstop=4
"set shiftwidth=4


" Frontend development indentation
"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2
"    \ set softtabstop=2
"    \ set shiftwidth=2


" Coloring as red bad whitespaces
"au BufRead,BufNewFile *.py,*.pyw,*.css,*.js match BadWhitespace /\s\+$/
" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" Autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

" Syntax checking
let python_highlight_all=1
syntax on

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
call togglebg#map("<F5>")

" File browsing
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Mouse support
set mouse=a
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" System clipboard
set clipboard=unnamed

" save as sudo
ca w!! w !sudo tee "%"

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash

" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>w Oimport wdb; wdb.set_trace()<esc>

" set vim leader to space
"nnoremap <SPACE> <Nop>
"let mapleader=" "
map <Space> <Leader>


" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
let NERDTreeShowHidden=1
