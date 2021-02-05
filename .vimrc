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
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" remove trailing whitespace when saving file
autocmd BufWritePre c,cpp,h,python :%s/\s\+$//e

" Autosource certain configs on write
autocmd BufWritePost $HOME/.vimrc source $HOME/.vimrc
autocmd BufWritePost $HOME/.zshrc !source $HOME/.zshrc
autocmd BufWritePost $HOME/.zshenv !source $HOME/.zshenv
autocmd BufWritePost *openbox/rc.xml !openbox --reconfigure
autocmd BufWritePost *openbox/menu.xml !openbox --reconfigure

" search zips without unzip
autocmd BufReadCmd *.zip 	call zip#Browser(expand("<amatch>"))

source ~/.vim/config/languages.vim
source ~/.vim/config/mappings.vim
source ~/.vim/config/monkey_term.vim
source ~/.vim/config/coc.vim
source ~/.vim/config/startify.vim
