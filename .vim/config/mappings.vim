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
nnoremap <silent> <leader><C-o> :FZF<CR>

" vim-session
nnoremap <F9> :SSave
nnoremap <F10> :SLoad

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

