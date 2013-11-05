syntax on

" GNOME's terminal supports 256 colors but doesn't advertise it. Override vim's
" autodetection.
if $COLORTERM == 'Terminal' || $COLORTERM == 'xfce4-terminal'
  set t_Co=256
endif

colorscheme leap

" Tab settings
"set expandtab       " Tabs insert spaces
set tabstop=4       " Number of spaces inserted at every press of the tab key
set shiftwidth=4    " Number of spaces inserted per indentation
set softtabstop=4   " Spaces used for indentation behave like tab characters when tabbing and backspacing

" Sanity
set encoding=utf-8
set scrolloff=3
"set mouse=a   "Enable mouse scrolling
"set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=longest,list
set nocompatible
set visualbell
set cursorline   " Highlight the line the cursor is on.
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber   " Number lines relative to the current line.
set undofile   " Create undo file.
"highlight clear SignColumn   " Make gutter and background the same color.
set clipboard=unnamedplus

" Searching and moving
set ignorecase
set smartcase
"set gdefault   " Apply substitutions globally by default.
set incsearch
set showmatch
set hlsearch


set backup
set backupdir=~/.vim/backup

map ,c :w !pdflatex % &
map ,b :w !bibtex % &
map ,v :!okular &
map ,s :SyntasticCheck
map Y y$

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
execute pathogen#infect()

" Syntastic settings.
let g:syntastic_check_on_wq = 0   " Don't check syntax on write.
let g:syntastic_c_check_header = 1
let g:syntastic_c_no_include_search = 1
let g:syntastic_c_no_default_include_dirs = 1
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_cpp_no_default_include_dirs = 1
let g:syntastic_python_checkers = ['flake8']

" Arduino syntax
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" Mark trailing whitespace
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Handle long lines.
"highlight OverLength cterm=underline
"match OverLength /\%81v.\+/
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

" Remap keys
nnoremap ; :

" Leader stuff
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>


:ab #b /*****************************************************************************
:ab #e *****************************************************************************/


