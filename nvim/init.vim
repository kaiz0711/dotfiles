
call plug#begin('~/.config/nvim/plugged')
	Plug 'dracula/vim'
    Plug 'kyazdani42/nvim-web-devicons'     
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'tpope/vim-commentary'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'akinsho/bufferline.nvim'
    Plug 'tpope/vim-surround'
    Plug 'sheerun/vim-polyglot'  
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'chun-yang/auto-pairs'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'p00f/nvim-ts-rainbow'    
    Plug 'mattn/emmet-vim'
    Plug 'scrooloose/syntastic'
    Plug 'neoclide/coc.nvim', {'branch': 'release'} 
    Plug 'honza/vim-snippets'
    Plug 'voldikss/vim-floaterm'
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    Plug 'majutsushi/tagbar'
    Plug 'gwww/vim-bbye'
    Plug 'karb94/neoscroll.nvim'  
    Plug 'xiyaowong/nvim-transparent'
    Plug 'glepnir/dashboard-nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'phaazon/hop.nvim'
call plug#end()


" Vim Settings
let nvim_settings_dir = '~/.config/nvim/settings/'
    execute 'source '.nvim_settings_dir.'options.vim'
    execute 'source '.nvim_settings_dir.'keybindings.vim'
    execute 'source '.nvim_settings_dir.'coc.vim'
    execute 'source '.nvim_settings_dir.'floaterm.vim'
    execute 'source '.nvim_settings_dir.'rnvimr.vim'
    execute 'source '.nvim_settings_dir.'dashboard.vim'

"Lua Settings
lua require('nvimtreesitter')
lua require('nvimtree')
lua require('nvimtelescope')
lua require('nvimcolorizer')
lua require('nvimlualine')
lua require('nvimbufferline')
lua require('scroll')
lua require('indent')
