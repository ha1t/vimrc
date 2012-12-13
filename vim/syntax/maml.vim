" Vim syntax file
" Language:    maml
" https://sites.google.com/site/vimdocja/syntax-html#:syn-qstart
"
if version < 700
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'maml'
endif

"syntax include @html <sfile>:p:h/html.vim
runtime! syntax/html.vim
unlet b:current_syntax

syntax region htmlString start=/"/ end=/"/ contained contains=@html, mamlEVariable, mamlVariable

syntax match mamlHeading         +^\*\{1,3}\(\w\+\*\)\=.\+$+ 

syntax match mamlInlineCode      +(^|\n| \+)\- \(\w\+\*\)\=.\+$+          contains=mamlConditional,mamlRepeat
syntax match mamlInlineCode      '^[ ]*- .*$'          contains=mamlConditional,mamlRepeat
syntax match mamlDiv             '^\..*$'

"" Statement Keywords
syntax keyword mamlConditional    if else endif
syntax keyword mamlRepeat         for endfor foreach endforeach

syntax region mamlEVariable      start=+{{+    end=+}}+
syntax region mamlVariable       start=+#{+    end=+}+
syntax region mamlEmoji          start=+@+    end=+@+
"syntax match  mamlLink           /\[\w\+\*\|\w\+\*\]/

highlight link mamlConditional       Conditional
highlight link mamlRepeat            Repeat

highlight link mamlHeading           Title
highlight link mamlDiv               Title
highlight link mamlInlineCode        Statement
highlight link mamlEmoji             Label
highlight link mamlLink              Underlined

highlight link mamlEVariable         Identifier
highlight link mamlVariable          Function

highlight mamlInlineCode cterm=bold ctermfg=3
highlight mamlEVariable cterm=bold ctermfg=3
highlight mamlVariable cterm=bold ctermfg=3

let b:current_syntax = "maml"
