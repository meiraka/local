set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "hysteria"

"TODO: Generates 256 color based 16, 24bit color
function! s:ApplyColor (label, background, forguround)
  exec "hi " . a:label . " guifg=#000000 guisp=#000000 gui=NONE" . " ctermbg=" . a:background . " ctermfg=" . a:forguround " cterm=NONE"
endfunction

" Normal texts.
call s:ApplyColor("Normal", "NONE", "252")

" values
call s:ApplyColor("Constant", "NONE", "231")
call s:ApplyColor("String", "NONE", "231")
call s:ApplyColor("Float",  "NONE", "231")
call s:ApplyColor("Number", "NONE", "231")
call s:ApplyColor("Boolean", "NONE", "160")

call s:ApplyColor("Identifier",  "NONE", "247")
call s:ApplyColor("Function",    "NONE", "124")
" state
call s:ApplyColor("Statement",   "NONE", "245")
call s:ApplyColor("Conditional", "NONE", "160")
call s:ApplyColor("Operator",    "NONE", "124")
call s:ApplyColor("Repeat",      "NONE", "241")
call s:ApplyColor("Label",       "NONE", "243")
call s:ApplyColor("Exception",   "NONE", "088")

" type
call s:ApplyColor("Type", "NONE", "124")
call s:ApplyColor("Typedef", "NONE", "124")

"pair
call s:ApplyColor("MatchParen", "124", "238")

" comments
call s:ApplyColor("Comment", "238", "245")
call s:ApplyColor("SpecialComment", "None", "197")
call s:ApplyColor("Todo", "245", "232")

" defined wellknown values
call s:ApplyColor("Define",  "240", "255")

" defined wellknown labels
"PreProcessor
call s:ApplyColor("PreProc", "NONE", "232")
call s:ApplyColor("Include", "NONE", "160")
call s:ApplyColor("Macro",    "255", "240")
call s:ApplyColor("Keyword", "NONE", "124")

" Special
call s:ApplyColor("Special", "NONE", "160")
call s:ApplyColor("SpecialChar", "NONE", "198")

"Other
call s:ApplyColor("Error", "167", "253")


"User Interface

"Menu
call s:ApplyColor("PMenuSbar", "231", "232")
call s:ApplyColor("PMenuSel", "231", "088")
call s:ApplyColor("PMenu", "231", "232")
call s:ApplyColor("WildMenu", "252", "232")

"Search
call s:ApplyColor("Question", "NONE", "124")
call s:ApplyColor("Search", "088", "232")
call s:ApplyColor("IncSearch", "088", "232")

call s:ApplyColor("StatusLineNC", "NONE", "252")
call s:ApplyColor("StatusLine", "NONE", "160")


