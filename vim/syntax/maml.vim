" Vim syntax file
" Language:    maml
" https://sites.google.com/site/vimdocja/syntax-html#:syn-qstart
"
if version < 700
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax match mamlHeading         +^\*\{1,3}\(\w\+\*\)\=.\+$+ 
"syntax match mamlInlineCode      +(^|\n| \+)\- \(\w\+\*\)\=.\+$+          contains=mamlConditional,mamlRepeat
syntax match mamlInlineCode      '^[ ]*- .*$'          contains=mamlConditional,mamlRepeat
syntax match mamlDiv             '^\..*$'

"" Statement Keywords
syntax keyword mamlConditional    if else endif
syntax keyword mamlRepeat         foreach endforeach

syntax region mamlEVariable      start=+{{+    end=+}}+
syntax region mamlVariable       start=+#{+    end=+}+
syntax region mamlEmoji          start=+@+    end=+@+
"syntax match  mamlLink           /\[\w\+\*\|\w\+\*\]/

hi link mamlConditional       Conditional
hi link mamlRepeat            Conditional

hi link mamlHeading           Title
hi link mamlDiv               Title
hi link mamlInlineCode        Statement
hi link mamlEVariable         Special
hi link mamlVariable          Special
hi link mamlEmoji             Label
hi link mamlLink              Underlined

let b:current_syntax = "maml"
