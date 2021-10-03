let mapleader = " "

set nocompatible

color desert
set cursorline
" set cursorcolumn
hi CursorLine term=bold cterm=bold guibg=Grey40


set modifiable

set relativenumber
set number
" set numberwidth=5
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
" set spell
set backspace=indent,eol,start
set autoindent
set smartindent
set shiftround
set autoread
set mouse=a 			
set tabstop=4 				 
set shiftwidth=4
set expandtab
set encoding=utf-8
set nojoinspaces
set complete-=i,kspell

set clipboard=unnamed
set lazyredraw
set confirm

set updatetime=300                      " Faster completion
set timeoutlen=500   


" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" set backupdir=~/.config/nvim/Caches
" set dir=~/.config/nvim/Caches

if (has("termguicolors"))
set termguicolors
endif
syntax enable
set background=dark
" colorscheme dracula
colorscheme gruvbox
filetype plugin indent on
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif



" let g:lightline = {
"       \ 'colorscheme': 'one',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
"       \   'right': [ [ 'lineinfo', 'percent' ],
"       \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
"       \ },
"       \ 'separator': { 'left': '', 'right': '' },
"       \ 'subseparator': { 'left': '', 'right': '' },
"       \ 'component_function': {
"       \   'gitbranch': 'fugitive#head',
"       \   'cocstatus': 'coc#status'
"       \ },
"       \ 'component': {
"       \   'lineinfo': '%3l:%-2v%<',
"       \ },
"       \ }



" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Switch to your current theme
let g:airline_theme = 'onedark'

" Always show tabs
set showtabline=2

" We don't need to see things like -- INSERT -- anymore
set noshowmode




nnoremap <C-z> :bnext<CR>
nnoremap <C-x> :bprev<CR>



"close-tag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.vue'
let g:closetag_emptyTags_caseSensitive = 1
let g:jsx_ext_required = 0
let g:closetag_shortcut = '>'

"Lock move 
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

"remove highlight
map <C-h> :nohl<CR>


"NERDTree
map <silent> <F2> :NERDTreeToggle<CR>

" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Change arrow to expand/collapse tree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

"let NERDTreeMapOpenInTab='<ENTER>'
" Git status icon
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'irty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
set guifont=DroidSnsMono_Nerd_Font:h11

nnoremap <Leader>\ :vsplit<CR>
nnoremap <Leader>/ :split<CR>

vmap <Tab> >gv
vmap <S-Tab> <gv

"syntaxtic"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"auto-pairs
let g:AutoPairsFlyMode = 1


" Auto close tag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.vue'
let g:closetag_emptyTags_caseSensitive = 1
" let g:jsx_ext_required = 0

"emmet
let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_leader_key=','


"""snippet
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
"
"
"" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

"Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


"Python
let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.9/bin/python3'
" let g:python3_host_prog = expand('~/.venv/bin/python3')
let g:node_client_debug = 1

" python3 << EOF
" import os
" if 'VIRTUAL_ENV' in os.environ:
"   os.system('pip install pylint')
" EOF


" Tagbar
" nmap <F8> :TagbarToggle<CR>
" autocmd CursorHold * silent call CocActionAsync('highlight')



"gitguter
highlight GitGutterAdd    guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0




"rainbow
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

autocmd FileType * RainbowParentheses
