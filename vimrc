" are we on a mac?
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let isMac = 1
  else
    let isMac = 0
  endif
endif

set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-bundler'
Plugin 'wincent/Command-T'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'vim-scripts/Rename2'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/ZoomWin'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tsaleh/vim-align'
Plugin 'bling/vim-airline'
Plugin 'skalnik/vim-vroom'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
"Plugin 'orchardpie/vim-jshint'
Plugin 'Shougo/neocomplete'
Plugin 'ngmy/vim-rubocop'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let mapleader=","

let g:syntastic_javascript_jshint_conf='~/.jshintrc'

" jshint2.vim
let jshint2_save = 1
let jshint2_close = 1

set modelines=0

set number " line numbers
set ruler
set encoding=utf-8 " Encoding to UTF-8

" Whitespace and syntax stuff
syntax on
color monokai
" set wrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start
set autoindent
set list listchars=tab:\ \ ,trail:·

" misc
set visualbell
set ttyfast
set lazyredraw " buffer screen redraws instead of updating all the time
set shell=/bin/sh
"set mouse=nicr "enable mouse selection and scrolling

set hidden " Allow unsafed buffers
set wildignore+=gems/gems/*,doc/*,tmp/*,vendor/gems/*,.git,*.rbc,*.class,.svn,*.o,*.obj,public/assets/*,*.png,*.log,*.jpg,.bundle
set wildmenu
set wildmode=list:longest
set guifont="Inconsolata-dz for Powerline":h22
set laststatus=2 " always display the status line
set showcmd

" Search
set ignorecase " search case insensitive unless...
set smartcase  " ...search phrase contains a capital letter
set incsearch
set showmatch
set hlsearch " highlight searches and unhighlight search results with <space>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Have sane search regexpes
nnoremap / /\v
vnoremap / /\v

" Movement
" Have screen-line j/k instead of file-line
nnoremap j gj
nnoremap k gk
" use jj in insert mode to go back to normal mode
inoremap jj <ESC>
" Jump between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <S-J> <C-W>j<C-W>_
noremap <S-K> <C-W>k<C-W>_
noremap <S-L> <C-W>l<C-W>_
noremap <S-H> <C-W>h<C-W>_
" make backtick behave like ' for marks
nnoremap ` '

" Filetypes
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
au BufNewFile,BufRead *.json set ft=javascript

if isMac
  " copy stuff to the macs clipboard
  vmap <leader>c "+y
endif

" Mappings
" Opens an edit command with the path of the currently edited file filled in
cnoremap %% <C-R>=expand("%:p:h")."/"<CR>
map <leader>e :e %%
" Switch between current and previous buffer
nnoremap <leader><leader> <c-^>
" Close current Buffer
nnoremap <leader>d :bnext\|bdelete #<CR>
" nnoremap <leader>d :b#<bar>bd#<CR>
" Vim internals
" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set timeoutlen=250  " Time to wait after ESC
set nobackup
set noswapfile

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1
let g:lang_user_options='|| exit 0'

" Plugins

" Command-T
let g:CommandTMaxHeight=20
map <leader>t :CommandTFlush<cr>\|:CommandT<cr>
map <leader>f :CommandT<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>
map <leader>a :CommandT app/assets/javascripts/<cr>
set wildignore+=node_modules/**
set wildignore+=public/map/**
set wildignore+=socket_dealer/node_modules/**
set wildignore+=log/**
set wildignore+=public/system
set wildignore+=public/test*/**
set wildignore+=tmp/**

" YankRing
nnoremap <silent> <leader>z :YRShow<CR>

" Powerline
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1

" Youcompleteme
"let g:ycm_complete_in_comments_and_strings = 1
"let g:ycm_collect_identifiers_from_comments_and_strings = 1

" NeoComplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#max_list = 10
let g:neocomplete#sources#syntax#min_keyword_length = 3

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

au WinLeave * set nocursorline
au WinEnter * set cursorline
"
" use the silver searcher instead of ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" toggle NERDTree
map <leader>n :NERDTreeToggle<cr>
" redraw screen
"map <leader>r :redraw!<cr>
" map :Q->:q :W->:w
map :Q :q<cr>
map :W :w<cr>
map :E :e<cr>
