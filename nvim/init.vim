" lua require'plug-colorizer'

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
" Plug 'dracula/vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'



Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/rainbow_parentheses.vim'

"GIT
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdTree' 			  
Plug 'Xuyuanp/nerdtree-git-plugin' 						
Plug 'ryanoasis/vim-devicons' 								
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'tpope/vim-commentary'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 			 
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-rooter'
" Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'voldikss/vim-floaterm'

Plug 'scrooloose/syntastic'
Plug 'chun-yang/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'honza/vim-snippets'
"debug
Plug 'puremourning/vimspector'
Plug 'jparise/vim-graphql'
" Plug 'majutsushi/tagbar'
" Plug 'terryma/vim-multiple-cursors'


Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}



call plug#end()

let nvim_settings_dir = '~/.config/nvim/settings/'
execute 'source '.nvim_settings_dir.'setup.vim'
execute 'source '.nvim_settings_dir.'rnvimr.vim'
execute 'source '.nvim_settings_dir.'fzf.vim'
execute 'source '.nvim_settings_dir.'coc.vim'
execute 'source '.nvim_settings_dir.'floaterm.vim'
execute 'source '.nvim_settings_dir.'javascript.vim'
execute 'source '.nvim_settings_dir.'vimspector.vim'


"LUA
let nvim_lua_dir = "~/.config/nvim/lua/"
execute 'luafile '.nvim_lua_dir.'plug-colorizer.lua'
