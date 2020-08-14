autocmd bufwritepost .vimrc source %


" Vundle Plugins {{{
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize (:PluginInstall).
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'valloric/youcompleteme'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'cjrh/vim-conda'
Plugin 'mattn/emmet-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-commentary'
Plugin 'Chiel92/vim-autoformat'
Plugin 'aklt/plantuml-syntax'
Plugin 'weirongxu/plantuml-previewer.vim'
Plugin 'tyru/open-browser.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'jpalardy/vim-slime'
Plugin 'hanschen/vim-ipython-cell'
Plugin 'goerz/jupytext.vim'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-system-copy'
Plugin 'ReplaceWithRegister'

call vundle#end()            
" }}}


" Editor settings {{{

filetype plugin on
filetype plugin indent on

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

syntax enable
highlight Normal ctermbg=black
set nu
"set rnu               " Show relative numbers
set nowrap
set splitbelow
set encoding=utf-8
set path+=**           " Seach down into subfolders. Provides tab-completion for all file-related tasks
set showcmd            " Show command in bottom bar
set wildmenu           " Visual autocomplete for command menu
set lazyredraw         " Redraw only when we need to
set showmatch          " Show matching part if the pairs for [] {} and ()
set ruler              " Show cursor x, y coordinates
set cursorline         " Show cursorline
set foldenable         " Enable folding
set showmatch          " Show matching part if the pairs for [] {} and ()
set showmode

set noswapfile
set backup
set nowritebackup

set backupdir=/tmp

au FileType javascript,html,css setlocal tabstop=2 softtabstop=2 shiftwidth=2

au FileType vim setlocal foldmethod=marker

au FileType py setlocal foldmethod=indent

" avoid extraneous whitespace
au BufWritePre *.{php,py,c,h,js,txt,hs,java,md} :call <SID>StripTrailingWhitespaces()

" Set status line display
set laststatus=2

set encoding=utf8

" set timeoutlen=150

set hidden

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
"}}}


" Plugin parameters {{{

" ensures that the auto-complete window goes away when done
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_complete_in_strings = 1
let g:ycm_filetype_whitelist = { "c":1, "cpp":1, "objc":1, "sh":1, "zsh":1, "zimbu":1, "python":1, }

" change indent char - display lines
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char_list = ['|']

" shortcut for goto definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" hide .pyc files in NERDTree
let NERDTreeIgnore = ['\.pyc$', '\~$']
let NERDTreeHijackNetrw = 1
let NERDTreeShowHidden = 1
let g:NERDSpaceDelims = 1

" suppress message vim-conda environment information on vim startup
let g:conda_startup_msg_suppress = 1

" always send text to the top-right pane in the current tmux tab without " asking
let g:slime_target = "tmux"
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1
let g:ipython_cell_delimit_cells_by = 'tags'
let g:slime_no_mappings = 1

" jupytext
let g:jupytext_fmt = 'py'
" let g:jupytext_filetype_map = {'py': 'python'}

" set surf browser for Plantuml preview
" let g:openbrowser_browser_commands = [{'name': 'surf', 'args': ['surf', '{use_vimproc ? uri : uri_noesc}']}]

"}}}


" Binding keys {{{

" Map <leader> key to space
let mapleader = '!'

" toggle pastemode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Map F3 and F4 to toggle on an off the line and relative line numbers in Normal mode
" nmap <F3> :set nu!
" nmap <F4> :set rnu!

" Vimux commands
nmap <F5> :call VimuxRunCommand("clear; python3 " . expand("%:p"))<CR><CR>


" Save and run script
autocmd FileType python nnoremap <buffer> <F6> :w<CR>:IPythonCellRun<CR>
autocmd FileType python inoremap <buffer> <F6> <C-o>:w<CR><C-o>:IPythonCellRun<CR>

" Evaluate current cell without saving
" autocmd FileType python nnoremap <buffer> <F7> :IPythonCellExecuteCell<CR>
" autocmd FileType python inoremap <buffer> <F7> <C-o>:IPythonCellExecuteCell<CR>
autocmd FileType python nmap <buffer> <F7> :SlimeSendCurrentLine<CR>:<C-u>call search('^.\+')<CR>
autocmd FileType python xmap <buffer> <F7> <Plug>SlimeRegionSend<Esc>`>a<ESC>gjg0

" Evaluate current cell and jump to next cell without saving
autocmd FileType python nnoremap <buffer> <F8> :IPythonCellExecuteCellJump<CR>
autocmd FileType python inoremap <buffer> <F8> <C-o>:IPythonCellExecuteCellJump<CR>

" Vim Autoformat
noremap <F9> :Autoformat<CR>

" Vim Plantuml
nmap <F12> :PlantumlOpen<CR>
vmap <F12> :PlantumlOpen<CR>

" Enable folding with the spacebar
nnoremap <space> za

" Assign Ctrl n & p to buffer changing
nnoremap <Esc>n :bNext <CR>
nnoremap <Esc>p :bprevious <CR>

" Quick pairs
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i

" Tab mapping
nmap <leader><Tab> :tabnext<CR>
nmap <leader><S-Tab> :tabprevious<CR>
map <leader><Tab> :tabnext<CR>
map <leader><S-Tab> :tabprevious<CR>
imap <leader><Tab> :tabnext<CR>
imap <leader><S-Tab> :tabprevious<CR>
noremap <F7> :set expandtab!<CR>
nmap <Leader>h :tabnew %:h<CR>

" Quick save command
nnoremap <Esc>x :update<CR>
inoremap <Esc>x <ESC>:update<CR>
vnoremap <Esc>x <ESC>:update<CR>

" Quick quit command
nnoremap <Esc>c :q<CR>
inoremap <Esc>c <ESC>:q<CR>
vnoremap <Esc>c <ESC>:q<CR>

" IPython navigate cell
" nnoremap <Esc><F7> :IPythonCellPrevCell <CR>
" nnoremap <Esc><F8> :IPythonCellNextCell <CR>

" Map Direction to change panes
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j

nnoremap <silent> <Esc>h :TmuxNavigateLeft<cr>
nnoremap <silent> <Esc>j :TmuxNavigateDown<cr>
nnoremap <silent> <Esc>k :TmuxNavigateUp<cr>
nnoremap <silent> <Esc>l :TmuxNavigateRight<cr>

" Quick save command
nnoremap <Esc>f :call ToggleNERDTree()<CR>
inoremap <Esc>f <ESC>:call ToggleNERDTree()<<CR>
vnoremap <Esc>f <ESC>:call ToggleNERDTree()<<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <Esc>o o<Esc>
nnoremap <Esc>O O<Esc>

" Vim Commentary
noremap <Esc>c :Commentary<CR>

" Move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" resize current buffer by +/- 5 
nmap <left> :vertical resize -5<cr>
nmap <down> :resize +5<cr>
nmap <up> :resize -5<cr>
nmap <right> :vertical resize +5<cr>

" Reassign arrow keys to No Operation
no <down>	<Nop>
no <left>	<Nop>
no <right>	<Nop>
ino <up>		<Nop>
ino <down>	<Nop>
ino <left>	<Nop>
ino <right>	<Nop>
ino <up>	<Nop>
vno <down>	<Nop>
vno <left>	<Nop>
vno <right>	<Nop>
vno <up>	<Nop>

" Disable mouse interactions
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set ttymouse-=a

"}}}


" Functions {{{

function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

"
function! ToggleNERDTree()
	NERDTreeToggle
	silent NERDTreeMirror
endfunction
"}}}

