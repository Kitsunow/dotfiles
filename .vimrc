""""""""""""""""""""""""""""""""""Plugins""""""""""""""""""""""""""""""""""""""
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
Plug 'xolox/vim-session'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-vinegar'
Plug 'xolox/vim-misc'

" themes'n'stuff
Plug 'tomasr/molokai'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
""""""""""""""""""""""""""""""""""Plugin Settings""""""""""""""""""""""""""""""
set rtp^=/usr/share/vim/vimfiles/

" vim-airline
set encoding=utf-8
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'

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

" vim-tagbar
nnoremap <silent> <F3> :TagbarToggle<CR>

" With this maps you can now toggle the terminal
nnoremap <F4> :call MonkeyTerminalToggle()<cr>
tnoremap <F4> <C-\><C-n>:call MonkeyTerminalToggle()<cr>

" Switch between source and header in c/c++
nnoremap <silent> <F5> :CocCommand clangd.switchSourceHeader<CR>

" FZF
nnoremap <silent> <C-O> :FZF<CR>

" vim-session
nnoremap <F9> :SaveSession
nnoremap <F10> :OpenSession
let g:session_autoload = 'no'
let g:session_directory="~/.vim/session"

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

" search zips without unzip
au BufReadCmd *.zip 	call zip#Browser(expand("<amatch>"))

" Autosource
autocmd! bufwritepost $HOME/.vimrc source $HOME/.vimrc
autocmd! bufwritepost $HOME/.zshrc !source $HOME/.zshrc

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

" python intendation
autocmd FileType *.py set tabstop=8|set expandtab|set shiftwidth=4|set softtabstop=4

" rust intendation
autocmd FileType rust set tabstop=4|set shiftwidth=4|set softtabstop=4

" enable syntax highlighting for rust
au BufNewFile,BufRead *.rs set filetype=rust

" autocompletion for rust
autocmd filetype rust nmap gd <plug>(rust-def)
autocmd filetype rust nmap gs <plug>(rust-def-split)
autocmd filetype rust nmap gx <plug>(rust-def-vertical)
autocmd filetype rust nmap <leader>gd <plug>(rust-doc)

""""""""""""""""""""""""""""""""""Functions""""""""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""""""COC"""""""""""""""""""""""""""""""""""""""
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
