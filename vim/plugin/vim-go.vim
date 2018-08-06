let g:go_highlight_types = 1
let g:go_fmt_command = "goimports"
autocmd BufWritePost *.go :GoBuild
