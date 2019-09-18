""""""""""""""""""""""""""""""""""Plugins""""""""""""""""""""""""""""""""""""""
" use pathogen as plugin manager
set rtp^=/usr/share/vim/vimfiles/
execute pathogen#infect()

" vim-airline
"set ft=tmux
set encoding=utf-8
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'

" vim-racer
set hidden
let g:racer_cmd = "/usr/bin/racer"
let g:racer_experimental_completer = 1

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

" vim-latexbox
let g:LatexBox_viewer = '/usr/bin/zathura --fork'

" nim-vim
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

""""""""""""""""""""""""""""""""""Common"""""""""""""""""""""""""""""""""""""""
" enable usage of builtin plugins
filetype plugin indent on

" enable syntax highlighting in vim (and for latex)
syntax on

" color
set t_Co=256
colorscheme molokai

" spell checking
"set spell spelllang=en,de

" highlight all matching search pattern
set hls

" relativenumber
"set relativenumber

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

" use a underlined cursor
" set cursorline
"
" enable mouse support
if has('mouse')
  set mouse=a
endif

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

""""""""""""""""""""""""""""""""""Mappings"""""""""""""""""""""""""""""""""""""
" NERDTree
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" vim-taglist
nnoremap <silent> <F3> :TlistToggle<CR>
"let Tlist_Auto_Open = 1

" With this maps you can now toggle the terminal
nnoremap <F4> :call MonkeyTerminalToggle()<cr>
tnoremap <F4> <C-\><C-n>:call MonkeyTerminalToggle()<cr>

" vim-a
nnoremap <silent> <F5> :A<CR>

" vim-ctrlp
"set runtimepath^=$HOME/.vim/bundle/ctrlp.vim
"nnoremap <silent> <F6> :CtrlP<CR>
nnoremap <silent> <F7> :CtrlPBuffer<CR>
"nnoremap <silent> <F8> :CtrlPMixed<CR>

" vim-session
nnoremap <F9> :SaveSession
nnoremap <F10> :OpenSession
let g:session_directory="~/.vim/session"

" use TAB for autocomplete
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" use ctrl-[hjkl] to switch between splitted windows
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k

" Go through functions in c++
nnoremap <M-J> /\v^(\w+\s+)?\w+::\w+\(.*\)
nnoremap <M-K> ?\v^(\w+\s+)?\w+::\w+\(.*\)

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" for tipping errors
ab q qa
ab Q q
ab W w
ab Wq wq
ab wQ wq
ab wq wqa

""""""""""""""""""""""""""""""""""Language-specific stuff""""""""""""""""""""""
" remove trailing whitespaces when saving file
autocmd BufWritePre * :%s/\s\+$//e

" enable syntax highlighting for Rust
au BufNewFile,BufRead *.rs set filetype=rust

" search zips without unzip
au BufReadCmd *.zip 	call zip#Browser(expand("<amatch>"))

" Autosource
autocmd! bufwritepost $HOME/.vimrc source $HOME/.vimrc
autocmd! bufwritepost $HOME/.zshrc !source $HOME/.zshrc

" Skeleton files for different programming languages
autocmd BufNewFile *.c    0r $HOME/.vim/skeleton/skeleton.c
autocmd BufNewFile *.h    0r $HOME/.vim/skeleton/skeleton.h
autocmd BufNewFile *.cpp  0r $HOME/.vim/skeleton/skeleton.cpp
autocmd BufNewFile *.{hpp} call <SID>insert_gates()
autocmd BufNewFile *.tex 	0r $HOME/.vim/skeleton/skeleton.tex

" Only 80 chars allowed
highlight ColorColumn ctermbg=235 guibg=#2c2d27
autocmd FileType c let &colorcolumn=join(range(81,999),",")|set tabstop=4|set shiftwidth=4|set softtabstop=4|set cindent

" rust intendation
autocmd FileType rust set tabstop=4|set shiftwidth=4|set softtabstop=4

" python intendation
autocmd FileType *.py set tabstop=8|set expandtab|set shiftwidth=4|set softtabstop=4

" perl autocomplete
autocmd FileType perl set smartindent|set iskeyword+=:|let perl_extended_vars = 1

" latex support on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" spell checking for latex
autocmd FileType tex setlocal spell spelllang=en,de

" autocompletion
autocmd filetype rust nmap gd <plug>(rust-def)
autocmd filetype rust nmap gs <plug>(rust-def-split)
autocmd filetype rust nmap gx <plug>(rust-def-vertical)
autocmd filetype rust nmap <leader>gd <plug>(rust-doc)

""""""""""""""""""""""""""""""""""Functions""""""""""""""""""""""""""""""""""""
" autocompletion with tab
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

" autodefine for c++ headers
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! i\n "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction

" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1

function! MonkeyTerminalOpen()
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:monkey_terminal_buffer)
    " Creates a window call monkey_terminal
    new monkey_terminal
    " Moves to the window the right the current one
    wincmd J
    resize 12
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

     " Change the name of the buffer to "Terminal 1"
     silent file Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')

    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    set nobuflisted
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    " Moves to the window below the current one
    wincmd J
    resize 12
    buffer Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
    endif
  endif
endfunction

function! MonkeyTerminalToggle()
  if win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalClose()
  else
    call MonkeyTerminalOpen()
  endif
endfunction

function! MonkeyTerminalClose()
  if win_gotoid(s:monkey_terminal_window)
    " close the current window
    hide
  endif
endfunction

function! MonkeyTerminalExec(cmd)
  if !win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalOpen()
  endif

  " clear current input
  call jobsend(s:monkey_terminal_job_id, "clear\n")

  " run cmd
  call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
  normal! G
  wincmd p
endfunction


" This an example on how specify command with different types of files.
    augroup go
        autocmd!
        autocmd BufRead,BufNewFile *.go set filetype=go
        autocmd FileType go nnoremap <F5> :call MonkeyTerminalExec('go run ' . expand('%'))<cr>
augroup END
"
""""""""""""""""""""""""""""""""""Macros"""""""""""""""""""""""""""""""""""""""
let @f = 'vaBok'
