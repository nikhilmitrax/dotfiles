set relativenumber
" remap h to insert and use ijkl for inverse T cursor movement
map h <insert>
map i <Up>
map j <Left>
map k <Down>

" Vundle Start
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'shougo/deoplete.nvim'
Plugin 'mhartington/nvim-typescript'
Plugin 'townk/vim-autoclose'
Plugin 'flazz/vim-colorschemes'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-sleuth'
Plugin 'herringtondarkholme/yats.vim'
Plugin 'mitermayer/vim-prettier'
Plugin 'airblade/vim-gitgutter'
Plugin 'ajh17/spacegray.vim'
Plugin 'mileszs/ack.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
let g:python_host_prog = "/usr/local/bin/python2"
let g:python3_host_prog = "/usr/local/bin/python3"
syntax enable

set background=dark
colorscheme spacegray
let g:molokai_original = 1

nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nnoremap<Leader>p :PrettierAsync

set showcmd
set incsearch
set hlsearch
set backspace=indent,eol,start
set cursorline

if (has("termguicolors"))
  set termguicolors
endif

let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

let g:deoplete#enable_at_startup = 1

let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
autocmd BufWritePre,TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
:command Q q

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP
  " for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1

let g:ackprg = 'ag --vimgrep --smart-case'                                                   
cnoreabbrev ag Ack!
