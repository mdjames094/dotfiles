autocmd bufwritepost .vimrc source %


" Vundle Plugins {{{
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize (:PluginInstall).
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-commentary'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'cjrh/vim-conda'

Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'

Plugin 'iamcco/markdown-preview.nvim'
Plugin 'vimwiki/vimwiki'

"Plugin 'valloric/youcompleteme'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'kien/ctrlp.vim'
"Plugin 'ap/vim-buftabline'
"Plugin 'mattn/emmet-vim'
"Plugin 'Chiel92/vim-autoformat'
"Plugin 'aklt/plantuml-syntax'
"Plugin 'weirongxu/plantuml-previewer.vim'
"Plugin 'tyru/open-browser.vim'
"Plugin 'Yggdroot/indentLine'
"Plugin 'jpalardy/vim-slime'
"Plugin 'hanschen/vim-ipython-cell'
"Plugin 'goerz/jupytext.vim'
"Plugin 'tpope/vim-surround'
"Plugin 'christoomey/vim-system-copy'
"Plugin 'ReplaceWithRegister'
"Plugin 'majutsushi/tagbar'
"Plugin 'lepture/vim-jinja'
"Plugin 'pangloss/vim-javascript'

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
set path+=.,,**        " Seach down into subfolders. Provides tab-completion for all file-related tasks
set showcmd            " Show command in bottom bar
set wildmenu           " Visual autocomplete for command menu
set lazyredraw         " Redraw only when we need to
set showmatch          " Show matching part if the pairs for [] {} and ()
set ruler              " Show cursor x, y coordinates
set cursorline         " Show cursorline
set foldenable         " Enable folding
set showmatch          " Show matching part if the pairs for [] {} and ()
set showmode
set backspace=indent,eol,start
set scrolloff=7        " 999 to keep cursor line in middle of screen
set expandtab          " Prefer spaces over tabs
set shiftwidth=2       " Indentation defaults (<< / >> / == / auto)
set shiftround         " Snap indents via > or < to multiples of sw

set noswapfile
set backup
set nowritebackup

set backupdir=/tmp

au FileType javascript,html,css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent smartindent

au FileType vim setlocal foldmethod=marker

au FileType py setlocal foldmethod=indent

" avoid extraneous whitespace
au BufWritePre *.{php,py,c,h,js,txt,hs,java,md} :call <SID>StripTrailingWhitespaces()

" Set status line display
set laststatus=2

" Always display the tabline, even if there is only one tab
set showtabline=2

" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

set encoding=utf8

" set timeoutlen=150

" make y and p copy and paste to the global buffer used by other apps
set clipboard+=unnamed

" allow buffer change without saving
set hidden

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"}}}


" Plugin parameters {{{

" change indent char - display lines
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char_list = ['|']

" suppress message vim-conda environment information on vim startup
let g:conda_startup_msg_suppress = 1

" ensures that the auto-complete window goes away when done
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_complete_in_strings = 1
let g:ycm_filetype_whitelist = { "c":1, "cpp":1, "objc":1, "sh":1, "zsh":1, "zimbu":1, "python":1, }

" shortcuts for navigating to definitions using YouCompleteMe
map <Esc>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" open definition in new vertical split
map <Esc>gs :vsp <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
" open definition in new tab
map <Esc>gt :tab split<CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>

" file browser, NERDTree
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\~$']
let NERDTreeHijackNetrw = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let g:NERDSpaceDelims = 1
let g:nerdtree_open = 0

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

" markdown
let g:mkdp_refresh_slow = 1
let g:mkdp_browser = ''

let g:vimwiki_list = [{'path': '~/Documents/dotfiles/backup/Notes_wiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

"}}}


" Binding keys {{{

" Map <leader> key to space
let mapleader = '!'

" toggle pastemode
" nnoremap <F2> :set invpaste paste?<CR>
" set pastetoggle=<F2>

" Map F3 and F4 to toggle on an off the line and relative line numbers in Normal mode
" nmap <F3> :set nu!
" nmap <F4> :set rnu!

" Vimux commands
" nmap <F5> :call VimuxRunCommand("clear; python3 " . expand("%:p"))<CR><CR>
autocmd FileType python nnoremap <buffer> <Esc>( :call VimuxRunCommand("clear; python3 " . expand("%:p"))<CR><CR>
autocmd FileType python inoremap <buffer> <Esc>( <C-o>:call VimuxRunCommand("clear; python3 " . expand("%:p"))<CR><CR>

" Save and run script
autocmd FileType python nnoremap <buffer> <Esc>- :w<CR>:IPythonCellRun<CR>
autocmd FileType python inoremap <buffer> <Esc>- <C-o>:w<CR><C-o>:IPythonCellRun<CR>

" Evaluate current cell without saving
" autocmd FileType python nnoremap <buffer> <F7> :IPythonCellExecuteCell<CR>
" autocmd FileType python inoremap <buffer> <F7> <C-o>:IPythonCellExecuteCell<CR>
autocmd FileType python nmap <buffer> <Esc>è :SlimeSendCurrentLine<CR>:<C-u>call search('^.\+')<CR>
autocmd FileType python xmap <buffer> <Esc>è <Plug>SlimeRegionSend<Esc>`>a<ESC>gjg0

" Evaluate current cell and jump to next cell without saving
autocmd FileType python nnoremap <buffer> <Esc>_ :IPythonCellExecuteCellJump<CR>
autocmd FileType python inoremap <buffer> <Esc>_ <C-o>:IPythonCellExecuteCellJump<CR>

" Reset ipython
autocmd FileType python nnoremap <buffer> <Esc>à :call slime#send("exit\n")<CR>:call slime#send("clear\n")<CR>:call slime#send("ipython\n")<CR>
autocmd FileType python inoremap <buffer> <Esc>à <ESC>:call slime#send("exit\n")<CR>:call slime#send("clear\n")<CR>:call slime#send("ipython\n")<CR>

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

nnoremap <Esc>- :split <CR>
nnoremap <Esc>_ :vsplit <CR>

nnoremap <Esc>q :q <CR>
inoremap <Esc>q :q <CR>

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

" Reassign arrow keys to No Operation
no <Down>	<Nop>
no <Left>	<Nop>
no <Right>	<Nop>
ino <Up>	<Nop>
ino <Down>	<Nop>
ino <Left>	<Nop>
ino <Right>	<Nop>
ino <Up>	<Nop>
vno <Down>	<Nop>
vno <Left>	<Nop>
vno <Right>	<Nop>
vno <Up>	<Nop>

" resize current buffer by +/- 5 
nmap <Tab>h :vertical resize -5<cr>
nmap <Tab>j :resize +5<cr>
nmap <Tab>k :resize -5<cr>
nmap <Tab>l :vertical resize +5<cr>

" Disable mouse interactions
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set ttymouse-=a

nmap <Esc>t :TagbarToggle<CR>

" indent/unindent with tab/shift-tab
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv

"}}}


" Functions {{{
" Select the font for the hardcopy
set printfont=Courier:h8
command! -range=% Hardcopypdf <line1>,<line2> hardcopy > %.ps | !ps2pdf %.ps && rm %.ps && lpr %.pdf && echo 'Printed %.pdf'

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

" File browser
function! ToggleNERDTree()
	NERDTreeToggle
	silent NERDTreeMirror
endfunction

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"}}}


