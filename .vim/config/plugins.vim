"""""""""""""""" Loading
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" code completion, linting, highlighting
Plug 'vim-syntastic/syntastic'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/pynvim'
Plug 'Matt-Deacalion/vim-systemd-syntax'

" functionality
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf.vim'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-vinegar'
Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'
"Plug 'CoatiSoftware/vim-sourcetrail'

" themes'n'stuff
Plug 'tomasr/molokai'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

set rtp^=/usr/share/vim/vimfiles/

"""""""""""""" Settings
" vim-airline
set encoding=utf-8
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'

" vim-clang
let g:clang_library_path = "/usr/lib64/llvm"
let g:clang_c_options = '--std=gnu11'
let g:clang_cpp_options = '--std=c++11 --stdlib=libc++'

" vim-taglist
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Form = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_sci_settings = 'scilab;f:function'

" vim-tagbar
let g:tagbar_expand = 1
let g:tagbar_compact = 1
let g:tagbar_autofocus = 1

" vim-latexbox
let g:LatexBox_viewer = '/usr/bin/zathura --fork'

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_concepts_highlight = 1

" vim-startify
let g:startify_files_number = 3
