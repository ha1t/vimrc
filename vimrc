""
" vim: set fileencoding=utf-8
"
" vimrc
"
" @author halt
"

set runtimepath^=~/.vim

call plug#begin('~/.vim/plugged')

Plug 'cocopon/vaffle.vim'
Plug 'fatih/vim-go'
Plug 'flyinshadow/php_localvarcheck.vim'
Plug 'kana/vim-arpeggio'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-smartinput'
Plug 'kana/vim-smartword'
Plug 'karakaram/vim-quickrun-phpunit'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'
Plug 'othree/yajs.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'taku-o/vim-toggle'
Plug 'thinca/vim-quickrun'
Plug 'tjennings/git-grep-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-haml'
Plug 'vim-scripts/yanktmp.vim'
Plug 'vim-scripts/dbext.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'rhysd/vim-color-spring-night'
"Plug 'dense-analysis/ale'


" theme
Plug 'mhartington/oceanic-next'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'fatih/molokai'

" ftplugin
Plug 'moro/vim-review'
call plug#end()

let g:toggle_pairs = {
  \'and':'or', 'or':'and',
  \'==':'!=','!=':'==',
  \'=':'->', '->':'=',
  \'<=':'>=','>=':'<=',
  \'class':'extends', 'extends':'class',
  \}

" 0.2.2 -> 022 を返す(けど最上位桁が0なので…)
function! GetNVimVersion()
       redir => s
       silent! version
       redir END
       return substitute(matchstr(s, 'NVIM v\zs[^\n]*'), "\\.", "", "g")
endfunction

""
" environment
"

""
" set
"
if has('nvim')
  if GetNVimVersion() <= 022
    let g:go_version_warning = 0
  endif
  "set termguicolors
else
  set nocompatible
  set encoding=utf-8
endif

set autoindent
set ambiwidth=double
set backup
set backupdir=~/.vimbackup
"set background=dark
set backspace=indent,eol,start
set helplang=ja,en
set noruler
set wildmenu
set wildmode=longest,list
set number
set showcmd
set noshowmatch
set notagbsearch " http://d.hatena.ne.jp/vikke_bsd/20110926
set laststatus=2
set ignorecase
set smartcase
set listchars=tab:>-
set list
set wrapscan
"set smartindent
set nohlsearch
set nofoldenable
set foldmethod=marker

set complete&
set complete+=k
set completeopt=menuone
set showfulltag

set matchpairs=(:),{:},[:],<:>
"set matchtime=5
"set tags+=$HOME/.vim/systags
set history=10000
set cursorline
set nocursorcolumn
set splitbelow
set splitright

let loaded_matchparen = 1
"let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/proc.so'

if has("gui_running")
  " フォント設定 from http://memo.xight.org/2007-11-01-2
  if has("gui_win32")
    " set guifont=ＭＳ_ゴシック:h9:cSHIFTJIS
    "set guifont=meiryo:h12:cSHIFTJIS
    "set guifont=メイリオ:h9:cSHIFTJIS
    "set printfont=ＭＳ_ゴシック:h10:cSHIFTJIS
    " set printfont=メイリオ:h10:cSHIFTJIS
    autocmd GUIEnter * winpos 200 100
    autocmd GUIEnter * winsize 100 50
  endif
endif

if has('persistent_undo')
  set undodir=~/.vimundo
  set undofile
endif

"set swap file directory
let &directory = &backupdir
let mapleader = ","
let g:netrw_keepdir=0

let hostname = system('hostname')
let hostname = strpart(hostname, 0, strlen(hostname)-1)

let is_mac = (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')

"colorscheme rdark-terminal
"colorscheme desert256
"colorscheme vitamins

if 'anubis' == hostname
  colorscheme Tomorrow-Night-Blue
else
  "colorscheme OceanicNext
  set background=dark
  "colorscheme Tomorrow-Night-Bright
endif

filetype indent on
filetype plugin on

""
" highlight
"

"highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=grey
"highlight StatusLineNC term=NONE cterm=bold ctermfg=black ctermbg=grey
"highlight LineNr       ctermfg=lightgreen
"highlight CursorLine ctermfg=Blue
"highlight CursorColumn ctermfg=Green

"highlight Pmenu       ctermfg=black ctermbg=gray
"highlight PmenuSel    ctermfg=blue  ctermbg=white
"highlight PmenuSbar   ctermfg=black

"highlight TabLine     term=NONE cterm=NONE  ctermfg=black ctermbg=grey
"highlight TabLineSel  term=NONE cterm=bold  ctermfg=red ctermbg=white
"highlight TabLineFill term=NONE cterm=NONE  ctermfg=black ctermbg=grey

" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=white ctermbg=red
match ZenkakuSpace /　/

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space.
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

""
" ctags_load vimtagsに配置されたtagsファイルを状況に応じて開く
"
" @url http://d.hatena.ne.jp/thinca/20091009/1255059006
" @url http://vim.1045645.n5.nabble.com/Vim-script-not-show-path-td1192891.html
"
function! s:ctags_load()
  let tags_dir = '~/.vimtags'
  let tagfiles = split(glob(tags_dir . '/*'), "\n")
  for tagfile in tagfiles
    let tagfile_filename = substitute(tagfile, fnamemodify(expand(tagfile), ":h"), "", "")
    let tagfile_filename = substitute(tagfile_filename, "_", "/", "g")
    let tagfile_filename = substitute(tagfile_filename, "//", "/", "g")
    let tagfile_dir = fnamemodify(tagfile_filename, ":r")
    if expand("%:p:h") == tagfile_dir
      " echo "LOADED CTAGS:" . tagfile
      let &tags = tagfile
    endif
  endfor
endfunction

""
" ctags_loadに対応したtagsファイルを作る
" プロジェクトルートにいるときだけ実行できる。
" tagsのファイル名を、home_halt_src_project.tagsにする
"
function! s:ctags_create()
  let is_project_root = isdirectory(expand("%:p:h") . "/.git")
  if is_project_root
    let tags_filename = substitute(expand("%:p:h"), "/", "_", "g") . ".tags"
    let command = "ctags -R --languages=PHP --tag-relative=yes --php-types=cifd -f ~/.vimtags/" . tags_filename . " " . expand("%:p:h")
    echo command
    let result = system(command)
    echo result
  endif
endfunction

command! CtagsCreate :call s:ctags_create()
command! CtagsLoad :call s:ctags_load()

call s:ctags_load()

""
" NeoVim Config
"
if has('nvim')
      tnoremap <Esc> <C-\><C-n>
endif

noremap ; :
noremap : ;

" http://vim-users.jp/2011/04/hack214/
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

""
" highlight setting
"
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#

nnoremap <Space>w :<C-u>write<Enter>
nnoremap <Space>q :<C-u>q<Enter>

nnoremap <Space>l :<C-u>ls<Enter>
nnoremap <Space>d :<C-u>bd<Enter>

" http://vim-users.jp/2010/02/hack122/
nnoremap Y y$

nnoremap <C-r> :<C-u>TagbarToggle<Return>

" http://relaxedcolumn.blog8.fc2.com/blog-entry-146.html
" http://vim.g.hatena.ne.jp/tyru/20100106
"let g:arpeggio_timeoutlen = 50
"call arpeggio#load()
"Arpeggio inoremap jf <Esc>
"Arpeggio inoremap jc class<Space>
"Arpeggio inoremap jf function<Space>
"Arpeggio inoremap jp ()<Left>
"Arpeggio inoremap jb {}<Left>
"Arpeggio inoremap jd <C-R>=strftime('%Y/%m/%d (%a)')<CR>

""
" vimgrep list search
"
" @see http://subtech.g.hatena.ne.jp/secondlife/20070601/1180700503
"
nnoremap g/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<CR>

""
" 画面分割
" TODO: 簡単に閉じれるように
"
nnoremap <silent> <Leader>d :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>

""
" paste/nopaste
"
nnoremap ep :<C-u>setlocal invpaste<CR>

" http://nanasi.jp/articles/code/command/command.html
command! EditVimrc :edit $MYVIMRC
command! ReloadVimrc :source $MYVIMRC

" 文字コードを変えて最読込
command! -bang -complete=file -nargs=? Utf8
  \ edit<bang> ++enc=utf-8 <args>

command! -bang -complete=file -nargs=? Eucjp
  \ edit<bang> ++enc=euc-jp <args>

command! -bang -complete=file -nargs=? Sjis
  \ edit<bang> ++enc=cp932 <args>

command! -bang -complete=file -nargs=? JIS
  \ edit<bang> ++enc=iso-2022-jp <args>

"""
" autocmd
"
augroup MyAutoCmd
  autocmd!
augroup END

" http://saihoooooooo.hatenablog.com/entry/2013/05/24/130744
function! s:GetBufByte()
    let byte = line2byte(line('$') + 1)
    if byte == -1
        return 0
    else
        return byte - 1
    endif
endfunction

augroup VimStartup
  autocmd!
  autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | Vaffle | endif
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
  " .vimrcの再読込時にも色が変化するようにする
  autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
  " .vimrcの再読込時にも色が変化するようにする
  autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC |
    \if has('gui_running') | source $MYGVIMRC
  autocmd MyAutoCmd BufWritePost $MYGVIMRC |
    \if has('gui_running') | source $MYGVIMRC
endif

augroup filetypedetect
  autocmd BufNewFile,BufRead *.xt  setfiletype xt " xdebug
  autocmd BufNewFile,BufRead *.applescript setfiletype applescript
  autocmd BufNewFile,BufRead *.ctp setfiletype php
  autocmd BufNewFile,BufRead *.phpt setfiletype phpt
  autocmd BufNewFile,BufRead *.maml setfiletype maml
augroup END

""
" カレントウィンドウにのみ罫線を引く
" @see http://nanabit.net/blog/2007/11/03/vim-cursorline/
"
autocmd MyAutoCmd WinLeave * set nocursorline
autocmd MyAutoCmd WinEnter,BufRead * set cursorline

""
" Load template
"
" @see http://d.hatena.ne.jp/lurker/20060524/1148477250
"
"autocmd MyAutoCmd BufNewFile *.php 0r $HOME/.vim/template/php.txt | exe "normal G"
"autocmd MyAutoCmd BufNewFile *.rb 0r $HOME/.vim/template/ruby.txt | exe "normal G"

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

function! s:on_FileType_vim()
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal expandtab
  setlocal foldenable
  setlocal foldmethod=marker
endfunction
autocmd MyAutoCmd FileType vim call s:on_FileType_vim()

" on_FileType_phpt " {{{
autocmd MyAutoCmd FileType phpt call s:on_FileType_phpt()

function! s:on_FileType_phpt()
  syn include @phpTest syntax/php.vim
  syn region phpTest matchGroup=phpData start="^--FILE--" keepend end="^--" contains=@phpTest
   
  if !exists('g:phpt_file')
    let g:phpt_file = '/tmp/vimphpt'
  endif

  nmap ,e :call s:PhptExecute()<CR>
  nmap ,l :call s:PhptLint()<CR>
endfunction

function! s:PutPHPTTemplate()
  let @z .= "--TEST--\n"
  let @z .= "test title\n"
  let @z .= "--SKIPIF--\n"
  let @z .= "<?php\n"
  let @z .= "\n"
  let @z .= "?>\n"
  let @z .= "--POST--\n"
  let @z .= "--POST_RAW--\n"
  let @z .= "--GET--\n"
  let @z .= "--COOKIE--\n"
  let @z .= "--STDIN--\n"
  let @z .= "--INI--\n"
  let @z .= "--ARGS--\n"
  let @z .= "--ENV--\n"
  let @z .= "--FILE--\n"
  let @z .= "<?php\n"
  let @z .= '//@see http://qa.php.net/write-test.php'
  let @z .= "\n\n"
  let @z .= "?>\n"
  "let @z .= "--EXPECT--\n"
  let @z .= "--EXPECTF--\n"
  "let @z .= "--EXPECTREGEX--\n"
  put! z
endfunction

function! s:PhptLint()
  let lines = getline(0, line('$'))

  let php_code = []
  let lines_index = 0
  let file_flag = 0
  let linevalue = get(lines, lines_index, '--NONE--')

  while linevalue != '--NONE--'

    if linevalue == '--EXPECT--'
      break
    endif

    if file_flag == 1
      let linevalue = substitute(linevalue, '__FILE__', "'" . expand("%:p") . "'", 'g')
      let php_code += [linevalue]
    endif

    if linevalue == '--FILE--'
      let file_flag = 1
    endif

    let lines_index += 1
    let linevalue = get(lines, lines_index, '--NONE--')
  endwhile

  call writefile(php_code, g:phpt_file, 'b')

  let result = system('php -l ' . g:phpt_file)
  echo result
endfunction

function! s:PhptExecute()
  let lines = getline(0, line('$'))

  let php_code = []
  let lines_index = 0
  let file_flag = 0
  let linevalue = get(lines, lines_index, '--NONE--')

  while linevalue != '--NONE--'

    if linevalue == '--EXPECT--'
      break
    endif

    if file_flag == 1
      let linevalue = substitute(linevalue, '__FILE__', "'" . expand("%:p") . "'", 'g')
      let php_code += [linevalue]
    endif

    if linevalue == '--FILE--'
      let file_flag = 1
    endif

    let lines_index += 1
    let linevalue = get(lines, lines_index, '--NONE--')
  endwhile

  call writefile(php_code, g:phpt_file, 'b')

  let result = system('php ' . g:phpt_file)
  echo result
endfunction

" }}}

function! s:on_FileType_html()
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal expandtab
endfunction
autocmd MyAutoCmd FileType html call s:on_FileType_html()

function! s:on_FileType_css()
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal expandtab
endfunction
autocmd MyAutoCmd FileType css call s:on_FileType_css()

function! s:on_FileType_python()
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal expandtab
endfunction
autocmd MyAutoCmd FileType python call s:on_FileType_python()

function! s:on_FileType_ruby()
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal expandtab
endfunction
autocmd MyAutoCmd FileType ruby call s:on_FileType_ruby()

function! s:on_FileType_javascript()
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal expandtab
endfunction
autocmd MyAutoCmd FileType javascript call s:on_FileType_javascript()

function! s:on_FileType_json()
  setlocal conceallevel=0
endfunction
autocmd MyAutoCmd FileType json call s:on_FileType_json()

" on_FileType_go " {{{
function! s:on_FileType_go()
  setlocal noexpandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal softtabstop=0

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  let g:go_fmt_command = 'goimports'

  let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
          \ 'p:package',
          \ 'i:imports:1',
          \ 'c:constants',
          \ 'v:variables',
          \ 't:types',
          \ 'n:interfaces',
          \ 'w:fields',
          \ 'e:embedded',
          \ 'm:methods',
          \ 'r:constructor',
          \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
          \ 't' : 'ctype',
          \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
          \ 'ctype' : 't',
          \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
  \ }

  execute ":TagbarOpen"

endfunction
autocmd MyAutoCmd FileType go call s:on_FileType_go()
" }}}

" on_FileType_maml " {{{
function! s:on_FileType_maml()
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal softtabstop=4

  let s:maml_convert = expand('%:p:h:h:h:h') . '/console/maml-convert'

  if executable(s:maml_convert)
    autocmd BufWritePost <buffer> call system(s:maml_convert)
  endif
endfunction
autocmd MyAutoCmd FileType maml call s:on_FileType_maml()
" }}}

" on_FileType_php " {{{
autocmd MyAutoCmd FileType php call s:on_FileType_php()
function! s:on_FileType_php()
  let php_sql_query     = 1
  let php_baselib       = 0
  let php_htmlInStrings = 1
  let php_oldStyle      = 0
  let php_folding       = 0

  let PHP_BracesAtCodeLevel = 0

  let g:php_localvarcheck_enable = 1
  let g:php_localvarcheck_global = 0

  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal expandtab
  "setlocal dictionary=$HOME/.vim/dict/php.dict
  setlocal omnifunc=phpcomplete#CompletePHP
  setlocal runtimepath+=$HOME/.vim/php
  setlocal keywordprg="help"

  inoremap <buffer> <Tab> <Esc>:<C-u>call <SID>SmartTab()<Return>a
  nnoremap <buffer> <Tab> <Esc>:<C-u>call <SID>SmartTab()<Return><Right>

  ""
  " ale
  let g:ale_php_phpcs_standard = 'PSR2'

  ""
  " Align.vim
  " @TODO 本当はどっちも=にして自動で判別したい
  vnoremap <buffer> = :<C-u>'<,'>Align =<Return>
  vnoremap <buffer> a :<C-u>'<,'>Align =><Return>

  ""
  " smartchr
  "
  "inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
  "inoremap <buffer> <expr> . smartchr#one_of(' . ', '.')

"  smartchrみたいな感じでキーを押すと AAA -> BBB -> CCCになるプラグインがほしい

  setlocal include=\\\(require\\\|include\\\)\\\(_once\\\)\\\?
  setlocal iskeyword+=$
  if exists("loaded_matchit")
    let b:match_words = '<?php:?>,\<switch\>:\<endswitch\>,' .
          \ '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
          \ '\<while\>:\<endwhile\>,' .
          \ '\<do\>:\<while\>,' .
          \ '\<for\>:\<endfor\>,' .
          \ '\<foreach\>:\<endforeach\>,' .
          \ '(:),[:],{:},'
    if exists("s:match_words")
      let b:match_words = b:match_words . s:match_words
    endif
  endif

  " Section jumping: [[ and ]] provided by Antony Scriven <adscriven at gmail dot com>
  let s:function = '\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function'
  let s:class = '\(abstract\s\+\|final\s\+\)*class'
  let s:interface = 'interface'
  let s:section = '\(.*\%#\)\@!\_^\s*\zs\('.s:function.'\|'.s:class.'\|'.s:interface.'\)'
  execute 'nno <buffer> <silent> [[ ?' . escape(s:section, '|') . '?<CR>:nohls<CR>'
  execute 'nno <buffer> <silent> ]] /' . escape(s:section, '|') . '/<CR>:nohls<CR>'
  execute 'ono <buffer> <silent> [[ ?' . escape(s:section, '|') . '?<CR>:nohls<CR>'
  execute 'ono <buffer> <silent> ]] /' . escape(s:section, '|') . '/<CR>:nohls<CR>'

  execute ":TagbarOpen"
  execute ":TagbarSetFoldlevel 2"

  ""
  " 同一ファイル内にある定義元の関数やクラスに移動
  "
  nnoremap <buffer> gF viwy :exec '/function \+' . getreg('0')<CR>
  nnoremap <buffer> gC viwy :exec '/class \+' . getreg('0')<CR>

  ""
  " PHP lint
  " @see http://vim.g.hatena.ne.jp/ka-nacht/20090715/1247620578
  "
  nnoremap <buffer> ,l  :<C-u>execute '!' &l:filetype '-l' shellescape(expand('%'))<Return>

  ""
  " errormarker.vim
  "
  " @see http://subtech.g.hatena.ne.jp/secondlife/20080729/1217315593
  if executable('vimparse.php')
    setlocal makeprg=vimparse.php\ %\ $*
    setlocal errorformat=%f:%l:%m
    setlocal shellpipe=2>&1\ >
    autocmd BufWritePost <buffer> silent make
  endif

"  call smartinput#clear_rules()
  call textobj#user#plugin('php', {
  \   'phptag': {
  \       '*pattern*': ['<?\(=\|php\)\?[\r\n\s]*','[\r\n\s]*?>'],
  \       'select-a': 'aP',
  \       'select-i': 'iP',
  \   },
  \})
endfunction

" ()の中にいるときに<TAB>で抜ける
function! s:SmartTab()
  if matchstr(getline(line(".")), ")", col(".")) == ")"
    execute ":normal a\<Esc>f)"
  else
    if (mode() == "i")
      execute ":normal a \<Esc>r\<Tab>"
    endif
  endif
endfunction

" }}}

" vim plugin setting " {{{

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'right': [ [ 'syntastic', 'lineinfo' ],
  \              [ 'percent' ], [ 'winform' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'branch', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive'
  \ }
  \ }

" ctrlp.vim
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<c-h>', '<bs>', '<c-]>'],
  \ 'PrtDelete()':          ['<del>'],
  \ 'PrtDeleteWord()':      ['<c-w>'],
  \ 'PrtClear()':           ['<c-u>'],
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
  \ 'PrtHistory(-1)':       ['<c-k>'],
  \ 'PrtHistory(1)':        ['<c-j>'],
  \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
  \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
  \ 'AcceptSelection("t")': ['<c-t>', '<MiddleMouse>'],
  \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
  \ 'ToggleFocus()':        ['<s-tab>'],
  \ 'ToggleRegex()':        ['<c-r>'],
  \ 'ToggleByFname()':      ['<c-d>'],
  \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
  \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
  \ 'PrtExpandDir()':       ['<tab>'],
  \ 'PrtInsert("w")':       ['<F2>', '<insert>'],
  \ 'PrtInsert("s")':       ['<F3>'],
  \ 'PrtInsert("v")':       ['<F4>'],
  \ 'PrtInsert("+")':       ['<F6>'],
  \ 'PrtCurStart()':        ['<c-a>'],
  \ 'PrtCurEnd()':          ['<c-e>'],
  \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
  \ 'PrtCurRight()':        ['<c-l>', '<right>'],
  \ 'PrtClearCache()':      ['<F5>'],
  \ 'PrtDeleteMRU()':       ['<F7>'],
  \ 'CreateNewFile()':      ['<c-y>'],
  \ 'MarkToOpen()':         ['<c-z>'],
  \ 'OpenMulti()':          ['<c-o>'],
  \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
  \ }

" toggle.vim
nnoremap <C-t> <Plug>(ToggleN)

" git grep
"nnoremap <unique> gG :exec ':silent GitGrep ' . expand('<cword>')<CR>

if &background == 'dark'
  highlight IndentGuidesOdd  ctermbg=234
  highlight IndentGuidesEven ctermbg=233
else
  highlight IndentGuidesOdd  ctermbg=134
  highlight IndentGuidesEven ctermbg=133
endif

""
" quickrun
"
let g:quickrun_config = {}

" http://d.hatena.ne.jp/mFumi/20100301/1267431727
let g:quickrun_config.applescript = {'command' : 'osascript', 'output' : '_'}
let g:quickrun_no_default_key_mappings = 1
nnoremap <silent> <Leader>e :<C-u>QuickRun<CR>

""
" vim-quickrun-phpunit
" @url http://www.karakaram.com/vim/phpunit-location-list/
"
augroup QuickRunPHPUnit
  autocmd!
  autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.phpunit
  autocmd BufWinEnter,BufNewFile *_test.php set filetype=php.phpunit
augroup END
let g:quickrun_config['php.phpunit'] = {}
let g:quickrun_config['php.phpunit']['outputter'] = 'phpunit'
let g:quickrun_config['php.phpunit']['command'] = 'phpunit'
let g:quickrun_config['php.phpunit']['exec'] = '%c %o %s'
let g:quickrun_config['php.phpunit']['outputter/phpunit/height'] = 3
let g:quickrun_config['php.phpunit']['outputter/phpunit/running_mark'] = 'running...'
let g:quickrun_config['php.phpunit']['outputter/phpunit/auto_open'] = 0

""
" vim-easymotion
"
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
nnoremap <silent> <Leader>w :call EasyMotion#WBW(0, 0)<CR>
vnoremap <silent> <Leader>w :<C-U>call EasyMotion#WBW(1, 0)<CR>

nnoremap <silent> <Leader>W :call EasyMotion#WBW(0, 1)<CR>
vnoremap <silent> <Leader>W :<C-U>call EasyMotion#WBW(0, 1)<CR>

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""
" tagbar
"
let g:tagbar_width = 60

""
" yanktmp & pbcopy
"
let g:yanktmp_file = $HOME . '/.vimyanktmp'
nnoremap <silent> sy :call YanktmpYank()<CR>
vnoremap <silent> sy :call YanktmpYank()<CR>
nnoremap <silent> sp :call YanktmpPaste_p()<CR>
nnoremap <silent> sP :call YanktmpPaste_P()<CR>
" }}}

" for debug
"function! SymbolUnderCursor(tran)
"  return synIDattr(synID(line("."),col("."), a:tran),"name")
"endfunction

syntax on

if has("gui_running")
  "gui
  colorscheme spring-night

"  set guifont=Cica:h14

endif

function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)

" http://vim-users.jp/2010/04/hack141/
" A,B,CをB,C,Aにする
" TODO: vabの中身をとって処理する
" TODO: 結果を置き換える
"function! g:flip(word)
"  let items = split(a:word, ',')
"  let result = ''
"  for item in items
"    if result == ''
"      let result = item
"    else
"      let result = item . ',' . result
"    endif
"  endfor
"  echo result
"endfunction

set secure
