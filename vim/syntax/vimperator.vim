" Vim syntax file
" Language:	    VIMperator configuration file
" Maintainer:	    Doug Kearns <dougkearns@gmail.com>
" Latest Revision:  2007 May 03

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn include @javascriptTop syntax/javascript.vim
unlet b:current_syntax

syn keyword vimperatorTodo    FIXME NOTE TODO XXX contained
syn match   vimperatorComment +".*$+ contains=vimperatorTodo,@Spell

syn keyword vimperatorCommand addons ba[ck] bd[elete] bw[ipeout] bun[load] tabc[lose] beep bmadd bmdel bookmarks bm b[uffer]
	\ buffers files ls downloads dl ec[ho] echoe[rr] exe[cute] forward fw ha[rdcopy] h[elp] history hs javascript js ma[rk]
	\ marks o[pen] e[dit] pc[lose] preferences prefs q[uit] quita[ll] qa[ll] re[load] restart restart sav[eas] se[t] so[urce]
	\ st[op] tab tabn[ext] tn[ext] tabopen t to topen tabnew tabe[dit] tp[revious] tN[ext] tabp[revious] tabN[ext] u[ndo]
	\ qmarkadd qmadd qmarkdel qmdel qmarks qms ve[rsion] w wo[pen] wine[dit] win[open] wq wqa[ll] xa[ll] zo[om]
	\ contained

" FIXME
syn match vimperatorCommandWrapper "\<\h\w*\>" contains=vimperatorCommand

syn region vimperatorSet matchgroup=vimperatorCommand start="\<set\=\>" end="$" keepend oneline contains=vimperatorOption
syn keyword vimperatorOption activate beep nobeep beep complete cpt defsearch ds extendedhinttags eht focusedhintstyle fhs
	\ fullscreen fs nofullscreen nofs guioptions go hintchars hc hintstyle hs hinttags maxhints mh preload nopreload
	\ previewheight pvh showtabline stal usermode um nousermode noum wildmode wim wildoptions wop
	\ contained

syn region vimperatorJavascript start="\%(^\s*\%(javascript\|js\)\s\+\)\@<=" end="$" contains=@javascriptTop keepend oneline
syn region vimperatorJavascript matchgroup=vimperatorJavascriptDelimiter
	\ start="\%(^\s*\%(javascript\|js\)\s\+\)\@<=<<\z(\h\w*\)"hs=s+2 end="^\z1$" contains=@javascriptTop fold

" Note: match vim.vim highlighting groups
hi def link vimperatorCommand			Statement
hi def link vimperatorComment			Comment
hi def link vimperatorJavascriptDelimiter	Delimiter
hi def link vimperatorOption			PreProc

let b:current_syntax = "vimperator"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: tw=130:
