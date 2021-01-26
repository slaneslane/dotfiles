set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" ACK -> grep for programmers
Plugin 'mileszs/ack.vim'

" Super searching
Plugin 'ctrlpvim/ctrlp.vim'
" File browsing
Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs' " no longer supported!
Plugin 'tpope/vim-vinegar'

" Git integration
Plugin 'tpope/vim-fugitive'
" Vim-Gitgutter
" https://github.com/airblade/vim-gitgutter
Plugin 'airblade/vim-gitgutter'
" Git/mercurial/others diff icons on the side of the file lines - more simple than gitgutter
"Plugin 'mhinz/vim-signify'


" Autocomplete
"Plugin 'Valloric/YouCompleteMe'

" Code commenting
Plugin 'preservim/nerdcommenter'

" better python indentation
Plugin 'vim-scripts/indentpython.vim'
" better python code folding (if need faster behaviour check plugin FastFold)
Plugin 'tmhedberg/SimpylFold'

" checking python syntax
Plugin 'vim-syntastic/syntastic'
" checking python syntax up to flake-8
Plugin 'nvie/vim-flake8'
" Auto correction python code to pep8
Plugin 'tell-k/vim-autopep8'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" BACKUP YOUR WORK IN VIM EDITOR:
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


"" MAIN SETTINGS OF VIM EDITOR:

" For plugins which are filetype enabled
filetype on
filetype plugin on
filetype indent on

" encoding in UTF-8
set encoding=utf-8

" save as sudo
ca w!! w !sudo tee "%"

" better copy-paste (F2)
set pastetoggle=<F2>
set clipboard=unnamed

" always show status bar
set ls=2

" faster update (default = 4000 -> 4 sec)
set updatetime=100

"color scheme:
colorscheme torte


"" LINES NUMBERING:
" turn relative line numbers on
set number relativenumber
" automatic relative line numbers on
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


" set vim leader to space
map <Space> <Leader>


"" MOUSE:
" Mouse support
set mouse=a
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3


"" NERDTree (R -> refresh) -> press F3 to open (t -> open in new tab, o -> open here)
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$'] "ignore files in NERDTree
" show hidden files like dotfiles
let NERDTreeShowHidden=1
" close on open:
let NERDTreeQuitOnOpen=1


"" SEARCHING:
" Search smart way backup(only this will find all possibilities)/Backup/BACKUP
set ignorecase
set smartcase
" incremental search (place the cursor to first match)
set incsearch
" highlighted search results
set hlsearch
" clear search results by pressing ENTER
nnoremap <silent> <CR> :noh<CR><CR>


" ctrlP don't show those file types
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*.pyo


" ACK options
nmap <leader>a <Esc>:Ack!
let g:ack_autoclose = 1


"" SPLITS -> TABS, BUFFERS, etc:
" not a default area of opened splits
set splitbelow
set splitright

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tab navigations
" gT - backward
" gt - forward

" Buffers:
" :ls -> list all buffers
" :b <number> -> change to buffer number

"" GIT
" Gitgutter:
au CursorMoved * if gitgutter#hunk#in_hunk(line(".")) | GitGutterPreviewHunk | else | pclose | endif
noremap <Leader>c :GitGutterToggle<CR>
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
" You can jump between hunks with [c and ]c.
" You can preview hunks with <leader>hp
" You can stage hunks with <leader>hs
" You can undo hunks with <leader>hu


"" COMMENTING && SURROUNDING
" NERDCommenter:
" [count]<leader>cc -> comment
" [count]<leader>cu -> uncoment
" [count]<leader>ci -> insert
" [count]<leader>cs -> sexy



"" INDENTATION:
" python code indentation:
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
" fullstack code indentation:
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2


"" FOLDING:
" Enable folding (press 'za' to hide/show)
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar instead pressing za (might be in conflict with leader)
nnoremap , za
" options for SimpleFold plugin:
let g:SimpylFold_docstring_preview = 1


"" PYTHON CODE SYNTAX AND CODE CORRECTIONS:
" python syntax highlighting
let python_highlight_all=1
syntax on
" by saving syntastic plugin will check the code syntax
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1


" Flake8 (pip install flake8) -> press F7 to do the check
" or always check
"autocmd BufWritePost *.py call Flake8()

let g:flake8_error_marker='EE'     " set error marker to 'EE'
let g:flake8_warning_marker='WW'   " set warning marker to 'WW'
"let g:flake8_pyflake_marker=''     " disable PyFlakes warnings
"let g:flake8_complexity_marker=''  " disable McCabe complexity warnings
"let g:flake8_naming_marker=''      " disable naming warnings

" to use colors defined in the colorscheme
highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg

" put the following into your ~/.config/flake8 file:
" [flake8]
" max-line-length = 120


" Autopep8 (pip install --user autopep8) -> press F8 to do the fix (or on save)
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
" auto correct on every save
let g:autopep8_on_save = 1
" better don't show if works on every save
let g:autopep8_disable_show_diff=0
" Do not fix these errors/warnings (default: E226,E24,W6)
"let g:autopep8_ignore="E501,W293"
" Fix only these errors/warnings (e.g. E4,W)
"let g:autopep8_select="E501,W293"
" set max line length to 120
let g:autopep8_max_line_length=119



"" OTHER CODE CORRECTIONS:
"Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


"" PYTHON SNIPPETS:
" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>p Oimport pdb; pdb.set_trace()<esc>
au FileType python map <silent> <leader>w Oimport wdb; wdb.set_trace()<esc>
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>


" Autocomplete
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
