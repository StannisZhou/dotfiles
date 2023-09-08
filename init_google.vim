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
Plug 'windwp/nvim-autopairs'
Plug 'scrooloose/nerdtree'
Plug 'phaazon/hop.nvim'
Plug 'tmhedberg/matchit'
Plug 'scrooloose/nerdcommenter'
Plug 'danro/rename.vim'
Plug 'xolox/vim-notes'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tmhedberg/SimpylFold'
" Plug 'Konfekt/FastFold'
Plug 'preservim/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'dense-analysis/ale'
Plug 'nvim-lua/plenary.nvim'           " lua helpers
Plug 'nvim-telescope/telescope.nvim'   " actual plugin
Plug 'kyazdani42/nvim-web-devicons'  " nvim devicons
Plug 'sso://user/vintharas/telescope-codesearch.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sso://googler@user/ycyi/coc-ciderlsp'
Plug 'mhinz/vim-signify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'goerz/jupytext.vim'
Plug 'yaegassy/coc-pydocstring', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()' , 'for': 'markdown'}
Plug 'smartpde/telescope-recent-files'
Plug 'sso://team/neovim-dev/neocitc'
Plug 'ludovicchabant/vim-lawrencium'
Plug 'sso://user/tylersaunders/telescope-fig.nvim'
Plug 'sso://user/stannis/nvim-figtree'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'romgrk/barbar.nvim'
Plug 'stevearc/aerial.nvim'
Plug 'equalsraf/neovim-gui-shim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
" Initialize plugin system
call plug#end()

" Set up clipboard
if has("gui_running")
  call GuiClipboard()
endif
" Enable modern Vim features not compatible with Vi spec.
set nocompatible

" use » to mark Tabs and ° to mark trailing whitespace. This is a
" non-obtrusive way to mark these special characters.
set list listchars=tab:»\ ,trail:°

" Use the 'google' package by default (see http://go/vim/packages).
source /usr/share/vim/google/google.vim

" Load Critique integration. Use :h critique for more details.
Glug critique plugin[mappings]

" Load blaze integration (http://go/blazevim).
Glug blaze plugin[mappings]
Glug blazedeps

Glug outline-window
Glug relatedfiles

filetype plugin indent on
syntax on

let g:python3_host_prog='/usr/local/google/home/stannis/miniconda3/bin/python'

let mapleader=","
nmap <silent> <leader>ov :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
set nocompatible

set termguicolors     " enable true colors support
set nobackup
set noswapfile
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set guifont=Monaco:h16

" Options for wrapping
autocmd FileType * setlocal wrap linebreak nolist textwidth=0 wrapmargin=0

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

" Some customized mappings
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <Leader>q :close<CR>

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

" Options for EasyMotion
" let g:EasyMotion_leader_key = '<leader>'
" nmap <Leader>b <Plug>(easymotion-b)

" Options for hop.nvim
nmap <leader>w :HopWord<CR>

" Options for NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-c> :NERDTree<CR>

"Shortcuts for dealing with parathesis/brackets
inoremap <C-e> <Esc>$a
inoremap <A-k> <C-o>h
inoremap <A-l> <C-o>l

"Shrotcuts for maximizing buffers
nmap tt :tab split<CR>

" Options for NERDCommenter
let NERDSpaceDelims=1

" Options for navigating CitC
command! -nargs=1 G4d cd /google/src/cloud/$USER/<args>/google3

" Options for vim-notes
let g:notes_directories = ['~/DriveFileStream/My Drive/Dropbox/vim_notes/notes']
let g:notes_suffix = '.txt'
let g:notes_title_sync = 'change_title'
autocmd FileType notes setlocal nospell tabstop=3 shiftwidth=3 softtabstop=3 expandtab
nnoremap <Leader>i :Note scratch_2023<CR>
nnoremap <leader>gt :e <cfile><cr>

" Shortcuts for inserting date and time
nnoremap <Leader>dt "=strftime("## %a %x %X %Z:")<CR>Po<CR><TAB>
nnoremap <Leader>dm "=strftime("~/DriveFileStream/My\\ Drive/Dropbox/vim_notes/math_notes/math_%b_%d_%Y.md")<CR>pF.

" Options for SympylFold
" let g:SimpylFold_docstring_level = 3

" Options for FastFold
" let g:fastfold_savehook = 1
" let g:fastfold_fdmhook = 0
" nmap zuz <Plug>(FastFoldUpdate)
" let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
" let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
" let foldlevel = 0

" Options for markdown-folding
let g:markdown_fold_style = 'nested'

" Options for searching
let g:NERDTreeChDirMode = 3
nmap <C-g> :NERDTreeToggle %<CR>

" Options for ALE
" By default, ale attempts to traverse up the file directory to find a
" virtualenv installation. This can cause high latency (~15s) in citc clients
" when opening Python files. Setting the following flag to `1` disables that.
let g:ale_use_global_executables = 1
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
let g:ale_sign_column_always = 1
augroup ALEProgress
    autocmd!
    autocmd User ALEFixPost checktime
augroup END
function! PyFormat(buffer) abort
  return {'command': '/usr/bin/pyformat'}
endfunction
function! Pyfactor(buffer) abort
  return {'command': '/google/data/ro/teams/youtube-code-health/pyfactor fix_imports --noremove_unused ' . bufname(a:buffer) . ' > /tmp/pyfactor.output'}
endfunction
execute ale#fix#registry#Add('pyformat', 'PyFormat', ['python'], 'pyformat for python')
execute ale#fix#registry#Add('pyfactor', 'Pyfactor', ['python'], 'Fix import order for python')
let g:ale_fixers = {'python': ['pyformat', 'pyfactor'], 'bzl': ['buildifier']}
let g:ale_linters = {'python': ['gpylint']}
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

" Options for lawrencium
let g:lawrencium_status_win_split_above = 1
let g:lawrencium_status_win_split_even = 1

" Options for jupytext
let g:jupytext_command = '/usr/local/google/home/stannis/miniconda3/bin/jupytext --opt notebook_metadata_filter="-all" --opt cell_metadata_filter="-all"'
let g:jupytext_enable = 1
let g:jupytext_fmt = 'py:percent'
nnoremap <Leader>ce :let a='# %%'\|put=a<CR>
nnoremap <Leader>nn :!cp /google/src/cloud/stannis/temp/google3/experimental/deepmind/stannis/notebooks/empty.ipynb %:p:h<CR>

" Options for markdown preview
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = '127.0.0.1'
let g:mkdp_port = 8080
function! g:CopyUrl(url)
    :call GuiClipboard()
    :let @+=a:url
    :echo "Copied markdown preview URL " . a:url . " to clipboard"
endfunction
let g:mkdp_browserfunc = 'g:CopyUrl'

" Copy codesearch link to current file to clipboard
map <Leader>oc :let @+='http://cs/?q=f:' . substitute(expand('%:p'), '/google/src/cloud/[a-zA-Z0-9-]*/[a-zA-Z0-9-]*/', '', '')<CR>:echo "Copied codesearch link to clipboard"<CR>
map <Leader>co :let @+='https://colab.corp.google.com' . substitute(expand('%:p'), '/google/src', '/google_src', '')<CR>:echo "Copied colab link to clipboard"<CR>
map <Leader>cp :call GuiClipboard()<CR>:let @+='cd ' . expand('%:p:h')<CR>:echo "Copied current directory to clipboard"<CR>


" Options for figtree
nnoremap <silent> <Leader>ft :Figtree<CR>

" Options for coc-pydocstring
call coc#config('pydocstring.doqPath', '/usr/local/google/home/stannis/miniconda3/bin/doq')
call coc#config('pydocstring.formatter', 'google')
call coc#config('pydocstring.templatePath', '/usr/local/google/home/stannis/DriveFileStream/My Drive/Dropbox/pydocstring_templates')
call coc#config('pydocstring.enableInstallPrompt', v:false)
nmap <silent> ga <Plug>(coc-codeaction-line)
xmap <silent> ga <Plug>(coc-codeaction-selected)
nmap <silent> gA <Plug>(coc-codeaction)

" Options for coc

" GoTo code navigation
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

call coc#config('suggest.noselect', v:true)
call coc#config('diagnostic.displayByAle', v:true)
let g:coc_user_config = {
  \ 'languageserver': {
  \   'ciderlsp': {
  \     'command': '/google/bin/releases/cider/ciderlsp/ciderlsp',
  \     'args': [
  \       '--tooltag=coc-nvim',
  \       '--noforward_sync_responses'
  \     ],
  \     'filetypes': [
  \       'borg',
  \       'c',
  \       'cpp',
  \       'go',
  \       'java',
  \       'kotlin',
  \       'proto',
  \       'python',
  \       'textproto',
  \     ]
  \   }
  \ }
  \}
call coc#config('coc-ciderlsp.filetypes', [
  \                 "cpp",
  \                 "python",
  \                 "borg",
  \                 "go",
  \                 "java",
  \                 "proto",
  \                 "bzl",
  \                 "javascript",
  \                 "typescript",
  \                 "gcl",
  \                 "textproto"
  \         ])
call coc#config('coc-ciderlsp.args', [
  \                 "--tooltag=coc-nvim",
  \                 "--noforward_sync_responses"
  \         ])
call coc#config('coc-ciderlsp.enabled', v:true)
call coc#config('coc-ciderlsp.compose.enabled', v:true)

" Options for telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
highlight NormalFloat ctermfg=LightGrey

" Options for nvim-treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

:lua << EOF
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Options for telescope
require('telescope').setup()
require('telescope').load_extension('fzf')
require('telescope').load_extension('recent_files')

-- Options for telescope codersearch
require('telescope').setup {
  defaults =  {
    -- The vertical layout strategy is good to handle long paths like those in
    -- google3 repos because you have nearly the full screen to display a file path.
    -- The caveat is that the preview area is smaller.
    layout_strategy = 'vertical',
    -- Common paths in google3 repos are collapsed following the example of Cider
    -- It is nice to keep this as a user config rather than part of
    -- telescope-codesearch because it can be reused by other telescope pickers.
    path_display = function(opts, path)
      -- Do common substitutions
      path = path:gsub("^/google/src/cloud/", "", 1)
      path = path:gsub("^google3/java/com/google/", "g3/j/c/g/", 1)
      path = path:gsub("^google3/javatests/com/google/", "g3/jt/c/g/", 1)
      path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
      path = path:gsub("^google3/", "g3/", 1)

      -- Do truncation. This allows us to combine our custom display formatter
      -- with the built-in truncation.
      -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
      -- Here we are manually propagating this value between new_opts and opts.
      -- We can make this cleaner and more complicated using metatables :)
      local new_opts = {
        path_display = {
          truncate = true,
        },
        __length = opts.__length,
      }
      path = require('telescope.utils').transform_path(new_opts, path)
      opts.__length = new_opts.__length
      return path
    end,
  },
  extensions = { -- this block is optional, and if omitted, defaults will be used
    codesearch = {
      experimental = true           -- enable results from google3/experimental
    },
    recent_files = {
      stat_files = true,
    }
  }
}

-- These custom mappings let you open telescope-codesearch quickly:
-- Search using codesearch queries.
vim.api.nvim_set_keymap('n', '<leader>ss',
  [[<cmd>lua require('telescope').extensions.codesearch.find_query{add_workspace=true, default_text="f:learning f:deepmind "}<CR>]],
  { noremap = true, silent=true }
)
vim.api.nvim_set_keymap('n', '<leader>st',
  [[<cmd>lua require('telescope').extensions.codesearch.find_query{add_workspace=true, default_text="f:third_party "}<CR>]],
  { noremap = true, silent=true }
)
vim.api.nvim_set_keymap('n', '<leader>se',
  [[<cmd>lua require('telescope').extensions.codesearch.find_query{default_text="f:experimental "}<CR>]],
  { noremap = true, silent=true }
)

-- Search for the word under cursor.
vim.api.nvim_set_keymap('n', '<leader>sS',
[[<cmd>lua require('telescope').extensions.codesearch.find_query{default_text_expand='f:learning f:deepmind <cword>'}<CR>]],
{ noremap = true, silent=true }
)

-- Search for text selected in Visual mode.
vim.api.nvim_set_keymap('v', '<leader>ss',
[[<cmd>lua require('telescope').extensions.codesearch.find_query{default_text="f:learning f:deepmind "}<CR>]],
{ noremap = true, silent=true }
)
vim.api.nvim_set_keymap("n", "<leader>sr",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true})

-- [F]ig [S]tatus
vim.api.nvim_set_keymap('n', '<leader>fs',
  [[<cmd>lua require('telescope').extensions.fig.status{}<CR>]],
  { noremap = true, silent=true }
)

-- [F]ig [X]l
vim.api.nvim_set_keymap('n', '<leader>fx',
  [[<cmd>lua require('telescope').extensions.fig.xl{}<CR>]],
  { noremap = true, silent=true }
)
-- Options for neocitc
require("neocitc").setup({})

vim.api.nvim_set_keymap("n", "<Leader>fw",
  [[<cmd>lua require('neocitc').pick_workspace()<CR>]],
  {noremap = true, silent=true})

-- Options for toggleterm.nvim
require("toggleterm").setup({
  open_mapping = [[<c-t>]],
  autochdir = true,
  start_in_insert = false,
})

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

-- Options for nvim-autopairs
require("nvim-autopairs").setup {}

-- Options for aerial.nvim
require('aerial').setup({
  layout = {
      -- These control the width of the aerial window.
      -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a list of mixed types.
      -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
      max_width = { 80, 0.4 },
      width = nil,
      min_width = 10,

      -- key-value pairs of window-local options for aerial window (e.g. winhl)
      win_opts = {},

      -- Determines the default direction to open the aerial window. The 'prefer'
      -- options will open the window in the other direction *if* there is a
      -- different buffer in the way of the preferred direction
      -- Enum: prefer_right, prefer_left, right, left, float
      default_direction = "prefer_left",

      -- Determines where the aerial window will be opened
      --   edge   - open aerial at the far right/left of the editor
      --   window - open aerial to the right/left of the current window
      placement = "window",

      -- Preserve window size equality with (:help CTRL-W_=)
      preserve_equality = false,
    },
})
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')

-- Options for coc-nvim
-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")


-- Options for nvim-ufo
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

local ftMap = {
    vim = 'indent',
    python = {'treesitter', 'indent'},
    git = ''
}
require('ufo').setup({
  open_fold_hl_timeout=0,
  provider_selector = function(bufnr, filetype, buftype)
    return ftMap[filetype]
  end,
  preview = {
    win_config = {
      border = {'', '─', '', '', '', '─', '', ''},
      winhighlight = 'Normal:Folded',
      winblend = 0
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>',
      jumpTop = '[',
      jumpBot = ']'
    }
  },
})
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.fn.CocActionAsync('definitionHover') -- coc.nvim
    end
end)
EOF
