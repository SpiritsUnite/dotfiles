" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set notimeout
set ttimeout
set ttimeoutlen=100

set splitright

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" backup settings
set directory^=~/.vim/swp//
set backupdir^=~/.vim/tmp

" persistent undo
if version >= 703
	set undofile
	set undodir=~/.vim/undo
endif

" indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4

" prefix style tab completion
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.o

set number               " show line numbers
set ruler                " show the cursor position all the time
set history=50           " keep 50 lines of command line history
set showcmd              " display incomplete commands
set incsearch            " do incremental searching
set scrolloff=3          " always show 3 lines above/below cursor
set lazyredraw           " speed up repeated commands by not redrawing

" visual settings
set background=dark      " better colours for dark terminals
set cursorline           " underline current line
set synmaxcol=120        " vim's parsing of long lines is trash
set list
set listchars=tab:\|\ ,trail:·

set textwidth=80
set colorcolumn=+1

set nojoinspaces
set dictionary=/usr/share/dict/words

" hacky enable build c/++ files with :make settings
" (% -> filename, %:r -> filename without extension)
set makeprg=make\ -Bf\ ~/coding/Makefile\ %:r
set autowrite

" C-c suppresses some behaivour (like visual block + I)
inoremap <C-c> <C-[>
noremap <C-c> <C-[>
" pls go
let g:ftplugin_sql_omni_key = '<C-j>'

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

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

		" For all text files set 'textwidth' to 72 characters.
		autocmd FileType text setlocal textwidth=72

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

	autocmd FileType python set expandtab
	autocmd FileType haskell set expandtab ts=2 sts=2 sw=2
	autocmd FileType html* set expandtab ts=2 sts=2 sw=2

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

if filereadable($HOME . "/.vimrc.local")
	source $HOME/.vimrc.local
endif

set fileencodings=ucs-bom,utf-8,sjis,default,latin1
