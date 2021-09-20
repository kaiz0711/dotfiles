let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1


augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END



"Prettier
let g:vim_jsx_pretty_colorful_config = 1 " default 0
