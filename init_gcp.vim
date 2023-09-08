" Auto-install install Plug if it does not exist
" source: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()' , 'for': 'markdown'}
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'phaazon/hop.nvim'
Plug 'tmhedberg/matchit'
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
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
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
Plug 'SirVer/ultisnips'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'  " nvim devicons
Plug 'equalsraf/neovim-gui-shim'
" Initialize plugin system
call plug#end()

let g:python3_host_prog='/opt/conda/bin/python'

let mapleader=","
nmap <silent> <leader>ov :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
set nocompatible

set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
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
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Gui options
set guifont=Monaco:h18
" Some customized mappings
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <Leader>q :close<CR>
" Automatically fix indentation
nnoremap <Leader>= mqgg<S-v>G=`q:delm q<CR>

"Options for barbar
nnoremap <Leader>m :BufferClose<CR>
nnoremap <C-p> :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l


" Options for SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Options for EasyMotion
" let g:EasyMotion_leader_key = '<leader>'
" nmap <Leader>b <Plug>(easymotion-b)

" Options for hop.nvim
nmap <leader>w :HopWord<CR>

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
" nnoremap <Leader>gt :silent !/usr/local/bin/texmacs <cfile> &<CR>
nnoremap <leader>gt :e <cfile><cr>

" Shortcuts for inserting date and time
nnoremap <Leader>dt "=strftime("## %a %x %X %Z:")<CR>Po<CR><TAB>
nnoremap <Leader>dm "=strftime("~/Dropbox/vim_notes/math_notes/math_%b_%d_%Y.tex")<CR>pF.

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
let g:pydocstring_formatter = 'google'
nmap <leader>doc :Pydocstring<CR>
let g:pydocstring_doq_path='/opt/conda/bin/doq'

" Options for vimtex
let maplocalleader=','
let g:vimtex_fold_enabled=1
let g:vimtex_view_automatic=1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:vimtex_indent_enabled=1
let g:tex_flavor = "latex"
let g:vimtex_quickfix_mode=0

function! VimtexHookZathura() abort
  let xwin_id = get(b:vimtex.viewer, 'xwin_id')
  if xwin_id > 0
    silent call system('xdotool windowactivate ' . xwin_id . ' --sync')
    silent call system('xdotool windowraise ' . xwin_id)
  endif
endfunction

augroup vimtex_event_1
au!
au User VimtexEventView     call VimtexHookZathura()
augroup END


" Options for python-mode
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
autocmd FileType python set shiftwidth=2 tabstop=2 expandtab
let g:python_recommended_style = 0

" Options for markdown-folding
let g:markdown_fold_style = 'nested'

" Options for searching
let g:ctrlsf_default_view_mode = 'normal'
let g:ctrlsf_default_root = 'cwd'
let g:ctrlsf_backend = 'rg'
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
let g:ale_python_black_executable='/opt/conda/bin/pyink'
let ale_python_black_options='-S --fast --pyink-indentation 2 --pyink-use-majority-quotes'
let g:ale_python_isort_executable='/opt/conda/bin/isort'
let g:ale_python_flake8_executable='/opt/conda/bin/flake8'
let g:ale_python_flake8_options='--ignore=E501,W503,E203,E111,E114'
let g:ale_python_mypy_executable='/opt/conda/mypy'
let g:ale_yaml_yamllint_executable='/opt/conda/bin/yamllint'
let g:ale_yaml_yamllint_options='-d relaxed'

" Options for editing YAML files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Options for UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<C-l>'
let g:UltiSnipsSnippetDirectories = ['/Users/stannis/My Drive/Dropbox/snippets/']

" Options for copilot
let g:copilot_filetypes = {'notes': v:false}

" Options for markdown preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_browser = 'safari'


:lua << EOF
-- Options for hop.nvim
local hop = require('hop')
hop.setup()
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})

EOF
