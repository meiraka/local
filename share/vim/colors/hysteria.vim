" require version 7.0 or later.
if v:version >= 700

"set background=dark
if &background ==# 'dark' || &background ==# 'light'
    "ok
else
    set background = dark
endif
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name = "hysteria"
let g:base_background = 'dark'

"TODO: Generates 256 color based 16, 24bit color
function! s:ApplyColor (label, background, forguround)
  exec "hi " . a:label . " guifg=#000000 guisp=#000000 gui=NONE" . " ctermbg=" . a:background . " ctermfg=" . a:forguround " cterm=NONE"
endfunction

" generate 25 level mono color. 0 is darkest color if in 'dark' background mode.
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

" generate 6 level RGB color.
function! s:rgb(r, g, b)
    if &background ==# 'dark'
        return 16 + a:r * 6 * 6 + a:g * 6 + a:b
    else
        function! s:max(ar)
            let m = 0
            for i in a:ar
                if m < i
                    let m = i
                endif
            endfor
            return m
        endfunction

        let m = s:max([a:r, a:g, a:b])
        let rm = 5 - m
        let di =  (rm * 1.0) / (m * 1.0)
        let ret = 0
        return 16 + float2nr(a:r * 6 * 6 * di) + float2nr(a:g * 6 * di) + float2nr(a:b * di)
    endif
endfunction

" Normal texts.
call s:ApplyColor("Normal",          "NONE",         s:mono(21))
call s:ApplyColor("Folded",      s:mono(10),         s:mono(21))

" values
call s:ApplyColor("Constant",        "NONE",         s:mono(24))
call s:ApplyColor("String",          "NONE",         s:mono(24))
call s:ApplyColor("Float",           "NONE",         s:mono(24))
call s:ApplyColor("Number",          "NONE",         s:mono(24))
call s:ApplyColor("Boolean",         "NONE",         s:rgb(4, 0, 0))

call s:ApplyColor("Identifier",      "NONE",         s:mono(16))
call s:ApplyColor("Function",        "NONE",         s:rgb(3, 0, 0))
" state
call s:ApplyColor("Statement",       "NONE",         s:mono(14))
call s:ApplyColor("Conditional",     "NONE",         s:rgb(4, 0, 0))
call s:ApplyColor("Operator",        "NONE",         s:rgb(3, 0, 0))
call s:ApplyColor("Repeat",          "NONE",         s:mono(10))
call s:ApplyColor("Label",           "NONE",         s:mono(12))
call s:ApplyColor("Title",           "NONE",         s:mono(12))
call s:ApplyColor("Exception",       "NONE",         s:rgb(2, 0, 0))

" type
call s:ApplyColor("Type",            "NONE",         s:rgb(3, 0, 0))
call s:ApplyColor("Typedef",         "NONE",         s:rgb(3, 0, 0))

"pair
call s:ApplyColor("MatchParen",      s:rgb(3, 0, 0), s:mono(7))

" comments
call s:ApplyColor("Comment",         s:mono(7),      s:mono(14))
call s:ApplyColor("SpecialComment",  "None",         s:rgb(5, 0, 1))
call s:ApplyColor("Todo",            s:mono(14),     s:mono(2))


" defined wellknown labels
"PreProcessor
call s:ApplyColor("PreProc",         "NONE",         s:mono(10))
call s:ApplyColor("PreCondit",       "NONE",         s:mono(14))
call s:ApplyColor("Include",         "NONE",         s:rgb(4, 0, 0))
call s:ApplyColor("Define",          "NONE",         s:rgb(5, 0, 0))
call s:ApplyColor("Macro",           "NONE",         s:rgb(5, 0, 0))
call s:ApplyColor("Keyword",         "NONE",         s:rgb(3, 0, 0))

" Special
call s:ApplyColor("Special",         "NONE",         s:rgb(4, 0, 0))
call s:ApplyColor("SpecialChar",     "NONE",         s:rgb(5, 0, 2))

"Other
call s:ApplyColor("Error",           s:rgb(4, 1, 1), s:mono(22))


"User Interface
"Menu
call s:ApplyColor("PMenuSbar",       s:mono(24),     s:mono(2))
call s:ApplyColor("PMenuSel",        s:mono(24),     s:rgb(2, 0, 0))
call s:ApplyColor("PMenu",           s:mono(24),     s:mono(2))
call s:ApplyColor("WildMenu",        s:mono(21),     s:mono(2))

"Search
call s:ApplyColor("Question",        "NONE",         s:rgb(3, 0, 0))
call s:ApplyColor("Search",          s:rgb(2, 0, 0), s:mono(2))
call s:ApplyColor("IncSearch",       s:rgb(2, 0, 0), s:mono(2))

"Split
call s:ApplyColor("VertSplit",     s:mono(2),      s:mono(2))

call s:ApplyColor("StatusLineNC",    "NONE",         s:mono(21))
call s:ApplyColor("StatusLine",      "NONE",         s:rgb(4, 0, 0))

"VimDiff
call s:ApplyColor("DiffAdd",         s:rgb(2, 0, 0), s:mono(2))
call s:ApplyColor("DiffDelete",      s:mono(2), s:rgb(2, 0, 0))
call s:ApplyColor("DiffChange",      s:rgb(2, 0, 0), s:mono(24))
call s:ApplyColor("DiffText",        s:rgb(2, 0, 0), s:mono(20))

call s:ApplyColor("Directory",       "NONE",         s:rgb(4, 0, 0))

endif
