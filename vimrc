""""""""""
" inherited from tb config
""""""""""

set encoding=utf-8
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

filetype plugin on
filetype plugin indent on

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:\ \ ,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full

" not 100% sure if this TabWrapper thing is needed.
" clean up sometime in 2021 if proven it's not needed.
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<Tab>"
"     else
"         return "\<C-p>"
"     endif
" endfunction
" inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
" inoremap <S-Tab> <C-n>

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<Space>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Load all bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

""""""""""
" my config
""""""""""

let mapleader = ","
set background=dark
set complete=.,b,u,]
set foldmethod=syntax
set gdefault      " Replace all matches on a line instead of just the first
set hlsearch      " highlight search results
set ignorecase    " searches are case-insensitive
set lazyredraw    " Don't redraw the screen during macros
set matchtime=0   " Speed up escape after (){} chars
set nofoldenable
set noshowmode
set nowrap
set scrolloff=0
set synmaxcol=250 " Don't try to highlight lines longer than 250 characters.
set smartcase     " searches are case-sensitive if a capital is in term
set ttimeout      " Fast timeout
set undodir=$HOME/.undodir
set undofile
set wildmenu
set wildmode=longest:full,full
set winwidth=84
set winheight=10
set winminheight=5
set wrap
set tags^=./.git/tags;

" keyboard mappings
nnoremap <cr> :nohlsearch<cr>
map <Leader>co :TComment<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>t :TestNearest<CR>
nnoremap <Leader>r :TestFile<CR>
noremap <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
noremap <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
noremap <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" probably move this to ftplugin
au FileType go nmap <leader>r <Plug>(go-run)

" NERDTreeconfig
let NERDTreeShowHidden=1 "show hidden files in NERD
map <Leader>n :NERDTreeToggle<CR>

" base16 color config
let base16colorspace=256
colorscheme base16-default-dark

" Highlight VCS conflict markers
" not sure if needed.
" match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" dunno if this is needed
" highlight Pmenu ctermbg=75 guibg=#2c323c
" highlight PmenuSel ctermbg=17 guibg=#3c4452
" hi Normal ctermbg=none
" hi NonText ctermbg=none


" remove this for the moment
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
" autocmd BufRead,BufNewFile *.md setlocal nospell

" ALE config
let g:ale_emit_conflict_warnings = 0

highlight ALEWarning ctermfg=yellow
highlight ALEError ctermfg=124
let g:ale_enabled = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_completion_autoimport = 1

let g:prettier#autoformat = 0

" used when a project is within a docker container
"function! DockerTransform(cmd)
"  return('cd ~/local_code/convertkit-docker; '.a:cmd)
"endfunction

"let g:test#custom_transformations = {'docker': function('DockerTransform')}
"let g:test#transformation = 'docker'

" Use docker-compose for running specs
" let test#ruby#rspec#executable = './bin/rspec'
" normal-ass setup
let test#ruby#rspec#executable = 'bundle exec rspec'

" kill extra whitespace when saving
let g:strip_whitespace_on_save=1

command! Wq wq

let g:vim_markdown_new_list_item_indent = 0

let g:deoplete#enable_at_startup = 1

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
