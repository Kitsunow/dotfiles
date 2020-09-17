" Only 80 chars allowed
highlight ColorColumn ctermbg=235 guibg=#2c2d27
autocmd FileType c,cpp,python,rust let &colorcolumn=join(range(101,999),",")|set tabstop=4|set shiftwidth=4|set softtabstop=4|set cindent

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
