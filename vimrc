let mapleader = ","                                                       " 设置mapleader
let $VIMCONFDIR = expand("$HOME/.vim")
let $PLUGINDIR  = expand("$VIMCONFDIR/bundle")

if empty(glob(expand("$PLUGINDIR/plug.vim")))
    silent !curl -fLo $PLUGINDIR/plug.vim --create-dirs 
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $VIMCONFDIR/vimrc
endif
source $PLUGINDIR/plug.vim

call plug#begin(expand($PLUGINDIR))
    
" Plug 'jnurmine/Zenburn'
" Plug 'altercation/vim-colors-solarized'

Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'

Plug 'majutsushi/tagbar'
    let g:tagbar_ctags_bin='/usr/bin/ctags'
    let g:tagbar_right=1
    let g:tagbar_autopreview=0
    let g:tagbar_autoclose=0
    let g:tagbar_autofocus=0
    let g:tagbar_sort=0
    let g:tagbar_show_linenumbers=1
    map <C-m> :TagbarToggle<CR>
    map <C-v> :w<CR>:TagbarClose<CR>:TagbarOpen<CR>

Plug 'w0rp/ale'
    let g:ale_keep_list_window_open=1
    let g:ale_lint_on_enter=1
    let g:ale_linters_explicit = 1
    let g:ale_completion=1
    let g:ale_completion_delay = 500
    let g:ale_echo_delay = 20
    let g:ale_lint_delay = 500
    let g:ale_echo_msg_format = '[%linter%] %code: %%s'
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1
    let g:airline#extensions#ale#enabled = 1
    let g:ale_sign_error='✗'
    let g:ale_sign_warning='⚡'

    let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
    let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
    let g:ale_c_cppcheck_options = ''
    let g:ale_cpp_cppcheck_options = ''
    let g:ale_linters = {
                \ 'c++': ['clang', 'cppcheck'],
                \ 'c': ['gcc', 'cppcheck', 'clang'],
                \ 'python': ['flake8'],
                \ 'sh': ['shell', 'shellcheck'],
                \ 'vim': ['vint'],
                \}

Plug 'davidhalter/jedi-vim' 
     let g:jedi#popup_on_dot=0
     let g:jedi#popup_select_first=1
     let g:jedi#completions_enabled=1
     let g:jedi#auto_close_doc=0
     let g:jedi#smart_auto_mappings=1

Plug 'tell-k/vim-autopep8'
    let g:autopep8_max_line_length=79  " set maximum allowed line length
    let g:autopep8_disable_show_diff=1  " Disable show diff window
    let g:autopep8_on_save=1  " Automatically format every time saving a file

Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims = 1                                            " Add spaces after comment delimiters by default

Plug 'scrooloose/nerdtree'
    nmap <C-n> :NERDTreeToggle<CR>                                           
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  " Auto close when NERDTree is the last window

Plug 'godlygeek/tabular'
	
Plug 'vim-airline/vim-airline'
	set laststatus=2                                                     " 永远显示状态栏
	set t_Co=256                                                         " 终端256色
	let g:airline#extensions#tabline#enabled = 1                         " 显示窗口tab和buffer
    
    function! AirlineInit()
        let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
        let g:airline_section_b = airline#section#create_left(['ffenc', 'hunks', '%f'])
        let g:airline_section_c = airline#section#create(['filetype'])
        let g:airline_section_x = airline#section#create(['%P'])
        let g:airline_section_y = airline#section#create(['%B'])
        let g:airline_section_z = airline#section#create_right(['%l', '%c'])
    endfunction
    autocmd VimEnter * call AirlineInit()

Plug 'vim-airline/vim-airline-themes'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on                                                               " 打开文件类型检测功能
filetype plugin on
filetype plugin indent on                                                 " required
syntax on                                                                 " 语法高亮
set number                                                                " 显示行号
set autoread                                                              " 文件被外部改变时自动读取
set selection=exclusive                                                   " 允许区域选择
set selectmode=mouse,key                                                   
" set statusline=%F,%Y,%l/%L,%v,%{&ff}
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
" autocmd BufWritePost ~/.vim/vimrc source %

" ---------Mappings---------- "
nmap <Leader>ev :e ~/.vim/vimrc<cr>
nmap <Leader><space> :nohlsearch<cr>


" ---------Split-Management---------- "
set splitbelow
set splitright
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

" ----------Autowitre---------- "
autocmd BufNewFile *.py,*.sh exec ":call WriteInfo()"
func! WriteInfo()
    if &filetype == 'python'
        call setline(1,"#!/usr/bin/python3")
        call append(line("."),"")
        call append(line(".")+1,"###################################################################")
        call append(line(".")+2,"#    File name     : ".expand("%:t"))
        call append(line(".")+3,"#    Author        : sha-ou")
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
        call append(line(".")+3,"#    Author        : sha-ou")
        call append(line(".")+4,"#    Date          : ".strftime("%c"))
        call append(line(".")+5,"#    Description   : ")
        call append(line(".")+6,"###################################################################")
        call append(line(".")+7,"")
        call append(line(".")+8,"")
    elseif &filetype == 'c'
        call setline(1,"/*  */")
        call append(line("."),"")
        call append(line(".")+1,"/*************************************************/")
        call append(line(".")+2,"*    File name     : ".expand("%:t"))
        call append(line(".")+3,"*    Author        : sha-ou")
        call append(line(".")+4,"*    Date          : ".strftime("%c"))
        call append(line(".")+5,"*    Description   : ")
        call append(line(".")+6,"**************************************************/")
        call append(line(".")+7,"")
        call append(line(".")+8,"")
    endif
endfunc

" ----------Color Scheme---------- "
colorscheme vividchalk
