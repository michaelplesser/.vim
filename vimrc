" Maintainer: Michael Plesser

" This must be first, because it changes other options as a side effect.
set nocompatible

" Change directories where swap, undo, ,and backup files are stored
set directory^=$HOME/.vim/.swp//
set undodir^=$HOME/.vim/.undo//
set backupdir^=$HOME/.vim/.backup//

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup          " Keep backups
set undofile		" keep an undo file (undo changes after closing)

set history=100		" keep 100 lines of command line history

set number          " show line number
set ttyfast         " faster scrolling
set ruler	    	" show the cursor position all the time
set scrolloff=5     " display 5 lines above/below the cursor when scrolling with a mouse.

set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set hlsearch        " highlight searches
set smartcase       " Only search for CAPS if search term is all CAPS, otherwise do BoTh

" indent settings
set tabstop=4		" show tabs as 4 spaces
set shiftwidth=4	" tab inserts 4 spaces
set expandtab

" Custom shenanigans
"
" Map ;->;, IE instead of :w->;w
" One less keystroke, and never again type :W by mistake... 
nnoremap ; :
" If a line wraps and you move the cursor up/down, don't skip the wrapped line
nnoremap j gj
nnoremap k gk

" Vim's auto indentation feature does not work properly with text copied from
" outisde of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Don't use Ex mode, use Q for formatting
map Q gq

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Add vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Change color scheme
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
