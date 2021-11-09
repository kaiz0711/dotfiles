let mapleader = ' '

set nocompatible
set shortmess+=c
set fileformat=unix
set relativenumber
set number
set colorcolumn=111
set modifiable
set signcolumn=yes
set hidden
set nobackup
set nowritebackup
set noswapfile
set history=1000
set ruler
set showcmd
set incsearch
set laststatus=2 
set autowrite
set backspace=indent,eol,start
set autoindent
set smartindent
set shiftround
set autoread
set mouse=a 			
set tabstop=4 				 
set shiftwidth=4
set expandtab
set nojoinspaces
set clipboard=unnamedplus
set lazyredraw
set confirm
set hlsearch
set completeopt =menu,menuone,noselect 
set fileencoding=utf-8
set encoding=utf-8
set incsearch 
set cursorline
set showtabline=2
set scrolloff=3
set sidescrolloff=5

set updatetime=300 
set timeoutlen=500   
highlight Comment gui=italic


if (has("termguicolors"))
set termguicolors
endif

set guifont=DroidSnsMono_Nerd_Font:h11


syntax enable
set background=dark
colorscheme dracula

filetype plugin indent on

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
     syntax on
endif

" set guifont=DejaVuSansMono:h16
set guifont=Hack\ 16
"comment
autocmd FileType apache setlocal commentstring=#\ %s



let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.9/bin/python3'
let g:node_client_debug = 1


"autopairs
let g:AutoPairsFlyMode = 1


"emmet
let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_leader_key=','


"syntaxtic"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)



"Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)



"Tagbar
autocmd CursorHold * silent call CocActionAsync('highlight')

