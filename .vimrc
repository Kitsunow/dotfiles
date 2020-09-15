""""""""""""""""""""""""""""""""""Plugins""""""""""""""""""""""""""""""""""""""
source ~/.vim/config/plugins.vim
""""""""""""""""""""""""""""""""""Common"""""""""""""""""""""""""""""""""""""""
" enable usage of builtin plugins
filetype plugin indent on

" enable syntax highlighting in vim (and for latex)
syntax on

" color
set t_Co=256
colorscheme molokai

" highlight all matching search pattern
set hls

" disable bell
set vb

" set scroll width
set scrolloff=5

" general tabwidth
set tabstop=2
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent

" open splits to the right/bottom
set splitbelow
set splitright

" show line numbers
set number

" enable mouse support
if has('mouse')
  set mouse=a
endif

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" remove trailing whitespace when saving file
autocmd BufWritePre * :%s/\s\+$//e

" Autosource on save
autocmd! bufwritepost $HOME/.vimrc source $HOME/.vimrc
autocmd! bufwritepost $HOME/.zshrc !source $HOME/.zshrc
""""""""""""""""""""""""""""""""""Language-specific stuff""""""""""""""""""""""
" search zips without unzip
au BufReadCmd *.zip 	call zip#Browser(expand("<amatch>"))

" Only 80 chars allowed
highlight ColorColumn ctermbg=235 guibg=#2c2d27
autocmd FileType c let &colorcolumn=join(range(81,999),",")|set tabstop=4|set shiftwidth=4|set softtabstop=4|set cindent

" Skeleton files for different programming languages
autocmd BufNewFile *.tex 	0r $HOME/.vim/skeleton/skeleton.tex

" spell checking for latex
autocmd FileType tex setlocal spell spelllang=en,de

" latex support on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" python indentation
autocmd FileType *.py set tabstop=8|set expandtab|set shiftwidth=4|set softtabstop=4

" rust indentation
autocmd FileType rust set tabstop=4|set shiftwidth=4|set softtabstop=4

" enable syntax highlighting for rust
au BufNewFile,BufRead *.rs set filetype=rust

" autocompletion for rust
autocmd filetype rust nmap gd <plug>(rust-def)
autocmd filetype rust nmap gs <plug>(rust-def-split)
autocmd filetype rust nmap gx <plug>(rust-def-vertical)
autocmd filetype rust nmap <leader>gd <plug>(rust-doc)

source ~/.vim/config/mappings.vim
source ~/.vim/config/monkey_term.vim
source ~/.vim/config/coc.vim
source ~/.vim/config/startify.vim
