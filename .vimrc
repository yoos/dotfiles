syntax on

" GNOME's terminal supports 256 colors but doesn't advertise it. Override vim's
" autodetection.
if $COLORTERM == 'Terminal' || $COLORTERM == 'xfce4-terminal'
  set t_Co=256
endif

colorscheme leap

"call pathogen#infect()

" Tab settings
"set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

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
map Y y$

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" Load functions from ~/.vim/autoload
autocmd FuncUndefined * exe 'runtime autoload/' . expand('<afile>') . '.vim'

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
"set colorcolumn=80

" Remap keys
nnoremap ; :

" Leader stuff
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>


:ab #b /*****************************************************************************
:ab #e *****************************************************************************/


