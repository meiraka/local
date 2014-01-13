" require version 7.0 or later.
if v:version >= 700

set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name = "hysteria"

"TODO: Generates 256 color based 16, 24bit color
function! s:ApplyColor (label, background, forguround)
  exec "hi " . a:label . " guifg=#000000 guisp=#000000 gui=NONE" . " ctermbg=" . a:background . " ctermfg=" . a:forguround " cterm=NONE"
endfunction

" 25 level mono color
function! s:mono(level)
  if &background ==# 'dark'
    if a:level <= 0
      return 232
    elseif a:level >= 24
      return 231
    else
      return 231 + a:level
    endif
  else
    if a:level <= 0
      return 231
    elseif a:level >= 24
      return 232
    else
      return 255 - a:level
    endif
  endif
endfunction

" Normal texts.
call s:ApplyColor("Normal", "NONE", s:mono(21))

" values
call s:ApplyColor("Constant", "NONE", s:mono(24))
call s:ApplyColor("String", "NONE", s:mono(24))
call s:ApplyColor("Float",  "NONE", s:mono(24))
call s:ApplyColor("Number", "NONE", s:mono(24))
call s:ApplyColor("Boolean", "NONE", "160")

call s:ApplyColor("Identifier",  "NONE", "247")
call s:ApplyColor("Function",    "NONE", "124")
" state
call s:ApplyColor("Statement",   "NONE", s:mono(14))
call s:ApplyColor("Conditional", "NONE", "160")
call s:ApplyColor("Operator",    "NONE", "124")
call s:ApplyColor("Repeat",      "NONE", s:mono(10))
call s:ApplyColor("Label",       "NONE", "243")
call s:ApplyColor("Exception",   "NONE", "088")

" type
call s:ApplyColor("Type", "NONE", "124")
call s:ApplyColor("Typedef", "NONE", "124")

"pair
call s:ApplyColor("MatchParen", "124", s:mono(7))

" comments
call s:ApplyColor("Comment", s:mono(7), s:mono(14))
call s:ApplyColor("SpecialComment", "None", "197")
call s:ApplyColor("Todo", s:mono(14), s:mono(2))


" defined wellknown labels
"PreProcessor
call s:ApplyColor("PreProc",   "NONE", s:mono(10))
call s:ApplyColor("PreCondit", "NONE", s:mono(14))
call s:ApplyColor("Include",   "NONE", "160")
call s:ApplyColor("Define",    "NONE", "196")
call s:ApplyColor("Macro",     "NONE", "196")
call s:ApplyColor("Keyword",   "NONE", "124")

" Special
call s:ApplyColor("Special", "NONE", "160")
call s:ApplyColor("SpecialChar", "NONE", "198")

"Other
call s:ApplyColor("Error", "167", s:mono(22))


"User Interface
"Menu
call s:ApplyColor("PMenuSbar", s:mono(24), s:mono(2))
call s:ApplyColor("PMenuSel", s:mono(24), "088")
call s:ApplyColor("PMenu", s:mono(24), s:mono(2))
call s:ApplyColor("WildMenu", s:mono(21), s:mono(2))

"Search
call s:ApplyColor("Question", "NONE", "124")
call s:ApplyColor("Search", "088", s:mono(2))
call s:ApplyColor("IncSearch", "088", s:mono(2))

call s:ApplyColor("StatusLineNC", "NONE", s:mono(21))
call s:ApplyColor("StatusLine", "NONE", "160")

endif
