" ==================================================
" Author:         aXen
" EMail:          BusyAnt@qq.com
" Blog:           http://blog.busyant.cn
" Create Date:    2010-08-13 10:18:58
" Last Modified:  
"
" ==================================================


" [enable vim extensions to vi]
" This options will reset some options like 'formatoptions"
" those who will be changed when reloading this file,
" and when loading the .vimrc,nocompatible is always set
"set nocompatibleset nocompatible

if v:progname =~? "evim"
    finish
endif

let author='aXen<BusyAnt@qq.com>'
let email='BusyAnt@qq.com'
let blog='http://aXen.cnblogs.cn'
let truename='aXen<BusyAnt@qq.com>'

let $D='~\Desktop'
let $Doc='~\Documents'
let $W='F:\'

" Options: {{{1
"--------------------------------------------------
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
"

" { behavior }
" /*--------------------

" [autocmd]
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

" [diff options]
set diffopt=filler,vertical  " 显示填充行，垂直分割 

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" [backup]
if has("vms")
    set nobackup  " do not keep a backup file, use versions instead
else
    set backup  " keep a backup file
endif

" [mouse]
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a  " a：所有模式
    set mousemodel=popup  " 鼠标右键的工作方式，详见鼠标工作方式总览
endif

" [encoding]
if has("win32")
    set encoding=prc
    setglobal fenc=utf-8  " 读入文件时，'fileencoding' 会根据 'fileencodings' 进行设置。
    set langmenu=zh_CN.utf-8  " 本选项必须在载入菜单、打开文件类型检测或语法高亮之前设置。一旦定义了菜单，本选项就不再有效果。
    set termencoding=prc
    set fencs=usc-bom,utf-8,prc,gb18030,big5,iso-8859-1
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

set helplang=cn  " 帮助语言

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set splitright  " 窗口的分割会把新窗口放到当前窗口之右。
set selectmode=""
set undolevels=1000
set updatetime=500
set wrap

set history=50	" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch	" do incremental searching
set nocompatible
set browsedir="C:\Users\BusyAnt\Desktop"  " 文件浏览器的路径

" --------------------*/


" { format }
" /*--------------------

" [tab stop options]
set tabstop=4  " 文件里的 <Tab> 代表的空格数
set shiftwidth=4  " (自动) 缩进每一步使用的空白数目。用于 |'cindent'|、|>>|、|<<| 等
set softtabstop=0  " 执行编辑操作，如插入 <Tab> 或者使用 <BS> 时，把 <Tab> 算作空格的数目:
set expandtab
set smarttab

set listchars=tab:>-  " tab符显示样式

" set autoindent
" set smartindent
set ambiwidth=double
set noautoread
set completeopt=menuone
set display=lastline,uhex
set fillchars=vert:\|,fold:-
set formatoptions+=Mmn
set guioptions=egmrt
set guitablabel=%{tabpagenr()}.%t\ %m
set ignorecase smartcase  " 模式匹配忽略大小写
set laststatus=2
set linespace=1
set number
set numberwidth=2
set previewheight=8
set report=2
set scroll=8
set statusline=%f%m\ \[%{&ff}:%{&fenc}:%Y]\ %{getcwd()}%=(%b,0x%B)(%l\/%L\|%c%V)%P%<
set selection=inclusive
set virtualedit=block
set whichwrap+=<,>,[,]
set wildmenu
set winaltkeys=no

" --------------------*/


" { display }
" /*--------------------

" [color]
"colorscheme evening
colorscheme molokai

" [font]
if has("win32")
    set guifontwide=NSimSun:h10.5:i 
    set guifont=Courier\ New:h10.5:i 
    "set guifont=Bitstream_Vera_Sans_Mono:i:h10,Fixedsys:h10.5
    "set guifont=新宋体:h11   
elseif has("unix")
    set guifont=Bitstream\ Vera\ Sans\ Mono\ Oblique\ 10.5,Fixedsys\ Excelsior\ 2.00\ 11
    set guifontwide=NSimSun\ 11
endif

" [highlight]
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" --------------------*/


" Key Maps: {{{1
"--------------------------------------------------

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
nnoremap    <c-h>   gT
nnoremap    <c-l>   gt

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

" [Scroll]
nnoremap    <c-j>   <c-e>
nnoremap    <c-k>   <c-y>

" [Scroll up and down in Quickfix]
nnoremap    <c-n>   :cn<cr>
nnoremap    <c-b>   :cp<cr>

" [Cscope hot keys]
"nnoremap    gnc     :cs find c <c-r>=expand("<cword>")<cr><cr>
"nnoremap    gnd     :cs find d <c-r>=expand("<cword>")<cr><cr>
"nnoremap    gne     :cs find e <c-r>=expand("<cword>")<cr><cr>
"nnoremap    gnf     :cs find f <c-r>=expand("<cfile>")<cr><cr>
"nnoremap    gng     :cs find g <c-r>=expand("<cword>")<cr><cr>
"nnoremap    gni     :cs find i ^<c-r>=expand("<cfile>")<cr>$<cr>
"nnoremap    gns     :cs find s <c-r>=expand("<cword>")<cr><cr>
"nnoremap    gnt     :cs find t <c-r>=expand("<cword>")<cr><cr>

" [Preview and switch tags]
nnoremap    <space> <c-w>}
nnoremap    <m-space> <c-w>g}
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
" nnoremap    <m-w>   :write<cr>
nnoremap    <m-q>   :quit<cr>

" [copy paste word]
nnoremap    <m-w>   "*yw
nnoremap    <m-y>   "+yy
nnoremap    <m-p>   "*p

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

" [F2 to toggle the winmanager]
"nnoremap    <F2>    :WMToggle<cr>
nnoremap    <F2>    a<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>

" [F3 to start cscope session]
"nnoremap    <F3>    :call SetupCscope()<cr>
nnoremap    <F3>    <C-]>

" [F4 to toggle the taglist]
"nnoremap    <F4>    :TlistToggle<cr>

" [Jump to position by the length under cursor]
nnoremap    <silent><F5> "ly2l:call cursor(0,('0x'.@l)*2+col('.')+2)<cr>
nnoremap    <silent><S-F5> "ly4l:call cursor(0,('0x'.@l)*2+col('.')+4)<cr>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap    <C-U>   <C-G>u<C-U>

" [comment out current line]
nnoremap    <F12>   I/*<ESC>A*/<ESC>

" [to insert mode]
" imap        ::      <Esc>:
" [to normal mode]
"inoremap    kj      <ESC>

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

" Abbreviations: [no use when using code_complete plugin] {{{1
"--------------------------------------------------
iabbrev     //a     /** */<left><left><left>
iabbrev     //b     /* */<left><left><left>
iabbrev     //c     /*======== ========*/<esc>10<left>i
iabbrev     //d     -- ===========================<CR>--<CR>-- ===========================<UP>

"iabbrev     #f      #ifndef  <C-R>=GetFileName()<cr><cr>#define  <C-R>
"                    \=GetFileName()<cr><cr><cr><cr><cr>#endif  /*<C-R>
"                    \=GetFileName()<cr>*/<esc>
"iabbrev     #d      #define<C-R>=Eatchar('\s')<cr>
"iabbrev     #i      #include<C-R>=Eatchar('\s')<cr>
"iabbrev     xtime   <C-R>=strftime("%Y-%m-%d %H:%M:%S")<cr><C-R>=Eatchar('\s')<cr>
"iabbrev     if(     if(<Esc>mxa)<cr>{<cr>}<Esc>`xa<C-R>=Eatchar('\s')<cr>
"iabbrev     for(    for(<Esc>mxa)<cr>{<cr>}<Esc>`xa<C-R>=Eatchar('\s')<cr>

iabbrev     :s      SELECT * FROM;<LEFT>
iabbrev     :u      UPDATE SET;<LEFT><LEFT><LEFT><LEFT><LEFT>
iabbrev     :d      DELETE FROM;<LEFT>
iabbrev     :t      TRUNCATE TABLE;<LEFT>
iabbrev     :i      INSERT INTOVALUES();<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

" Commands: {{{1
"--------------------------------------------------
"command!    ToggleSketch     call ToggleSketch()
"command!    AddHeader        call AddHeader()
"command!    Dox              call DoxFunctionComment()
"command!    RemoveComments   %s/\/\*\_.\{-}\*\///g
"command!    CPPtags          !ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q .
"command!    VIMRC            tabedit $VIMRUNTIME/../_vimrc
command!    EV              tabedit $VIM/_vimrc  " edit vimrc
command!    EH              tabedit $SYSTEMROOT/system32/drivers/etc/hosts 
command!    ET              tabedit $W/temp/temp.txt
"command!    EA              tabedit E:/Apache Software Foundation/Apache2.2/conf/httpd.conf
" 当前缓冲区所有内容执行外部命令: xxd(一个exe文件)
command!    HEX             %!xxd
"command!    -range UniqueLine     <line1>,<line2>call UniqueLine()
"command!    ASTYLE           !astyle --mode=c --style=ansi --indent=spaces=4 --indent-switches --indent-preprocessor %
"command!    -range=% Uniq3          <line1>,<line2>g/^\%<<line2>l\(.*\)\n\1$/d
"command!    -range=% -nargs=? Nl    <line1>,<line2>s/^/\=printf("%"."<args>"."d ",line(".")-<line1> + 1)/
"command!    DiffOrig         vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis


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

" Extend Function: {{{1
"--------------------------------------------------

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



