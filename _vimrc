" ==================================================
" Author:         aXen
" EMail:          BusyAnt@qq.com
" Github:         https://github.com/aXen
" Create Date:    2010-08-13 10:18:58
" Last Modified:  2015-06-15 16:42:48
" References:
"       1. https://github.com/NsLib/blog-vim-proj
" ==================================================


"===============================================================================
" Source User's Own Setting
"===============================================================================
"{{{ source
source $VIM/_vimrc.ba
source $VIM/_vimrc.local
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
"}}}
"===============================================================================
" Vim Settings
"===============================================================================
" Vim Settings {{{1

"{{{ 基本设置
set nocompatible                    " 不兼容老得VI，除非有特殊的理由
set helplang=cn                     " 帮助语言
let mapleader=","                   " Leader

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set splitright                      " 窗口的分割会把新窗口放到当前窗口之右。
set selectmode=""
set undolevels=1000
set updatetime=500
set wrap

set history=50	                    " keep 50 lines of command line history
"}}}

"{{{ 语法检测设定
filetype    on                      " 检测打开文件的类型
syntax      on                      " 开启语法高亮
syntax      enable                  " 激活语法高亮
filetype    plugin on               " 允许特定的文件类型载入插件文件
filetype    indent on               " 允许特定的文件类型载入缩进文件
"}}}

"{{{ 存储
set nobomb                          " 不使用bom编码
set nobackup                        " 不使用备份文件
set noswapfile                      " 不产生交换文件
set autoread                        " 自动同步外部修改
set autowrite                       " 自动把内容写回文件
"}}}

"{{{ 缩进/换行/空白/行号/折叠/滚动
" 缩进
set autoindent                      " 开启新行时，自动缩进
set smartindent                     " 开启新行时，智能缩进
set cindent                         " C程序自动缩进

" 换行
set lbr                             " 不在单词中间断行
set fo+=mB                          " 打开断行模块对亚洲语言支持
set whichwrap+=<,>,h,l              " 命令模式下可以直接移动到下一行或上一行

" 空白
set shiftwidth=4                    " 缩进空白数
set tabstop=4                       " Tab所占空格数
set expandtab                       " 将Tab展开为空格
set softtabstop=4                   " 配合tabstop
set listchars=tab:?\ ,trail:?       " 指定Tab和结尾空白字符
" Makefile中需要使用Tab
autocmd FileType make   set      noexpandtab
set backspace=eol,start,indent      " 插入模式下使用 <BS>、<Del> <C-W> <C-U>

" 行号
set number                          " 显示行号
set numberwidth=2

" 代码折叠
set foldenable                      " 开启代码折叠
set foldmethod=syntax               " 根据语法折叠代码

" Vim折叠
autocmd FileType vim    setlocal foldmethod=marker
autocmd FileType vim    setlocal foldmarker={{{,}}}
"}}}

"{{{ 状态栏/标尺
set ruler                           " 显示光标所在位置
set cursorline                      " 高亮当前行
set showcmd                         " 再屏幕最后一行显示命令
set laststatus=2                    " 始终显示状态栏
set cmdheight=1                     " 命令行使用的屏幕行数
"}}}

"{{{ 搜索和匹配
set showmatch                       " 高亮显示匹配的括号
set matchtime=5                     " 匹配括号高亮的时间(单位是十分之一秒)
set ignorecase                      " 搜索时忽略大小写
set smartcase                       " 如果搜索模式包含大写字符，不使用'ignorecase'选项
set hlsearch                        " 高亮被搜索的内容
set incsearch                       " 增量搜索
"}}}

"{{{ 主题设置
set t_Co=256                        " 开启256色支持
colorscheme molokai
"}}}

"{{{ 杂项
set noerrorbells                    " 错误时不发出声响
set novisualbell                    " 禁用可视响铃
set t_vb=                           " 可视响铃
set mouse=a                         " 所有模式下，开启鼠标支持
set wildmenu                        " 命令行补全以增强模式运行
set splitright                      " 竖直新分割的窗口在右侧
set splitbelow                      " 水平新分割的窗口在下面
" 打开上次编辑位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set ambiwidth=double
set completeopt=menuone
set display=lastline,uhex
set fillchars=vert:\|,fold:-
set formatoptions+=Mmn
set guioptions=egmrt
set guitablabel=%{tabpagenr()}.%t\ %m
set laststatus=2
set linespace=1
set previewheight=8
set report=2
set scroll=8
set statusline=%f%m\ \[%{&ff}:%{&fenc}:%Y]\ %{getcwd()}%=(%b,0x%B)(%l\/%L\|%c%V)%P%<
set selection=inclusive
set virtualedit=block
set whichwrap+=<,>,[,]
set winaltkeys=no
"}}}

"{{{ autocmd
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

    augroup END

endif " has("autocmd")
"}}}

"{{{ diff options
set diffopt=filler,vertical  " 显示填充行，垂直分割

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
"}}}

"{{{ mouse
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a  " a：所有模式
    set mousemodel=popup  " 鼠标右键的工作方式，详见鼠标工作方式总览
endif
"}}}

"{{{ encoding
if has("win32")
    "设置编码,解决乱码问题
    set encoding=utf-8 
    set langmenu=zh_CN.UTF-8 
    language message zh_CN.UTF-8
    source $VIMRUNTIME/delmenu.vim "仅在windows的Gvim使用
    source $VIMRUNTIME/menu.vim "仅在windows的Gvim使用
    set fileencodings=utf-8,gb2312,gbk,gb18030
    set termencoding=utf-8

    set fileformat=dos
    set fileformats=dos,unix,mac  " 文件格式，主要是指回车，换行
elseif has("unix")
    set encoding=utf-8
    setglobal fenc=utf-8
    set langmenu=zh_CN.utf-8  " this must be set before syntax on
    set termencoding=utf-8
    set fencs=ucs-bom,utf-8,prc,gb18030,big5,iso-8859-1
    set fileformats=unix,dos,mac
    language message zh_CN.utf-8  " vim提示消息编码
else
    set encoding=utf-8
endif
"}}}

"{{{ tab stop options
set tabstop=4  " 文件里的 <Tab> 代表的空格数
set shiftwidth=4  " (自动) 缩进每一步使用的空白数目。用于 |'cindent'|、|>>|、|<<| 等
set softtabstop=0  " 执行编辑操作，如插入 <Tab> 或者使用 <BS> 时，把 <Tab> 算作空格的数目:
set expandtab
set smarttab
set listchars=tab:>-  " tab符显示样式
"}}}

"{{{ font
if has("win32")
    "set guifontwide=NSimSun:h10:i
    set guifontwide=Courier\ New:h10:i
    set guifont=Courier\ New:h10:i
    "set guifont=Bitstream_Vera_Sans_Mono:i:h10,Fixedsys:h10.5
    "set guifont=新宋体:h11
elseif has("unix")
    set guifont=Bitstream\ Vera\ Sans\ Mono\ Oblique\ 10.5,Fixedsys\ Excelsior\ 2.00\ 11
    set guifontwide=NSimSun\ 11
endif
"}}}

"}}}
"===============================================================================
" Plugins
"===============================================================================
" Plugins {{{1

"{{{ nerdtree
map <m-e> :NERDTreeToggle<CR>
"}}}

"{{{ neocomplcache
let g:neocomplcache_enable_at_startup = 1
"}}}

"{{{ pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on
"}}}

"{{{ vim-jsbeautify
" https://github.com/maksimr/vim-jsbeautify.git
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript     noremap     <buffer>    <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html           noremap     <buffer>    <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css            noremap     <buffer>    <c-f> :call CSSBeautify()<cr>
autocmd FileType javascript     vnoremap    <buffer>    <c-f> :call RangeJsBeautify()<cr>
autocmd FileType html           vnoremap    <buffer>    <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css            vnoremap    <buffer>    <c-f> :call RangeCSSBeautify()<cr>
"}}}

"{{{ Tagbar
nmap <F8> :TagbarToggle<CR>
"}}}

"{{{ AutoComplete
" ref: http://easwy.com/blog/archives/advanced-vim-skills-omin-complete/
set completeopt=longest,menu
" mapping
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"
"}}}

"}}}
"===============================================================================
" Key Binding
"===============================================================================
" Key Binding {{{1

" vim 开发
nnoremap    <Leader>sv                 :source $MYVIMRC<cr>        " 刷新vim配置
nnoremap    <Leader>ev                 :vsplit $MYVIMRC<cr>        " 分割窗口打开vim配置
" 用空格键开关折叠
nnoremap <silent> <space> @=((foldclosed(line('.')) < 0 ) ? 'zc':'zo')<CR>

" 编辑相关
"inoremap    jk                  <esc>           " 编辑模式下按jk等价于按ESC键, 非常高效
"nnoremap    Q                   :q<CR>          " 命令模式下，输入Q，退出Vim

" 窗口间移动
nnoremap    <C-j>               <C-W>j
nnoremap    <C-k>               <C-W>k
nnoremap    <C-h>               <C-W>h
nnoremap    <C-l>               <C-W>l

" 插入模式下移动光标
inoremap    <C-y>               <Up>            " 输入模式下，按Ctrl+y移动光标到上一行
inoremap    <C-e>               <Down>          " 输入模式下，按Ctrl+e移动光标到下一行
inoremap    <c-h>               <left>
inoremap    <c-l>               <right>
inoremap    <c-j>               <c-o>gj
inoremap    <c-k>               <c-o>gk


" [Copy and cut in visual mode; Paste in insert mode]
inoremap    <C-V>   <C-R>+
"inoremap    <S-Insert>   <C-R>+
xnoremap    <c-c>   "+y
xnoremap    <c-x>   "+x
xnoremap    <c-y>   "ny
nnoremap    <c-p>   "np

" [backspace in Visual mode deletes selection]
vnoremap    <BS>    d

" [CTRL-S Saving, also in Insert mode]
inoremap    <c-s>   <c-o>:update<cr>
nnoremap    <c-s>   :update<cr>
xnoremap    <c-s>   <c-c>:update<cr>

" [CTRL-Z is Undo; not in cmdline though]
noremap     <C-Z> u
inoremap    <C-Z> u

" [CTRL-A is Select all]
noremap     <C-A>   gggH<C-O>G
inoremap    <C-A>   <C-O>gg<C-O>gH<C-O>G
cnoremap    <C-A>   <C-C>gggH<C-O>G
onoremap    <C-A>   <C-C>gggH<C-O>G
snoremap    <C-A>   <C-C>gggH<C-O>G
xnoremap    <C-A>   <C-C>ggVG

" [Next buffer]
nnoremap    <c-_>   :bnext<cr>

" [Switch tab pages]
"nnoremap    <c-h>   gT
"nnoremap    <c-l>   gt

" [CTRL-Tab is Next window]
" noremap     <C-Tab> <C-W>w  " 切换当前界面的窗口
noremap     <C-Tab> :tabnext<cr>
inoremap    <C-Tab> <C-O><C-W>w
cnoremap    <C-Tab> <C-C><C-W>w
onoremap    <C-Tab> <C-C><C-W>w

" [CTRL-F4 is Close window]
noremap     <C-F4>  <C-W>c
inoremap    <C-F4>  <C-O><C-W>c
cnoremap    <C-F4>  <C-C><C-W>c
onoremap    <C-F4>  <C-C><C-W>c

" [Scroll up and down in Quickfix]
"nnoremap    <c-n>   :cn<cr>
"nnoremap    <c-b>   :cp<cr>

" [Preview and switch tags]
"nnoremap    <space> <c-w>}
"nnoremap    <m-space> <c-w>g}
nnoremap    <m-]>   :tn<cr>
nnoremap    <m-[>   :tp<cr>

" [Basically you press * or # to search for the current selection !! Really useful]
vnoremap    <silent> *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap    <silent> #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" [Alt-... to mark and jump]
xmap        <m-m>   \m
nmap        <m-m>   \m
nmap        <m-n>   \/
nmap        <m-b>   \?

" [CTRL-hjkl to browse command history and move the cursor]
cnoremap    <c-k>   <up>
cnoremap    <c-j>   <down>
cnoremap    <c-h>   <left>
cnoremap    <c-l>   <right>

" [CTRL-hjkl to move the cursor in insert mode]
"inoremap    <m-k>   <c-k>
inoremap    <c-k>   <up>
inoremap    <c-j>   <down>
inoremap    <c-h>   <left>
inoremap    <c-l>   <right>

" 将当前行向下移动一行
nnoremap    <m-j>   :move.+1<cr>
" 将当前行向上移动一行
nnoremap    <m-k>   :move.-2<cr>

" [Easy indent in visual mode]
xnoremap    <       <gv
xnoremap    >       >gv

" [Search and Complete]
"cnoremap    <m-n>   <cr>/<c-r>=histget('/',-1)<cr>
cnoremap    <m-i>   <c-r>=tolower(substitute(getline('.')[(col('.')-1):],'\W.*','','g'))<cr>

" [Quick write and quit]
nnoremap    <m-q>   :quit!<cr>

" [copy paste word]
"nnoremap    <m-w>   "*yw
"nnoremap    <m-y>   "+yy
"nnoremap    <m-p>   "*p

" [Diff mode maps]
nnoremap    du      :diffupdate<cr>
xnoremap    <m-o>   :diffget<cr>
xnoremap    <m-p>   :diffput<cr>

" [Up down move]
nnoremap    j       gj
nnoremap    k       gk
nnoremap    gj      j
nnoremap    gk      k

" [Misc]
nnoremap    J       gJ
nnoremap    gJ      J
nnoremap    -       _
nnoremap    _       -

" [F2 to insert current timestamp]
nnoremap    <F2>    a<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>
inoremap    <F2>    a<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>

" [F3 to start cscope session]
nnoremap    <F3>    <C-]>

" [Jump to position by the length under cursor]
nnoremap    <silent><F5> "ly2l:call cursor(0,('0x'.@l)*2+col('.')+2)<cr>
nnoremap    <silent><S-F5> "ly4l:call cursor(0,('0x'.@l)*2+col('.')+4)<cr>

" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap    <C-U>   <C-G>u<C-U>

" [comment out current line]
nnoremap    <F12>   I/*<ESC>A*/<ESC>

" [to insert mode]
" imap        ::      <Esc>:
" [to normal mode]
"inoremap    kj      <ESC>
inoremap    ,,    <ESC>

"inoremap    <C-S-L> <ESC>"+yy

" [Sql auto complete]
" instead of iabbrev
"imap        <C-S-S> <HOME>SELECT * FROM <ESC>A;<ESC>"*yy
"imap        <C-S-U> <HOME>UPDATE <ESC>A SET ;<ESC><END>"*yy
"imap        <C-S-D> <HOME>DELETE FROM <ESC>A;<ESC><END>"*yy

" imap        <C-F4>  :tabnew
" to insert mode

" 最大化或还原
nnoremap <F11> :simalt ~x \| simalt ~r<cr>

"}}}
"===============================================================================
" Abbreviations
"===============================================================================
" Abbreviations: {{{1

iabbrev     //a     /** */<left><left><left>
iabbrev     //b     /* */<left><left><left>
iabbrev     //c     /*======== ========*/<esc>10<left>i
iabbrev     //d     -- ===========================<CR>--<CR>-- ===========================<UP>

iabbrev     :s      SELECT * FROM;<LEFT>
iabbrev     :u      UPDATE SET;<LEFT><LEFT><LEFT><LEFT><LEFT>
iabbrev     :d      DELETE FROM;<LEFT>
iabbrev     :t      TRUNCATE TABLE;<LEFT>
iabbrev     :i      INSERT INTOVALUES();<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

"}}}
"===============================================================================
" Commands
"===============================================================================
" Commands: {{{1
"--------------------------------------------------
"command!    CPPtags          !ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q .
command!    EV              tabedit $VIM/_vimrc  " edit vimrc
command!    EH              tabedit $SYSTEMROOT/system32/drivers/etc/hosts
command!    ET              tabedit $W/temp/temp.txt
command!    EO              tabedit $ORACLE/NETWORK/ADMIN/tnsnames.ora
command!    EA              tabedit $APACHE/conf/httpd.conf
command!    HEX             %!xxd

"}}}
"===============================================================================
" Menus
"===============================================================================
" Menus: {{{1
"--------------------------------------------------
"menu        &Misc.Add\ Header                     :AddHeader<cr>
"menu        &Misc.Add\ Doxygen\ Comment           :Dox<cr>
"menu        &Misc.Remove\ Comments                :RemoveComments<cr>
"menu        &Misc.-sep1-                          :
"menu        &Misc.Create\ ctags                   :CPPtags<cr>
"menu        &Misc.Astyle_format                   :ASTYLE<cr>
"menu        &Misc.Unique\ lines                   :UniqueLine<cr>
"menu        &Misc.Edit\ vimrc                     :VIMRC<cr>
"menu        &Misc.-sep2-                          :
"menu        &Misc.Utilities.Calendar              :Calendar<cr>
"menu        &Misc.Utilities.Color\ Selector       :ColorSel<cr>
menu        &Misc.Utilities.Renamer               :Renamer<cr>
menu        &Misc.Games.Toggle\ Sketch            :ToggleSketch<cr>
menu        &Misc.Games.Matrix\ ScreenSaver       :Matrix<cr>
menu        &Misc.Games.Tetris                    :Tetris<cr>
menu        &Misc.Convert.GoSimplifiedChinese     :GoSimplifiedChinese<cr>
menu        &Misc.Convert.GoTraditionalChinese    :GoTraditionalChinese<cr>
menu        &Misc.Convert.Convert\ to\ HTML       :TOhtml<cr>
menu        &Misc.Convert.Convert\ to\ ANSI       :TOansi<cr>
menu        &Misc.Convert.ScreenShot              :ScreenShot<cr>
menu        &Misc.Convert.Text\ to\ HTML          :Text2Html<cr>
menu        &Misc.Convert.Diff\ to\ HTML          :Diff2Html<cr>

"}}}
"===============================================================================
" Extend Functions
"===============================================================================
" Extend Function: {{{1
"--------------------------------------------------
command!    AddHeader        call AddHeader()
" [AddHeader() add a header to the top of the file]
function! AddHeader()
    let headerstr=[]
    let headerdict={}
    let order=['\file','\brief','\author','\date',' ','\note','\bug']
    let headerdict[order[0]]=expand("%:t")
    let headerdict[order[1]]=inputdialog("Input the brief of this file: (<=35 characters)")
    let headerdict[order[2]]=g:author
    let headerdict[order[3]]=strftime("%Y-%m-%d %H:%M:%S")
    let headerdict[order[4]]=''
    let headerdict[order[5]]='some notes'
    let headerdict[order[6]]='no bug'
    let headerstr+=["\/\*\*"]
    for i in order
        let headerstr+=[printf(" \* %s",printf("%-14s%-s",i,headerdict[i]))]
    endfor
    let headerstr+=[" \*\/"]
    call append(0,headerstr)
    call setpos(".",[0,1,1,"off"])
endfunction

" [UpdateTime() Update the timestamp in the header]
function! UpdateTime()
    for i in range(1,10)
        let tmp=getline(i)
        let time=strftime("%Y-%m-%d %H:%M:%S")
        if match(tmp,'\d\{4}-\d\{2}-\d\{2}\ \d\{2}:\d\{2}:\d\{2}')>=0
            let tmp=substitute(tmp,'\d\{4}-\d\{2}-\d\{2}\ \d\{2}:\d\{2}:\d\{2}',time,"g")
            silent call setline(i,tmp)
            break
        endif
    endfor
endfunction

" [SetupCompiler() Sets up the compiler environment]
function! SetupCompiler(name)
    if a:name=='msvc'
        compiler! msvc
        set shellpipe=>%s\ 2>&1
        set makeef=
    elseif a:name=='mingw'
        set makeprg=mingw32-make
        set shellpipe=>%s\ 2>&1
        set makeef=
    endif
        set autowrite
endfunction

" [Set up cscope environment]
function! SetupCscope()
    if has("cscope")
        set csprg=cscope
        set cscopequickfix=c-,d-,e-,f-,g-,i-,s-,t-
        set nocscopetag
        set cscopetagorder=0
        set cscopeverbose
        " add any database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
            copen
        else
            let msg="Create cscope.out here?\n".getcwd()
            let result=confirm(msg,"&Yes\n&No",1,"Question")
            if result==1
                call system("cscope -b -R")
                cs add cscope.out
                copen
            endif
        endif
    endif
endfunction

" [Doxygen comment for functions]
function! DoxFunctionComment()
    mark d
    exec "normal O/**".repeat("-",30)."\<cr>".'\brief   ...'
    let l:synopsisLine=line(".")
    let l:synopsisCol=col(".")-2
    let l:nextParamLine=l:synopsisLine+1
    exec "normal a\<cr>\<cr>".'This function ...'."\<cr>\<bs>"."/"
    exec "normal `d"
    let l:line=getline(line("."))
    let l:startPos=match(l:line, "(")
    let l:identifierRegex='\i\+[[:space:][\]]*[,)]'
    let l:matchIndex=match(l:line,identifierRegex,l:startPos)
    let l:foundParam=0
    while l:matchIndex >= 0
        let l:foundParam=1
        exec "normal ".(l:matchIndex + 1)."|"
        let l:param=expand("<cword>")
        exec l:nextParamLine
        exec "normal O".'\param   '.l:param."   ..."
        let l:nextParamLine=l:nextParamLine+1
        exec "normal `d"
        let l:startPos=(l:matchIndex+strlen(l:param)+1)
        let l:matchIndex=match(l:line,identifierRegex,l:startPos)
    endwhile
    exec l:nextParamLine
    exec 'normal O\return  ...'
    exec l:synopsisLine
    exec "normal ".l:synopsisCol."|"
endfunction

" [Highlight column matching { } pattern]
let s:hlflag=0
function! ColumnHighlight()
    let c=getline(line('.'))[col('.') - 1]
    if c=='{' || c=='}'
        set cuc
        let s:hlflag=1
    else
        if s:hlflag==1
            set nocuc
            let s:hlflag=0
        endif
    endif
endfunction

" [Delete abbrvation tail character]
"function! Eatchar(pat)
"    let c = nr2char(getchar())
"    return (c =~ a:pat) ? '' : c
"endfunction

command!    -range UniqueLine     <line1>,<line2>call UniqueLine()
" [Let the same line combine together]
function! UniqueLine() range
    let l1 = a:firstline
    let l2 = a:lastline
    while l1<=l2
        call cursor(l1,1)
        let lineCount=0
        let lineData=getline(l1)
        if lineData==''
            execute l1." d"
            let l2-=1
        else
            let lineDataEsc=escape(lineData,'\\/.*$^~[]')
            while search('^'.lineDataEsc.'$','c',l2)>0
                execute "d"
                let l2-=1
                let lineCount+=1
            endwhile
            let lineData=lineCount."\t".lineData
            call append(l1-1,[lineData])
            let l2+=1
            let l1+=1
        endif
    endwhile
endfunction

" [AutoComplete functions]
let s:min_len = 2
fun! AutoComplete()
    let length = strlen(matchstr(getline('.')[:col('.')-2],'\w*$'))
    if length != s:min_len
        return ''
    else
        return "\<c-x>\<c-n>\<c-p>"
    endif
endfun

fun! DoAutoComplete()
    let letter = char2nr("a")
    while letter <= char2nr("z")
        execute "inoremap <buffer>" nr2char(letter) nr2char(letter) . "<c-r>=AutoComplete()<CR>"
        let letter = letter + 1
    endwhile
    let letter = char2nr("A")
    while letter <= char2nr("Z")
        execute "inoremap <buffer>" nr2char(letter) nr2char(letter) . "<c-r>=AutoComplete()<CR>"
        let letter = letter + 1
    endwhile
endfun

fun! StopAutoComplete()
    let letter = char2nr("a")
    while letter <= char2nr("z")
        execute "silent! iunmap <buffer>" nr2char(letter)
        let letter = letter + 1
    endwhile
    let letter = char2nr("A")
    while letter <= char2nr("Z")
        execute "silent! iunmap <buffer>" nr2char(letter)
        let letter = letter + 1
    endwhile
endfun

"{{{ whitespace  去除文件的行尾空白
function! WhitespaceStripTrailing()
    let previous_search=@/
    let previous_cursor_line=line('.')
    let previous_cursor_column=col('.')
    %s/\s\+$//e
    let @/=previous_search
    call cursor(previous_cursor_line, previous_cursor_column)
endfunction

autocmd BufWritePre     *.py        call WhitespaceStripTrailing()
autocmd BufWritePre     *.h         call WhitespaceStripTrailing()
autocmd BufWritePre     *.c         call WhitespaceStripTrailing()
autocmd BufWritePre     *.cpp       call WhitespaceStripTrailing()
autocmd BufWritePre     *.js        call WhitespaceStripTrailing()
"}}}

"}}}

