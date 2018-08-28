set shell=bash
set relativenumber
" remap h to insert and use ijkl for inverse T cursor movement
" map i <Up>
" map j <Left>
" map k <Down>
" noremap h i

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set lazyredraw
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
" Plugin 'ctrlpvim/ctrlp.vim'
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
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'dracula/vim'
Plugin 'ayu-theme/ayu-vim'
"Plugin 'majutsushi/tagbar'
Plugin 'elzr/vim-json'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Plugin 'IngoHeimbach/semantic-highlight.vim'
Plugin 'mhinz/vim-startify'
Plugin 'tomtom/tcomment_vim'
"Plugin 'scrooloose/nerdtree'
Plugin 'ryanoasis/vim-devicons'
" Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'easymotion/vim-easymotion'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'francoiscabrol/ranger.vim'

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
"let g:python_host_prog = "/Users/nikhilmitra/.pyenv/shims/python2"
let g:python3_host_prog = "/Users/nikhilmitra/workspace/sem/semantics-soccer/.venv/bin/python"

syntax enable

" Sane defaults
set showcmd
set incsearch
set hlsearch
set backspace=indent,eol,start
set cursorline
:command Q q
:command JFormat %!jq '.'
" Somewhat questionable, but needed for language server
set hidden
let mapleader = ","

"" Prettifying tyings
let ayucolor="mirage"
colorscheme onedark 
"let s:semanticGUIColors = [ '#72d572', '#c5e1a5', '#e6ee9c', '#fff59d', '#ffe082', '#ffcc80', '#ffab91', '#bcaaa4', '#b0bec5', '#ffa726', '#ff8a65', '#f9bdbb', '#f9bdbb', '#f8bbd0', '#e1bee7', '#d1c4e9', '#ffe0b2', '#c5cae9', '#d0d9ff', '#b3e5fc', '#b2ebf2', '#b2dfdb', '#a3e9a4', '#dcedc8' , '#f0f4c3', '#ffb74d' ]
"let g:semanticTermColors = [28,1,2,3,4,5,6,7,25,9,10,34,12,13,14,15,16,125,124,19]
"autocmd Filetype typescript :SemanticHighlight 


" Ranger
let g:ranger_map_keys = 0
map <c-t> :Ranger<cr>
let g:ranger_replace_netrw = 1

" Startify
let g:startify_fortune_use_unicode = 1
" Easymotion
map <Leader>e <Plug>(easymotion-prefix)
map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Airline
let g:airline_theme='ayu'
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['tabline', 'branch']
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
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree']
" Inteferes with something
" tnoremap <Esc> <C-\><C-n>

" FZF 
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>
nnoremap <c-f> :call SearchWordWithAg()<CR>
nnoremap <Leader><Leader> :Buffers<CR>
function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

" NERDTree
"map <C-t> :NERDTreeToggle<CR>
" Open on startup
"let NERDTreeDirArrows = 1
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter *
"            \   if !argc()
"            \ |   Startify
"            \ |   NERDTree
"            \ |   wincmd w
"            \ | endif

" Deoplete Config
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
set cmdheight=2
let g:deoplete#auto_complete_delay = 0
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Prettier
let g:prettier#exec_cmd_path = "/usr/local/bin/prettier"
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
nmap <Leader>p <Plug>(Prettier)
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync

" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'typescript': []}
let g:ale_linters = {'python': []}

" Syntastic
"let g:syntastic_typescript_checkers = ['tslint']
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Tagbar
let g:tagbar_type_typescript = {                                                  
  \ 'ctagsbin' : 'tstags',                                                        
  \ 'ctagsargs' : '-f-',                                                           
  \ 'kinds': [                                                                     
    \ 'e:enums:0:1',                                                               
    \ 'f:function:0:1',                                                            
    \ 't:typealias:0:1',                                                           
    \ 'M:Module:0:1',                                                              
    \ 'I:import:0:1',                                                              
    \ 'i:interface:0:1',                                                           
    \ 'C:class:0:1',                                                               
    \ 'm:method:0:1',                                                              
    \ 'p:property:0:1',                                                            
    \ 'v:variable:0:1',                                                            
    \ 'c:const:0:1',                                                              
  \ ],                                                                            
  \ 'sort' : 0                                                                    
\ }


" Language Server
let g:LanguageClient_serverCommands = {
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'python': ['pyls'],
    \ 'cpp': ['cquery']
    \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_changeThrottle = 0.5
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gD :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

autocmd BufWritePre *.py :call LanguageClient_textDocument_formatting()

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
" let g:nvim_typescript#type_info_on_hold = 1
" let g:nvim_typescript#default_mappings = 1

" The Silver Searcher & Ack and CtrlP
" if executable('ag')
"   " Use ag over grep
"   set grepprg=ag\ --nogroup\ --nocolor
"   " Use ag in CtrlP
"   " for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
"   let g:ackprg = 'ag --vimgrep --smart-case'                                                   
"   cnoreabbrev ag Ack!
" endif
" let g:ctrlp_working_path_mode = 0
" let g:ctrlp_show_hidden = 1
