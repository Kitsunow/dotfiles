source ~/.vim/config/plugins.vim

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

" search zips without unzip
au BufReadCmd *.zip 	call zip#Browser(expand("<amatch>"))

source ~/.vim/config/languages.vim
source ~/.vim/config/mappings.vim
source ~/.vim/config/monkey_term.vim
source ~/.vim/config/coc.vim
source ~/.vim/config/startify.vim
