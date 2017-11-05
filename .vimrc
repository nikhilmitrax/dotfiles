set relativenumber
" remap h to insert and use ijkl for inverse T cursor movement
map h <insert>
map i <Up>
map j <Left>
map k <Down>

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Vundle Start
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" This might interefere with nvim-typescript
" For Tsuqyomi
" Plugin 'Shougo/vimproc.vim'
" Plugin 'Quramy/tsuquyomi'
" Plugin 'scrooloose/syntastic'

" For nvim-typescript
Plugin 'leafgarland/typescript-vim'
" Plugin 'mhartington/nvim-typescript'
" Plugin 'herringtondarkholme/yats.vim'
" Plugin 'neomake/neomake'
Plugin 'w0rp/ale'

Plugin 'autozimu/LanguageClient-neovim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'shougo/deoplete.nvim'
Plugin 'Shougo/echodoc.vim'
Plugin 'townk/vim-autoclose'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-sleuth'
Plugin 'mitermayer/vim-prettier'
Plugin 'airblade/vim-gitgutter'
Plugin 'mileszs/ack.vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dracula/vim'
Plugin 'ayu-theme/ayu-vim'
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

" Sane defaults
set showcmd
set incsearch
set hlsearch
set backspace=indent,eol,start
set cursorline
:command Q q
" Somewhat questionable, but needed for language server
set hidden
" Useful Shortcuts
nnoremap<Leader>p :PrettierAsync

" Prettifying tyings
let ayucolor="mirage"
colorscheme ayu

" Airline
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Terminal Mapping
tnoremap <Esc> <C-\><C-n>

" Deoplete Config
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
set cmdheight=2
let g:deoplete#auto_complete_delay = 0
" Prettier
let g:prettier#exec_cmd_path = "/usr/local/bin/prettier"
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync

" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'typescript': []}
" Syntastic
let g:syntastic_typescript_checkers = ['tslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Language Server

let g:LanguageClient_serverCommands = {
    \ 'typescript': ['/usr/local/bin/typescript-language-server', '--stdio'],
    \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
set signcolumn=yes

" neomake
"   call neomake#configure#automake({
"   \ 'TextChanged': {},
"   \ 'InsertLeave': {},
"   \ 'BufWritePost': {'delay': 0},
"   \ 'BufWinEnter': {},
"   \ }, 500)
" let g:neomake_open_list = 2
" let g:neomake_typescript_enabled_makers = ['tslint']

" nvim-typescript
let g:nvim_typescript#type_info_on_hold = 1
let g:nvim_typescript#default_mappings = 1

" The Silver Searcher & Ack and CtrlP
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP
  " for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --vimgrep --smart-case'                                                   
  cnoreabbrev ag Ack!
endif
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
