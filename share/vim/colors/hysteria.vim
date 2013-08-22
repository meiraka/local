set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "hysteria"

"todo: Generates 256 color based 16, 24bit color
function! s:ApplyColor (label, background, forguround)
  exec "hi " . a:label . " guifg=#000000 guisp=#000000 gui=NONE" . " ctermbg=" . a:background . " ctermfg=" . a:forguround " cterm=NONE"
endfunction

" Normal texts.
call s:ApplyColor("Normal", "NONE", "253")

" values
call s:ApplyColor("Float",  "NONE", "231")
call s:ApplyColor("Number", "NONE", "231")
call s:ApplyColor("String", "NONE", 231)
call s:ApplyColor("Boolean", "NONE", "160")
call s:ApplyColor("Macro", "255", "240")
hi Constant guifg=#ffcd8b guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE

"pair
call s:ApplyColor("MatchParen", "124", "238")

" comments
call s:ApplyColor("Comment", "238", "245")

" defined wellknown values
call s:ApplyColor("Define",  "240", "255")

" defined wellknown labels
call s:ApplyColor("Include", "NONE", "160")
call s:ApplyColor("Keyword", "NONE", "124")

" function label
call s:ApplyColor("Function", "NONE", "124")
hi PreProc guifg=#409090 guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=232 cterm=NONE

" lang statement(eg. def, class..)
call s:ApplyColor("Statement", "None", "245")

"hilight group red 1
call s:ApplyColor("Operator", "NONE", "124")



hi IncSearch guifg=#303030 guibg=#cd8b60 guisp=#cd8b60 gui=NONE ctermfg=236 ctermbg=173 cterm=NONE
hi WildMenu guifg=#eeeeee guibg=#6e6eaf guisp=#6e6eaf gui=NONE ctermfg=255 ctermbg=61 cterm=NONE
"hi SignColumn -- no settings --
hi SpecialComment guifg=#c080d0 guibg=NONE guisp=NONE gui=NONE ctermfg=197 ctermbg=NONE cterm=NONE
hi Typedef guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
hi Title guifg=#af4f4b guibg=NONE guisp=NONE gui=NONE ctermfg=131 ctermbg=NONE cterm=NONE
hi Folded guifg=#cfcfcd guibg=#4b208f guisp=#4b208f gui=NONE ctermfg=252 ctermbg=54 cterm=NONE
hi PreCondit guifg=#409090 guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=240 cterm=NONE
"hi TabLineSel -- no settings --
hi StatusLineNC guifg=#b9b9b9 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=250 ctermbg=233 cterm=NONE
"hi CTagsMember -- no settings --
hi NonText guifg=#8b8bcd guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
"hi CTagsGlobalConstant -- no settings --
hi DiffText guifg=#ffffcd guibg=#4a2a4a guisp=#4a2a4a gui=NONE ctermfg=230 ctermbg=239 cterm=NONE
hi ErrorMsg guifg=#ffffff guibg=#ce4e4e guisp=#ce4e4e gui=NONE ctermfg=253 ctermbg=167 cterm=NONE
"hi Ignore -- no settings --
hi Debug guifg=#c080d0 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=#eeeeee guibg=#6e6eaf guisp=#6e6eaf gui=NONE ctermfg=255 ctermbg=61 cterm=NONE
hi Identifier guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=239 cterm=NONE
hi Conditional guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
hi Todo guifg=#303030 guibg=#d0a060 guisp=#d0a060 gui=NONE ctermfg=236 ctermbg=179 cterm=NONE
hi Special guifg=#c080d0 guibg=NONE guisp=NONE gui=NONE ctermfg=160 ctermbg=NONE cterm=NONE
hi LineNr guifg=#8b8bcd guibg=#2e2e2e guisp=#2e2e2e gui=NONE ctermfg=240 ctermbg=236 cterm=NONE
hi StatusLine guifg=#b9b9b9 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=250 ctermbg=233 cterm=NONE
hi Label guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#eeeeee guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=124 ctermbg=231 cterm=NONE
hi Search guifg=#303030 guibg=#cd8b60 guisp=#cd8b60 gui=NONE ctermfg=236 ctermbg=173 cterm=NONE
"hi CTagsGlobalVariable -- no settings --
hi Delimiter guifg=#c080d0 guibg=NONE guisp=NONE gui=NONE ctermfg=160 ctermbg=NONE cterm=NONE
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
hi Character guifg=#ffcd8b guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
"hi CursorLine -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
hi Question guifg=#ffcd00 guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
hi WarningMsg guifg=#ffffff guibg=#ce8e4e guisp=#ce8e4e gui=NONE ctermfg=231 ctermbg=196 cterm=NONE
"hi VisualNOS -- no settings --
hi DiffDelete guifg=#ffffcd guibg=#6d3030 guisp=#6d3030 gui=NONE ctermfg=230 ctermbg=95 cterm=NONE
hi ModeMsg guifg=#7e7eae guibg=NONE guisp=NONE gui=NONE ctermfg=160 ctermbg=NONE cterm=NONE
"hi CursorColumn -- no settings --
hi FoldColumn guifg=#8b8bcd guibg=#2e2e2e guisp=#2e2e2e gui=NONE ctermfg=104 ctermbg=236 cterm=NONE
"hi EnumerationName -- no settings --
hi Visual guifg=#eeeeee guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=255 ctermbg=088 cterm=NONE
hi MoreMsg guifg=#7e7eae guibg=NONE guisp=NONE gui=NONE ctermfg=160 ctermbg=NONE cterm=NONE
"hi SpellCap -- no settings --
hi VertSplit guifg=#b9b9b9 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=250 ctermbg=233 cterm=NONE
hi Exception guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
hi Type guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
hi DiffChange guifg=#ffffcd guibg=#306b8f guisp=#306b8f gui=NONE ctermfg=230 ctermbg=24 cterm=NONE
hi Cursor guifg=#404040 guibg=#8b8bff guisp=#8b8bff gui=NONE ctermfg=238 ctermbg=105 cterm=NONE
"hi SpellLocal -- no settings --
hi Error guifg=#ffffff guibg=#6e2e2e guisp=#6e2e2e gui=NONE ctermfg=253 ctermbg=95 cterm=NONE
hi PMenu guifg=#eeeeee guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=233 ctermbg=231 cterm=NONE

""Control keys
"hi SpecialKey guifg=#ab60ed guibg=NONE guisp=NONE gui=NONE ctermfg=088 ctermbg=232 cterm=NONE
""hi DefinedName -- no settings --
"hi Tag guifg=#c080d0 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
"hi PMenuThumb guifg=#eeeeee guibg=#6e6eaf guisp=#6e6eaf gui=NONE ctermfg=255 ctermbg=61 cterm=NONE
""hi LocalVariable -- no settings --
"hi Repeat guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
""hi SpellBad -- no settings --
""hi CTagsClass -- no settings --
"hi Directory guifg=#00ff8b guibg=NONE guisp=NONE gui=NONE ctermfg=48 ctermbg=NONE cterm=NONE
"hi Structure guifg=#ff8bff guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE
"hi Underlined guifg=#df9f2d guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
"hi DiffAdd guifg=#ffffcd guibg=#306d30 guisp=#306d30 gui=NONE ctermfg=230 ctermbg=65 cterm=NONE
""hi TabLine -- no settings --
"hi cursorim guifg=#404040 guibg=#8b8bff guisp=#8b8bff gui=NONE ctermfg=238 ctermbg=105 cterm=NONE
""hi clear -- no settings --
"hi mbenormal guifg=#cfbfad guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=187 ctermbg=237 cterm=NONE
"hi perlspecialstring guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
"hi doxygenspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
" search
"hi mbechanged guifg=#eeeeee guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=124 ctermbg=231 cterm=NONE
"hi mbevisiblechanged guifg=#eeeeee guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=232 ctermbg=231 cterm=NONE
"hi doxygenparam guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
"hi doxygensmallspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
"hi doxygenprev guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
"hi perlspecialmatch guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
"hi cformat guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
"hi lcursor guifg=#404040 guibg=#8fff8b guisp=#8fff8b gui=NONE ctermfg=238 ctermbg=120 cterm=NONE
"hi doxygenspecialmultilinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
"hi taglisttagname guifg=#808bed guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
"hi doxygenbrief guifg=#fdab60 guibg=NONE guisp=NONE gui=NONE ctermfg=1603 ctermbg=NONE cterm=NONE
"hi mbevisiblenormal guifg=#cfcfcd guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=252 ctermbg=233 cterm=NONE
"hi user2 guifg=#7070a0 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=160 ctermbg=60 cterm=NONE
"hi user1 guifg=#00ff8b guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=48 ctermbg=60 cterm=NONE
"hi doxygenspecialonelinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
"hi doxygencomment guifg=#ad7b20 guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
"hi cspecialcharacter guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
