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

" GruvBox colorscheme
Plugin 'liushapku/vim-colorschemes-gruvbox' 

" ACK -> grep for programmers
Plugin 'mileszs/ack.vim'

" Super searching
Plugin 'ctrlpvim/ctrlp.vim'
" File browsing
Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs' " no longer supported!
Plugin 'tpope/vim-vinegar'
" Search results counter
Plugin 'vim-scripts/IndexedSearch'

" Git integration
Plugin 'tpope/vim-fugitive'
" Vim-Gitgutter (https://github.com/airblade/vim-gitgutter)
Plugin 'airblade/vim-gitgutter'


" Python autocompletion, go to definition.
Plugin 'davidhalter/jedi-vim'
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


" Tagbar
Plugin 'preservim/tagbar'

" Pending tasks list (like TODO)
Plugin 'fisadev/FixedTaskList.vim'

" Tab management
Plugin 'kien/tabman.vim'

" Consoles as buffers
Plugin 'rosenfeld/conque-term'

" Window chooser
"Plugin 't9md/vim-choosewin'

" Autoclose
Plugin 'Townk/vim-autoclose'

" Indent text object (https://github.com/michaeljsmith/vim-indent-object)
Plugin 'michaeljsmith/vim-indent-object'

" Indentation based movements (https://github.com/jeetsukumaran/vim-indentwise)
Plugin 'jeetsukumaran/vim-indentwise'


"" HTML & CSS related plugins:
" Surround (https://github.com/tpope/vim-surround)
Plugin 'tpope/vim-surround'

" HTML completion (https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL)
Plugin 'mattn/emmet-vim'

" Paint CSS colors with the real color
Plugin 'lilydjwg/colorizer'

" XML/HTML tags navigation
"Plugin 'vim-scripts/matchit.zip'
Plugin 'https://github.com/adelarsq/vim-matchit'

" YAML formatter (https://vimawesme.com/plugin/coc-yaml)
Plugin 'neoclide/coc-yaml'

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
"set pastetoggle=<F2>
"set clipboard=unnamed
" eventually:
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode

" always show status bar
set ls=2

" faster update (default = 4000 -> 4 sec)
set updatetime=100


"" LINES NUMBERING:
" turn relative line numbers on
set number relativenumber
" automatic relative line numbers on
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


" no lines wrapping (anyway: gq -> wrap line)
set tw=119
set nowrap
set fo-=t

" color column of max code line length
"au BufNewFile,BufRead *.py set colorcolumn=120
"highlight ColorColumn ctermbg=233


" set vim leader to space
map <Space> <Leader>


"" MOUSE:
" Mouse support
set mouse=a
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3


"" Colorscheme:
colorscheme torte " -> one of the defult colorschema
"colorscheme gruvbox
"set background=dark
"let g:gruvbox_contrast_dark = 'soft' " -> hard/medium/soft


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

set wildignore+=.git,
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=*~,*.swp,*.tmp

" CtrlP
" HINT: for refreshing the files structure press F5 in CtrlP mode!
" don't change working directory
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 30
" don't show those file types
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules|\.pytest_cache|htmlcov)$',
  \ 'file': '\.pyc$\|\.pyo$\|\.py,cover$',
  \ }
" file finder mapping
let g:ctrlp_show_hidden = 1


" ACK options
nnoremap <leader>a <Esc>:Ack!
"nnoremap <leader>ra :Ack <cword><CR>
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

"" JSON Formatting:
" using python
"nnoremap <leader>jf :%!python -m json.tool<CR>
" using jq -> require installed sudo apt install jq (which is ASCII safe)
nnoremap <leader>jf :%!jq .<CR>

"" XML Formatting:
" using xmllint (sudo apt install libxml)
" for using: gg=G
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"" GIT:
" Fugitive
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gbl :Gblame<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
"
" Gitgutter
au CursorMoved * if gitgutter#hunk#in_hunk(line(".")) | GitGutterPreviewHunk | else | pclose | endif
noremap <Leader>c :GitGutterToggle<CR>
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 0
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
"nnoremap , za
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

nmap <leader>e :Errors<CR>

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
"let g:autopep8_on_save = 1
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


" Jedi-vim (python only)
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = 1

let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"


" Autocomplete
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif


"" PYTHON SNIPPETS:
" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>p Oimport pdb; pdb.set_trace()<esc>
au FileType python map <silent> <leader>w Oimport wdb; wdb.set_trace()<esc>
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>


"" EXTRAS:
" Tagbar (F4)
noremap <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1


" Tasklist
" show pending tasks list
map <F5> :TaskList<CR>


" Tabman
"Press <leader>mt or run :TMToggle to toggle TabMan.
"Press <leader>mf or run :TMFocus to give focus to/open the TabMan window.

" Congue Term
" :ConqueTermSplit python
" :ConqueTerm bash
" :ConqueTermSplit mysql -h localhost -u joe -p sock_collection
" :ConqueTermVSplit C:\Python27\python.exe
noremap <Leader>python :ConqueTermSplit python3<CR>
noremap <Leader>bash :ConqueTermSplit bash<CR>

" Windows Chooser invoke with '-'
nmap  -  <Plug>(choosewin)

" Autoclose
" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" For WSL only (Linux in Windows):
set visualbell
