" Liam Cain
" .vimrc

syntax on
set nocompatible

"Required for fish and vim to play together
if $SHELL =~ 'bin/fish'
	set shell=/bin/sh
endif

filetype plugin indent off
filetype indent off

" Basics {{{ "
set nohlsearch
set incsearch
set modelines=0
set expandtab
set tabstop=4
set history=1000
set wrap
set linebreak
set shiftwidth=4
set encoding=utf-8
set scrolloff=3
set cpoptions+=cpo-$
set autoindent
set noshowmode
set showcmd
set hidden
set wildmenu
set cursorline
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set ttimeout
set ttimeoutlen=100
set number
let mapleader = " "
let localleader="\\"
set ignorecase
set smartcase
set smarttab
set formatoptions+=j
set formatoptions-=cro
set foldmethod=marker
set foldcolumn=0
set wildignore+=*/tmp/*,*.so,*.pyc,*pdf,*docx,*.swp,*.zip,*.indd,*.psd,*mp3,*.png,*jpg
set wildignore+=$HOME./Library/*
let g:netrw_list_hide =  '\.png$,\.jpg$,\.png$'
set virtualedit=block
" }}} Basics "
" Extras {{{ "
" Resize splits when the window is resized
au VimResized * :wincmd =
set splitbelow
set splitright
set spelllang=en_us
set spellfile=$HOME/.vim/spell/en.utf-8.add
autocmd BufRead,BufNewFile *.md setlocal spell
au BufRead,BufNewFile *.md set filetype=pandoc
au BufEnter * silent! lcd %:p:h
" }}} Extras "
" Appearance {{{ "
set guioptions-=r
set guifont=Fira\ Mono:h14
set linespace=2
colorscheme iceberg
" colorscheme gotham
" }}} Appearance "
" Backups {{{1 "
set undofile
set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
" 1}}} "
" Plugins {{{1 "
call plug#begin()
" TPope {{{2 "
Plug 'tpope/vim-fugitive'        " for git in status bar
Plug 'tpope/vim-surround'        " add motions to add/change/remove quotes and braces
Plug 'tpope/vim-commentary'      " gcc
Plug 'tpope/vim-unimpaired'      " add [ movements
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'         " makes netrw a lot better
" 1}}} "
Plug 'SirVer/ultisnips'          " SNIPPETS
Plug 'honza/vim-snippets'        " the snippets themselves
Plug 'osyo-manga/vim-over'       " Visual find/replace %s
Plug 'shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/syntastic'      " error highlighting
" Plug 'mattn/emmet-vim'         " for html/css
Plug 'ajh17/VimCompletesMe'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'bling/vim-airline'         " those pretty bars at top and bottom
Plug 'junegunn/goyo.vim'         " For distraction-free writing
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'   " Press enter in visual mode...Magic
"Plug 'sheerun/vim-polyglot'      " language pack
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'fmoralesc/vim-pad'
Plug 'simnalamburt/vim-mundo'
Plug 'airblade/vim-gitgutter'    " Adds the symbols to the sidebar for git stuff
" Plug 'suan/vim-instant-markdown' " Preview .md in browser
Plug 'troydm/zoomwintab.vim'     " Press ` to toggle zoom
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'reedes/vim-colors-pencil'
Plug 'chrisbra/Colorizer'
call plug#end()
" 2}}} "
" Mappings {{{ "
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
inoremap <Down> <C-o>gj
inoremap <Up>   <C-o>gk

" Better home/end keys - synonymous to normal movement
nnoremap H ^
nnoremap L $
nnoremap ; :
nnoremap : ;
nnoremap Y y$
inoremap jk <ESC>
inoremap kj <ESC>
nnoremap Q @q

" Uses 'very magic' regex search
nnoremap / /\v
vnoremap / /\v
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
"
" smarter 'Comment', 'String' paste
imap <D-V> ^O"+p

nnoremap <silent> <Space><space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <space><space> zf<F37>

" for when you forget to sudo
cmap w!! w !sudo tee >/dev/null %

" better split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
vnoremap <C-h> <C-w>h
vnoremap <C-j> <C-w>j
vnoremap <C-k> <C-w>k
vnoremap <C-l> <C-w>l
if has('nvim')
  tnoremap <C-j> <c-\><c-n><c-w>j
  tnoremap <C-k> <c-\><c-n><c-w>k
  tnoremap <C-h> <c-\><c-n><c-w>h
  tnoremap <C-l> <c-\><c-n><c-w>l
  au WinEnter *pid:* call feedkeys('i')

  nnoremap <leader>t :term fish<CR>
  tnoremap jk <c-\><c-n> 
  tnoremap kj <c-\><c-n> 
endif
" Mappings}}} "
" Plugins Settings/Mappings {{{ "
" Airline {{{ "
let g:airline_theme='pencil'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#whitespace#enabled=0
" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" }}} Airline "
" Unite {{{2 "
if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup --hidden'
    let g:unite_source_grep_recursive_opt=''
endif
function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <esc> <plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()
let g:unite_prompt='» '
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#profile('default', 'context', {
      \ 'direction': 'top'
      \ })
nnoremap <leader>e :<C-u>Unite -no-split -silent -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>r :<C-u>Unite -no-split -silent -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -silent -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -silent -buffer-name=yank    history/yank<cr>
nnoremap <leader>f :<C-u>Unite -no-split -silent -buffer-name=buffer  buffer<cr>
nnoremap <Leader>/ :<C-u>Unite -no-split -silent -buffer-name=ag grep:.<CR>
" }}} Unite "
" Easy-Align {{{ "
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
let g:easy_align_ignore_groups = []
" }}} Easy-Align "
" Goyo {{{ "
function! s:goyo_enter()
  set linespace=5
  set nocursorline
  colorscheme pencil
  Limelight
endfunction
function! s:goyo_leave()
  set linespace=2
  set cursorline
  colorscheme iceberg
  Limelight!
endfunction
autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()
nnoremap <leader>g :Goyo<CR>
" }}} Goyo "
" Syntastic {{{ "
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
" }}} Syntastic "
" UltiSnips {{{ "
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsEnableSnipMate=0
nnoremap <localleader>e :UltiSnipsEdit<CR>
" }}} UltiSnips "
" Vim-Session {{{2 "
let g:session_autosave='yes'
" Vim-Pad {{{2 "
let g:pad#dir = "~/Documents/Notes/"
let g:pad#local_dir = "notes"
let g:pad#default_format = "pandoc"
let g:pad#window_height = 8
let g:pad#search_backend = "ag"

" Misc Plugins {{{2 "
nnoremap <Leader>u :GundoToggle<CR>
nnoremap ``> :ZoomWinTabToggle<CR>
let g:tex_flavor='latex'
let g:pencil_terminal_italics = 1
let g:pandoc#folding#fdc = 0
" }}} Misc Plugins "
" }}} Plugins Settings/Mappings "
