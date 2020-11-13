" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'tmhedberg/matchit'
Plug 'fholgado/minibufexpl.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'python-mode/python-mode'
Plug 'danro/rename.vim'
Plug 'xolox/vim-notes'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-airline/vim-airline'
Plug 'Konfekt/FastFold'
Plug 'heavenshell/vim-pydocstring'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
Plug 'Shougo/unite.vim'
Plug 'mileszs/ack.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zenbro/mirror.vim'
Plug 'ayu-theme/ayu-vim' " or other package manager
Plug 'kassio/neoterm'
Plug 'nikvdp/neomux'
Plug 'preservim/tagbar'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
Plug 'pedrohdz/vim-yaml-folds'
" Initialize plugin system
call plug#end()

let g:python3_host_prog='/home/stannis/miniconda3/bin/python'


" FVim options
if exists('g:fvim_loaded')
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
endif

let mapleader=","
nmap <silent> <leader>ov :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
set nocompatible

set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme ayu
set nobackup
set noswapfile
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")
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
set hidden
" Hybrid line number mode
set relativenumber
set number
" Smart case for searching
set ignorecase
set smartcase
" automatically read changed files
set autoread
au CursorHold * :checktime 
au FocusGained * :checktime

" Gui options
set guifont=Monospace:h22
" Some customized mappings
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <Leader>q :q<CR>
" Automatically fix indentation
nnoremap <Leader>= mqgg<S-v>G=`q:delm q<CR>

"Options for minibufexpl
let g:miniBufExplBuffersNeeded = 1
nnoremap <Leader>m :MBEbd<CR>
noremap <C-PageDown> <C-W>j
noremap <C-PageUp> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Options for SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Options for EasyMotion
let g:EasyMotion_leader_key = '<leader>'
nmap <Leader>b <Plug>(easymotion-b)

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
let g:pymode_lint=0
let g:pymode_lint_write = 0

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
autocmd FileType notes setlocal nospell tabstop=3 shiftwidth=3 softtabstop=3 expandtab
nnoremap <Leader>i :Note index<CR>
nnoremap <Leader>gf :silent !xdg-open "<cfile>" &<CR>
nnoremap <Leader>gg vi"y:silent !xdg-open "<C-r>"" &<CR>
nnoremap <Leader>gt :silent !/usr/local/bin/texmacs <cfile> &<CR>

" Shortcuts for inserting date and time
nnoremap <Leader>dt "=strftime("## %a %x %X %Z:")<CR>Po<CR><TAB>
nnoremap <Leader>dm "=strftime("~/Dropbox/vim_notes/math_notes/math_%b_%d_%Y.tm")<CR>pF.

" Options for SympylFold
let g:SimpylFold_docstring_level = 3

" Options for autocomplete
set omnifunc=syntaxcomplete#Complete
set pyxversion=3
set encoding=utf-8
let g:deoplete#enable_at_startup = 1
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#smart_auto_mappings = 0

" Enable heavy omni completion.
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

function! VimtexHookZathura() abort
  let xwin_id = get(b:vimtex.viewer, 'xwin_id')
  if xwin_id > 0
    silent call system('xdotool windowactivate ' . xwin_id . ' --sync')
    silent call system('xdotool windowraise ' . xwin_id)
  endif
endfunction

let g:vimtex_view_method = 'zathura'
augroup vimtex_event_1
au!
au User VimtexEventView     call VimtexHookZathura()
augroup END
" let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_indent_enabled=1

let g:tex_flavor = "latex"
autocmd Filetype tex inoremap <buffer> $ $$<esc>i

" Options for vim-latex-live-preview
" let g:livepreview_previewer = 'zathura'
" let g:livepreview_engine = 'latexmk -pdf'

" Options for python-mode
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0

" Options for markdown-folding
let g:markdown_fold_style = 'nested'

" Options for searching
let g:ctrlsf_default_view_mode = 'normal'
let g:ctrlsf_default_root = 'cwd'
vmap <C-F> <Plug>CtrlSFVwordExec
nmap <C-F> <Plug>CtrlSFPrompt
map <Leader>t :FZF<CR>

" Options for searching
let g:NERDTreeChDirMode = 2
nmap <C-g> :NERDTreeFind<CR>

"Options for terminal mode/neoterm
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>
let g:neoterm_default_mod='botright'
nnoremap <C-t> :Ttoggle<CR><C-\><C-n>
inoremap <C-t> <ESC>:Ttoggle<CR><C-\><C-n>
tnoremap <C-t> <C-\><C-n>:Ttoggle<CR>


"Options for tags
nmap <F8> :TagbarToggle<CR>

" Options for ALE
let g:ale_fixers = {'python': ['black', 'isort']}
let g:ale_linters = {'python': ['flake8'], 'yaml': ['yamllint']}
let g:ale_fix_on_save = 1
let g:ale_python_black_executable='/home/stannis/black/venv3/bin/black'
let ale_python_black_options='-S --fast'
let g:ale_python_isort_executable='/home/stannis/black/venv3/bin/isort'
let g:ale_python_flake8_executable='/home/stannis/ros_ws_py3/src/real_world/py3_venv/bin/flake8'
let g:ale_python_flake8_options='--ignore=E501,W503,E203'
let g:ale_python_mypy_executable='/home/stannis/ros_ws_py3/src/real_world/py3_venv/bin/mypy'
let g:ale_yaml_yamllint_executable='/home/stannis/miniconda3/bin/yamllint'
let g:ale_yaml_yamllint_options='-d relaxed'

" Options for editing YAML files
autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
