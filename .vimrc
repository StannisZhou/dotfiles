" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'tmhedberg/matchit'
Plug 'fholgado/minibufexpl.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'python-mode/python-mode'
Plug 'danro/rename.vim'
Plug 'vim-syntastic/syntastic'
Plug 'xolox/vim-notes'
Plug 'tpope/vim-eunuch'
Plug 'vim-scripts/taglist.vim'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'Shougo/neocomplete.vim'
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-airline/vim-airline'
Plug 'Konfekt/FastFold'
Plug 'heavenshell/vim-pydocstring'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'StannisZhou/vim-pweave'
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'cjrh/vim-conda'
Plug 'nathangrigg/vim-beancount'
" Initialize plugin system
call plug#end()


let macvim_skip_colorscheme=1
let mapleader=","
nmap <silent> <leader>ov :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set noswapfile
set history=1000		" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif
		autocmd BufNewFile,BufReadPost *.md set filetype=markdown

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

filetype plugin on
set omnifunc=syntaxcomplete#Complete
set hidden
" Hybrid line number mode
set relativenumber
set number
" Smart case for searching
set ignorecase
set smartcase
" automatically read changed files
set autoread
" Gui options
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h22
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
" Some customized mappings
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <Leader>q :q<CR>
" Automatically fix indentation
nnoremap <Leader>= mqgg<S-v>G=`q:delm q<CR>

"Options for minibufexpl
let g:miniBufExplBuffersNeeded = 1
nnoremap <Leader>m :MBEbd<CR>
noremap <C-TAB> :bnext<CR>
noremap <C-S-TAB> :bprevious<CR>
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
inoremap <C-J> <C-W>j
inoremap <C-K> <C-W>k
inoremap <C-H> <C-W>h
inoremap <C-L> <C-W>l

" Options for SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Options for EasyMotion
let g:EasyMotion_leader_key = '<leader>'

" Options for NERDTree
map <C-n> :NERDTreeToggle<CR>

"Shortcuts for dealing with parathesis/brackets
inoremap <C-e> <Esc>$a
inoremap <A-k> <C-o>h
inoremap <A-l> <C-o>l

"Shrotcuts for maximizing buffers
nmap tt :tab split<CR>

" Some python options
au FileType python set colorcolumn=121

" Options for Pymode
let g:pymode_options_max_line_length = 120
let g:pymode_folding = 0
let g:pymode_doc = 0
let g:pymode_virtualenv = 0
let g:pymode_run = 0
let g:pymode_breakpoint = 0
let g:pymode_lint_cwindow = 0
let g:pymode_rope = 0

" Options for wrapping
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

" Options for NERDCommenter
let NERDSpaceDelims=1

" Options for vim-notes
let g:notes_directories = ['~/Dropbox/vim_notes/notes']
let g:notes_suffix = '.txt'
let g:notes_title_sync = 'change_title'
nnoremap <Leader>i :Note index<CR>
nnoremap <Leader>gf :silent !open "<cfile>" &<CR>
nnoremap <Leader>gt :silent !texmacs <cfile> &<CR>
nnoremap <Leader>gg vi"y:silent !open "<C-r>"" &<CR>

" Shortcuts for inserting date and time
nnoremap <Leader>dt "=strftime("## %a %x %X %Z:")<CR>Po<CR><TAB>
nnoremap <Leader>dm "=strftime("~/Dropbox/vim_notes/math_notes/math_%b_%d_%Y.tm")<CR>pF.

" Options for taglist
nnoremap <C-t> :TlistToggle<CR>

" Options for SympylFold
let g:SimpylFold_docstring_level = 3

" Options for syntastic
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"

" Options for neocomplete
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#smart_auto_mappings = 0

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
set completeopt-=preview

" Options for FastFold
let g:fastfold_savehook = 1
let g:fastfold_fdmhook = 0
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" Options for vimpydocstring
nmap <silent> <leader>doc :Pydocstring<CR>
let g:pydocstring_enable_mapping = 0

" Options for vimtex
let maplocalleader=','
let g:vimtex_fold_enabled=1
let g:vimtex_view_automatic=0
" let g:vimtex_view_method='skim'
" let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_indent_enabled=1
if !exists('g:neocomplete#sources#omni#input_patterns')
let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
\ '\v\\%('
\ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
\ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
\ . '|hyperref\s*\[[^]]*'
\ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
\ . '|%(include%(only)?|input)\s*\{[^}]*'
\ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
\ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
\ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
\ . '|usepackage%(\s*\[[^]]*\])?\s*\{[^}]*'
\ . '|documentclass%(\s*\[[^]]*\])?\s*\{[^}]*'
\ . '|\a*'
\ . ')'
let g:tex_flavor = "latex"
autocmd Filetype tex inoremap <buffer> $ $$<esc>i

" Options for vim-latex-live-preview
let g:livepreview_previewer = 'open -a skim'
let g:livepreview_engine = 'latexmk -pdf'

" Options for python-mode
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0

" Options for markdown-folding
let g:markdown_fold_style = 'nested'

" Options for getting the right path
set shell=bash  " avoids munging PATH under zsh
let g:is_bash=1 " default shell syntax
