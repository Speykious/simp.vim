"this is using the vim-gotham style of setting most colors

hi clear
if exists('syntax on') | syntax reset | endif
set background=dark
let g:colors_name = 'Simp'

" Execute the 'highlight' command with a List of arguments.
function! s:Highlight(args)
  exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:AddGroundValues(accumulator, ground, color)
  let new_list = a:accumulator
  for [where, value] in items(a:color)
    if value == "NONE" || value == "none" || value == ""
      call add(new_list, where . a:ground . '= NONE')
    else
      call add(new_list, where . a:ground . '=' . value)
    endif
  endfor

  return new_list
endfunction

function! s:Col(group, fg_name, ...)
  " ... = optional bg_name

  let pieces = [a:group]

  if a:fg_name !=# ''
    let pieces = s:AddGroundValues(pieces, 'fg', s:colors[a:fg_name])
  endif

  if a:0 > 0 && a:1 !=# ''
    let pieces = s:AddGroundValues(pieces, 'bg', s:colors[a:1])
  endif

  call s:Clear(a:group)
  call s:Highlight(pieces)
endfunction

function! s:Attr(group, attr)
  let l:attrs = [a:group, 'term=' . a:attr, 'cterm=' . a:attr, 'gui=' . a:attr]
  call s:Highlight(l:attrs)
endfunction

function! s:Clear(group)
  exec 'highlight clear ' . a:group
endfunction


" Colors ======================================================================

" Let's store all the colors in a dictionary.
let s:colors = {}

" Base colors
let s:colors.base0  = { 'cterm': 144 }
let s:colors.base1  = { 'cterm':  52 }
let s:colors.base2  = { 'cterm': 248 }
let s:colors.base3  = { 'cterm': 235 }
let s:colors.base4  = { 'cterm':   1 }
let s:colors.base5  = { 'cterm':  60 }
let s:colors.base6  = { 'cterm': 249 }
let s:colors.base7  = { 'cterm': 137 }
let s:colors.base8  = { 'cterm': 239 }
let s:colors.base10 = { 'cterm':  66 }
let s:colors.base11 = { 'cterm': 252 }
let s:colors.base12 = { 'cterm': 130 }
let s:colors.base13 = { 'cterm': 196 }
let s:colors.base14 = { 'cterm': 189 }
let s:colors.base15 = { 'cterm': 254 }
let s:colors.base16 = { 'cterm': 242 }
let s:colors.base17 = { 'cterm': 109 }
let s:colors.base18 = { 'cterm': 251 }
let s:colors.base19 = { 'cterm':  97 }
let s:colors.base20 = { 'cterm':   8 }
let s:colors.base21 = { 'cterm': 253 }
let s:colors.base22 = { 'cterm': 246 }
let s:colors.base23 = { 'cterm': 236 }
let s:colors.base24 = { 'cterm': 237 }

" Other colors.
let s:colors.red     = { 'cterm': 124 }
let s:colors.orange  = { 'cterm': 166 }
let s:colors.yellow  = { 'cterm': 214 }
let s:colors.magenta = { 'cterm': 67  }
let s:colors.violet  = { 'cterm': 60  }
let s:colors.blue    = { 'cterm': 24  }
let s:colors.cyan    = { 'cterm': 44  }
let s:colors.green   = { 'cterm': 78  }

let s:colors.none    = { 'cterm': 'NONE' }

" Normal modes
call s:Col('Normal', 'base0', 'base3')

" Line, cursor and so on.
call s:Col('Cursor', 'base15', 'base14')
call s:Col('CursorLine', 'none', 'base24')
call s:Col('CursorColumn', 'base0', 'base23')
call s:Col('cursorim', 'base3', 'base1')

" Sign column, line numbers.
call s:Col('LineNr', 'base8')
call s:Col('SignColumn', 'base3', 'base3')
call s:Col('ColorColumn', 'base0', 'base24')

" Visual selection.
call s:Col('Visual', 'base0', 'base1')

" Easy-to-guess code elements.
call s:Col('Comment', 'base16')
call s:Col('String', 'base17')
call s:Col('Number', 'base18')
call s:Col('Statement', 'base7')
call s:Attr('Statement', 'bold')
call s:Col('Special', 'base4')
call s:Col('Identifier', 'base4')

" Constants, Ruby symbols.
call s:Col('Constant', 'base2')

" Some HTML tags (<title>, some <h*>s)
call s:Col('Title', 'base6', 'base1')
call s:Attr('Title', 'bold')

" <a> tags.
call s:Col('Underlined', 'base14', 'base3')
call s:Attr('Underlined', 'underline')

" Types, HTML attributes, Ruby constants (and class names).
call s:Col('Type', 'base5')
call s:Attr('Type', 'bold')

" Stuff like 'require' in Ruby.
call s:Col('PreProc', 'base19')

" Tildes on the bottom of the page.
call s:Col('NonText', 'base10')

" TODO and similar tags.
call s:Col('Todo', 'base13', 'base3')

" The column separating vertical splits.
call s:Col('VertSplit', 'base3', 'base8')
call s:Attr('VertSplit', 'bold')
call s:Col('StatusLineNC', 'base0', 'base8')
call s:Attr('StatusLineNC', 'bold')

" Matching parenthesis.
call s:Col('MatchParen', 'base4')
call s:Attr('MatchParen', 'bold')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:Col('SpecialKey', 'base10')
call s:Attr('SpecialKey', 'bold')

" Folds.
call s:Col('Folded', 'base3', 'base2')
call s:Attr('Folded', 'bold')
call s:Col('FoldColumn', 'base3', 'base2')
call s:Attr('FoldColumn', 'bold')

" Searching.
call s:Col('Search', 'base0', 'base1')
call s:Col('IncSearch', 'base0', 'base1')

" Popup menu.
call s:Col('Pmenu', 'base0', 'base3')
call s:Col('PmenuSel', 'base0', 'base1')
call s:Col('PmenuSbar', 'base0', 'base20')
call s:Col('PmenuThumb', 'base15', 'base2')

" Command line stuff.
call s:Col('ErrorMsg', 'base11', 'base12')
call s:Col('ModeMsg', 'base21', 'base3')
call s:Attr('ModeMsg', 'bold')

" Wild menu.
" StatusLine determines the color of the non-active entries in the wild menu.
call s:Col('StatusLine', 'base0', 'base1')
call s:Attr('StatusLine', 'bold')
call s:Col('WildMenu', 'base0', 'base2')

" The 'Hit ENTER to continue prompt'.
"call s:Col('Question', )

" Tab line.
call s:Col('TabLineSel', 'base0', 'base1')  " the selected tab
call s:Attr('TabLineSel', 'bold')
call s:Col('TabLine', 'base3', 'base22')    " the non-selected tabs
call s:Attr('TabLine', 'bold')
call s:Col('TabLineFill', 'base3', 'base8') " the rest of the tab line
call s:Attr('TabLineFill', 'bold')

" Spelling.
call s:Col('SpellBad', 'base14', 'base3')
call s:Attr('SpellBad', 'underline')
call s:Col('SpellCap', 'base14', 'base3')
call s:Attr('SpellCap', 'underline')
call s:Col('SpellLocal', 'base14', 'base3')
call s:Attr('SpellLocal', 'underline')
call s:Col('SpellRare', 'base14', 'base3')
call s:Attr('SpellRare', 'underline')

" Diffing.
call s:Col('DiffAdd', 'base0', 'base23')
call s:Col('DiffChange', 'base0', 'base1')
call s:Col('DiffDelete', 'base0', 'base3')
call s:Col('DiffText', 'base0', 'base1')

" Directories (e.g. netrw).
call s:Col('Directory', 'base5')
call s:Attr('Directory', 'bold')

" Plugin =======================================================================

" GitGutter
call s:Col('GitGutterAdd', 'green', 'base3')
call s:Col('GitGutterChange', 'yellow', 'base3')
call s:Col('GitGutterDelete', 'red', 'base3')
call s:Col('GitGutterChangeDelete', 'orange', 'base3')

" vim-better-whitespace
call s:Col('ExtraWhitespace', 'violet', 'yellow')

" Cleanup =====================================================================

unlet s:colors

" End of gotham-esque settings

hi SpecialComment ctermfg=1 ctermbg=NONE cterm=NONE
hi Typedef ctermfg=60 ctermbg=NONE cterm=bold
hi PreCondit ctermfg=137 ctermbg=NONE cterm=NONE
hi Include ctermfg=1 ctermbg=NONE cterm=NONE
hi Float ctermfg=248 ctermbg=NONE cterm=NONE
hi StatusLineNC ctermfg=144 ctermbg=239 cterm=bold
"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi Ignore -- no settings --
hi Debug ctermfg=1 ctermbg=NONE cterm=NONE
hi SpecialChar ctermfg=1 ctermbg=NONE cterm=NONE
hi Conditional ctermfg=1 ctermbg=NONE cterm=bold
hi StorageClass ctermfg=60 ctermbg=NONE cterm=bold
hi Label ctermfg=1 ctermbg=NONE cterm=bold
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
hi Delimiter ctermfg=1 ctermbg=NONE cterm=NONE
"hi EnumerationValue -- no settings --
hi Character ctermfg=248 ctermbg=NONE cterm=NONE
hi Boolean ctermfg=248 ctermbg=NONE cterm=NONE
hi Operator ctermfg=253 ctermbg=NONE cterm=bold
"hi Union -- no settings --
"hi Question -- no settings --
hi WarningMsg ctermfg=248 ctermbg=88 cterm=NONE
hi VisualNOS ctermfg=235 ctermbg=189 cterm=underline
hi Define ctermfg=1 ctermbg=NONE cterm=NONE
hi Function ctermfg=60 ctermbg=NONE cterm=bold
"hi EnumerationName -- no settings --
"hi MarkdownCodeBlock 
hi MoreMsg ctermfg=1 ctermbg=NONE cterm=bold
hi SpellCap ctermfg=189 ctermbg=235 cterm=underline
hi VertSplit ctermfg=235 ctermbg=239 cterm=bold
hi Exception ctermfg=1 ctermbg=NONE cterm=bold
hi Keyword ctermfg=1 ctermbg=NONE cterm=bold
hi Type ctermfg=60 ctermbg=NONE cterm=bold
hi Error ctermfg=248 ctermbg=88 cterm=NONE
"hi DefinedName -- no settings --
hi Tag ctermfg=1 ctermbg=NONE cterm=NONE
hi LocalVariable ctermfg=209 ctermbg=NONE cterm=bold
hi Repeat ctermfg=1 ctermbg=NONE cterm=bold
"hi CTagsClass -- no settings --
hi Structure ctermfg=60 ctermbg=NONE cterm=bold
hi Macro ctermfg=1 ctermbg=NONE cterm=NONE
"hi clear -- no settings --
