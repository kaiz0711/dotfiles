
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>


noremap <silent><S-h> :nohl<CR>


vmap <Tab> >gv
vmap <S-Tab> <gv

nnoremap <Leader>-- :vsplit<CR>
nnoremap <Leader>// :split<CR>


nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


xnoremap <silent>K ::move \'<-2<CR>gv-gv\'
xnoremap <silent>J ::move \'+<1<CR>gv-gv\'



"Nvimtree
nnoremap <silent> <F2> :NvimTreeToggle<CR>


inoremap <silent>jk <ESC>
inoremap <silent>kj <ESC>


"Telescope
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>

" bufferline
nnoremap <silent><TAB> :BufferLineCycleNext<CR>
nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>

"Tagbar
nmap <F3> :TagbarToggle<CR>


"Bbye
nnoremap <Leader>q :Bdelete<CR>


" Transprarent
nnoremap <silent><F4> :TransparentToggle<CR>
