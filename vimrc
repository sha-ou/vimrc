""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For Vundle
" :BundleInstall  install
" :BundleInstall! update
" :BundleClean    remove plugin no in list
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                                                          " required
filetype off                                                              " required
set rtp+=~/.vim/bundle/Vundle.vim                                         " set the runtime path to include Vundle and initialize
call vundle#begin('~/.vim/bundle')
    " alternatively, pass a path where Vundle should install plugins
    " call vundle#begin('~/some/path/here')
    " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin 'scrooloose/syntastic'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'vim-scripts/c.vim'
" Plugin 'vim-latex/vim-latex'
" Plugin 'valloric/youcompleteme'
" Plugin 'nvie/vim-flake8'
call vundle#end()                                                         " All of your Plugins must be added before the following line
filetype on
filetype plugin on
filetype plugin indent on                                                 " required

"if has('gui_running')
"    set background=dark
"    colorscheme solarized
"else
"    colorscheme Zenburn
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","                                                       " 设置mapleader
filetype on                                                               " 打开文件类型检测功能
syntax on                                                                 " 语法高亮
set number                                                                " 显示行号
set autoread                                                              " 文件被外部改变时自动读取
set selection=exclusive                                                   " 允许区域选择
set selectmode=mouse,key                                                   
set statusline=%F,%Y,%l/%L,%v,%{&ff}
set laststatus=2                                                          " 总是显示状态行
set ruler                                                                 " 显示光标所在行列号
set autoindent                                                            " 继承前一行的缩进方式
set tabstop=4                                                             " 制表符为4
set expandtab
set softtabstop=4                                                         " 统一缩进为4
set shiftwidth=4
set backspace=2                                                           " 允许使用退格键
set backspace=eol,start,indent
set ignorecase                                                            " 搜索忽略大小写
set hlsearch                                                              " 搜索逐字符高亮
set incsearch
set cursorline                                                            " 高亮光标所在行
" imap { {}<ESC>i                                                         " 括号自动补全
" imap ( ()<ESC>i
" imap [ []<ESC>i
" :inoremap ' ''<ESC>i
" :inoremap " ""<ESC>i
imap （ （）<ESC>i
imap 【 【】<ESC>i
"""""""""""""""""""""""""""""
" Quickly Run"
"""""""""""""""""""""""""""""
map <F5> : call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
elseif &filetype == 'sh'
    :!time bash %
elseif &filetype == 'python'
    exec "!time python3 %"
endif
endfunc


" ---------Auto-Commands---------- "

" Automaticaly source the Vimrc file on save
autocmd BufWritePost ~/.vim/vimrc source %


" ---------Split-Management---------- "
set splitbelow
set splitright
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

" ---------Mappings---------- "
nmap <Leader>ev :e ~/.vim/vimrc<cr>
nmap <Leader><space> :nohlsearch<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ----------syntastic---------- "
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" ----------Jedi---------- "
" let g:jedi#popup_on_dot=0

" ----------NERD Commenter---------- "
let g:NERDSpaceDelims = 1                                                 " Add spaces after comment delimiters by default

" ----------NERD Tree---------- "
nmap <C-n> :NERDTreeToggle<CR>                                           

" ----------Tabluar---------- "
" if exists(":Tabularize")
    " nmap <Leader>a= :Tabularize /=<CR>
    " vmap <Leader>a= :Tabularize /=<CR>
    " nmap <Leader>a: :Tabularize /:<CR>
    " vmap <Leader>a: :Tabularize /:<CR>
    " nmap <Leader>a, :Tabularize /,<CR>
    " vmap <Leader>a, :Tabularize /,<CR>
" endif

" ----------vim-latex---------- "
" set grepprg=grep\ -nH\ $*
" let g:tex_flavor='latex'
" set iskeyword+=:
" " autocmd BufEnter *.tex
" set sw=2

" ----------Autowitre---------- "
autocmd BufNewFile *.py,*.sh exec ":call WriteInfo()"
func! WriteInfo()
    if &filetype == 'python'
        call setline(1,"#!/usr/bin/python3")
        call append(line("."),"")
        call append(line(".")+1,"###################################################################")
        call append(line(".")+2,"#    File name     : ".expand("%:t"))
        call append(line(".")+3,"#    Author        : doggy")
        call append(line(".")+4,"#    Date          : ".strftime("%c"))
        call append(line(".")+5,"#    Description   : ")
        call append(line(".")+6,"###################################################################")
        call append(line(".")+7,"")
        call append(line(".")+8,"")
    elseif &filetype == 'sh'
        call setline(1,"#!/bin/bash")
        call append(line("."),"")
        call append(line(".")+1,"###################################################################")
        call append(line(".")+2,"#    File name     : ".expand("%:t"))
        call append(line(".")+3,"#    Author        : doggy")
        call append(line(".")+4,"#    Date          : ".strftime("%c"))
        call append(line(".")+5,"#    Description   : ")
        call append(line(".")+6,"###################################################################")
        call append(line(".")+7,"")
        call append(line(".")+8,"")
    elseif &filetype == 'c'
        call setline(1,"/*  */")
        call append(line("."),"")
        call append(line(".")+1,"/*******************************************************************")
        call append(line(".")+2,"*    File name     : ".expand("%:t"))
        call append(line(".")+3,"*    Author        : doggy")
        call append(line(".")+4,"*    Date          : ".strftime("%c"))
        call append(line(".")+5,"*    Description   : ")
        call append(line(".")+6,"******************************************************************/")
        call append(line(".")+7,"")
        call append(line(".")+8,"")
    endif
endfunc

" ----------Color Scheme---------- "
colorscheme vividchalk
