" This is using the vim-gotham style of setting most colors

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
let s:colors.base2  = { 'gui': '#a8a8a8', 'cterm': 248 }
let s:colors.base4  = { 'gui': '#a62843', 'cterm':   1 }
let s:colors.base5  = { 'gui': '#5f5f87', 'cterm':  60 }
let s:colors.base6  = { 'gui': '#b2b2b2', 'cterm': 249 }
let s:colors.base7  = { 'gui': '#af875f', 'cterm': 137 }
let s:colors.base10 = { 'gui': '#5f8787', 'cterm':  66 }
let s:colors.base11 = { 'gui': '#d0d0d0', 'cterm': 252 }
let s:colors.base12 = { 'gui': '#af5f00', 'cterm': 130 }
let s:colors.base13 = { 'gui': '#ff0000', 'cterm': 196 }
let s:colors.base14 = { 'gui': '#d7d7ff', 'cterm': 189 }
let s:colors.base15 = { 'gui': '#e4e4e4', 'cterm': 254 }
let s:colors.base16 = { 'gui': '#6c6c6c', 'cterm': 242 }
let s:colors.base17 = { 'gui': '#87afaf', 'cterm': 109 }
let s:colors.base18 = { 'gui': '#c6c6c6', 'cterm': 251 }
let s:colors.base19 = { 'gui': '#875faf', 'cterm':  97 }
let s:colors.base20 = { 'gui': '#808080', 'cterm':   8 }
let s:colors.base21 = { 'gui': '#dadada', 'cterm': 253 }
let s:colors.base22 = { 'gui': '#949494', 'cterm': 246 }
let s:colors.base23 = { 'gui': '#303030', 'cterm': 236 }
let s:colors.base24 = { 'gui': '#3a3a3a', 'cterm': 237 }

" Other colors.
let s:colors.red     = { 'gui': '#a62843', 'cterm': 124 }
let s:colors.orange  = { 'gui': '#d75f00', 'cterm': 166 }
let s:colors.yellow  = { 'gui': '#b8bb26', 'cterm': 214 }
let s:colors.magenta = { 'gui': '#9c165a', 'cterm': 67  }
let s:colors.violet  = { 'gui': '#eaa6dd', 'cterm': 60  }
let s:colors.blue    = { 'gui': '#223974', 'cterm': 24  }
let s:colors.cyan    = { 'gui': '#60c2cd', 'cterm': 44  }
let s:colors.green   = { 'gui': '#306b3d', 'cterm': 78  }

let s:colors.bg_darker = { 'gui': '#10000f', 'cterm':   0 }
let s:colors.bg_dark   = { 'gui': '#1f0d1c', 'cterm': 233 }
let s:colors.fg_normal = { 'gui': '#afaf87', 'cterm': 144 }
let s:colors.dark_red  = { 'gui': '#5f0000', 'cterm':  52 }
let s:colors.dark_green = { 'gui': '#1b3020', 'cterm': 78 }

let s:colors.none    = { 'gui': 'NONE', 'cterm': 'NONE' }

" Normal modes
call s:Col('Normal', 'fg_normal')

" Line, cursor and so on.
call s:Col('Cursor', 'base15', 'base14')
call s:Col('CursorLine', 'none', 'base24')
call s:Col('CursorColumn', 'fg_normal', 'base23')
call s:Col('cursorim', 'bg_dark', 'dark_red')

" Sign column, line numbers.
call s:Col('LineNr', 'magenta')
call s:Col('SignColumn', 'base2', 'bg_dark')
call s:Col('ColorColumn', 'fg_normal', 'bg_dark')

" Visual selection.
call s:Col('Visual', 'fg_normal', 'dark_red')

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
call s:Col('Title', 'base6', 'dark_red')
call s:Attr('Title', 'bold')

" <a> tags.
call s:Col('Underlined', 'base14', 'bg_dark')
call s:Attr('Underlined', 'underline')

" Types, HTML attributes, Ruby constants (and class names).
call s:Col('Type', 'base5')
call s:Attr('Type', 'bold')

" Stuff like 'require' in Ruby.
call s:Col('PreProc', 'base19')

" Tildes on the bottom of the page.
call s:Col('NonText', 'base10')

" TODO and similar tags.
call s:Col('Todo', 'base13', 'bg_dark')

" The column separating vertical splits.
call s:Col('VertSplit', 'magenta', 'bg_dark')
" call s:Attr('VertSplit', 'bold')
call s:Col('StatusLineNC', 'fg_normal', 'bg_dark')
call s:Attr('StatusLineNC', 'bold')

" Matching parenthesis.
call s:Col('MatchParen', 'base15')
call s:Attr('MatchParen', 'bold')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:Col('SpecialKey', 'base10')
call s:Attr('SpecialKey', 'bold')

" Folds.
call s:Col('Folded', 'bg_dark', 'base2')
call s:Attr('Folded', 'bold')
call s:Col('FoldColumn', 'bg_dark', 'base2')
call s:Attr('FoldColumn', 'bold')

" Searching.
call s:Col('Search', 'fg_normal', 'dark_red')
call s:Col('IncSearch', 'fg_normal', 'dark_red')

" Popup menu.
call s:Col('Pmenu', 'fg_normal', 'bg_dark')
call s:Col('PmenuSel', 'fg_normal', 'dark_red')
call s:Col('PmenuSbar', 'fg_normal', 'base20')
call s:Col('PmenuThumb', 'base15', 'base2')

" Command line stuff.
call s:Col('ErrorMsg', 'base11', 'base12')
call s:Col('ModeMsg', 'base21', 'bg_dark')
call s:Attr('ModeMsg', 'bold')

" Wild menu.
" StatusLine determines the color of the non-active entries in the wild menu.
call s:Col('StatusLine', 'fg_normal', 'dark_red')
call s:Attr('StatusLine', 'bold')
call s:Col('WildMenu', 'fg_normal', 'base2')

" The 'Hit ENTER to continue prompt'.
"call s:Col('Question', )

" Tab line.
call s:Col('TabLineSel', 'fg_normal', 'dark_red')  " the selected tab
call s:Attr('TabLineSel', 'bold')
call s:Col('TabLine', 'bg_dark', 'base22')    " the non-selected tabs
call s:Attr('TabLine', 'bold')
call s:Col('TabLineFill', 'bg_dark', 'bg_darker') " the rest of the tab line
call s:Attr('TabLineFill', 'bold')

" Spelling.
call s:Col('SpellBad', 'base14', 'bg_dark')
call s:Attr('SpellBad', 'underline')
call s:Col('SpellCap', 'base14', 'bg_dark')
call s:Attr('SpellCap', 'underline')
call s:Col('SpellLocal', 'base14', 'bg_dark')
call s:Attr('SpellLocal', 'underline')
call s:Col('SpellRare', 'base14', 'bg_dark')
call s:Attr('SpellRare', 'underline')

" Diffing.
call s:Col('DiffAdd', 'fg_normal', 'dark_green')
call s:Col('DiffChange', 'fg_normal', 'bg_darker')
call s:Col('DiffDelete', 'red', 'bg_dark')
call s:Col('DiffText', 'fg_normal', 'dark_red')

" Directories (e.g. netrw).
call s:Col('Directory', 'base5')
call s:Attr('Directory', 'bold')

" Barbar Buffer stuff
call s:Col('BufferCurrent', 'magenta')
call s:Col('BufferCurrentMod', 'magenta')
call s:Col('BufferCurrentSign', 'magenta')
call s:Col('BufferCurrentTarget', 'fg_normal', 'magenta')
call s:Col('BufferVisibleTarget', 'fg_normal', 'magenta')
call s:Col('BufferInactive', 'fg_normal', 'bg_darker')
call s:Col('BufferInactiveMod', 'fg_normal', 'bg_darker')
call s:Col('BufferInactiveSign', 'fg_normal', 'bg_darker')
call s:Col('BufferInactiveIndex', 'fg_normal', 'bg_darker')
call s:Col('BufferInactiveIcon', 'fg_normal', 'bg_darker')
call s:Col('BufferOffset', 'fg_normal', 'bg_darker')
call s:Col('BufferTabpages', 'red', 'bg_darker')
call s:Col('BufferTabpageFill', 'fg_normal', 'bg_darker')

" Cleanup =====================================================================

unlet s:colors

" Nvim-LSP diagnostic colors
hi LspDiagnosticsDefaultHint        ctermfg=Magenta guifg=#cc32cc
hi LspDiagnosticsDefaultError       ctermfg=Red     guifg=#cc1624
hi LspDiagnosticsDefaultWarning     ctermfg=Yellow  guifg=#cc991b
hi LspDiagnosticsDefaultInformation ctermfg=Blue    guifg=#0c74ce


" End of gotham-esque settings

hi SpecialComment guifg=#a62843 guibg=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Typedef guifg=#5f5f87 guibg=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi PreCondit guifg=#af875f guibg=NONE gui=NONE ctermfg=137 ctermbg=NONE cterm=NONE
hi Include guifg=#a62843 guibg=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Float guifg=#a8a8a8 guibg=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Debug guifg=#a62843 guibg=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#a62843 guibg=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Conditional guifg=#a62843 guibg=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi StorageClass guifg=#5f5f87 guibg=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Label guifg=#a62843 guibg=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Delimiter guifg=#a62843 guibg=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Character guifg=#a8a8a8 guibg=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Boolean guifg=#a8a8a8 guibg=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Operator guifg=#dadada guibg=NONE gui=bold ctermfg=253 ctermbg=NONE cterm=bold
hi WarningMsg guifg=#a8a8a8 guibg=#870000 gui=NONE ctermfg=248 ctermbg=88 cterm=NONE
hi VisualNOS guifg=#262626 guibg=#d7d7ff gui=underline ctermfg=235 ctermbg=189 cterm=underline
hi Define guifg=#a62843 guibg=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Function guifg=#5f5f87 guibg=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi MoreMsg guifg=#a62843 guibg=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi SpellCap guifg=#d7d7ff guibg=#262626 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Exception guifg=#a62843 guibg=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Keyword guifg=#a62843 guibg=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Type guifg=#5f5f87 guibg=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Error guifg=#a8a8a8 guibg=#870000 gui=NONE ctermfg=248 ctermbg=88 cterm=NONE
hi Tag guifg=#a62843 guibg=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi LocalVariable guifg=#ff875f guibg=NONE gui=bold ctermfg=209 ctermbg=NONE cterm=bold
hi Repeat guifg=#a62843 guibg=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Structure guifg=#5f5f87 guibg=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Macro guifg=#a62843 guibg=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
