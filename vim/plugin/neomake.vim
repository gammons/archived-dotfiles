" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_serialize = 1

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']


let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']

" for debugging
let g:neomake_serialize_abort_on_error = 1
" let g:neomake_verbose = 3
" let g:neomake_logfile='/Users/grantammons/neomake.log'
