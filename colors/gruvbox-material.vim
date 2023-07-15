" -----------------------------------------------------------------------------
" Name:           Gruvbox Material
" Description:    Gruvbox with Material Palette
" Author:         sainnhe <i@sainnhe.dev>
" Website:        https://github.com/sainnhe/gruvbox-material
" License:        MIT
" -----------------------------------------------------------------------------

" Initialization: {{{
let s:configuration = gruvbox_material#get_configuration()
let s:palette = gruvbox_material#get_palette(s:configuration.background, s:configuration.foreground, s:configuration.colors_override)
let s:path = expand('<sfile>:p') " the path of this script
let s:last_modified = 'Mon Apr 24 19:15:08 UTC 2023'
let g:gruvbox_material_loaded_file_types = []

if !(exists('g:colors_name') && g:colors_name ==# 'gruvbox-material' && s:configuration.better_performance)
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'gruvbox-material'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif
" }}}
" Common Highlight Groups: {{{
" UI: {{{
if s:configuration.transparent_background >= 1
  call gruvbox_material#highlight('Normal', s:palette.fg0, s:palette.none)
  call gruvbox_material#highlight('NormalNC', s:palette.fg0, s:palette.none)
  call gruvbox_material#highlight('Terminal', s:palette.fg0, s:palette.none)
  if s:configuration.show_eob
    call gruvbox_material#highlight('EndOfBuffer', s:palette.bg5, s:palette.none)
  else
    call gruvbox_material#highlight('EndOfBuffer', s:palette.bg0, s:palette.none)
  endif
  if s:configuration.ui_contrast ==# 'low'
    call gruvbox_material#highlight('FoldColumn', s:palette.bg5, s:palette.none)
  else
    call gruvbox_material#highlight('FoldColumn', s:palette.grey0, s:palette.none)
  endif
  call gruvbox_material#highlight('Folded', s:palette.grey1, s:palette.none)
  call gruvbox_material#highlight('SignColumn', s:palette.fg0, s:palette.none)
  call gruvbox_material#highlight('ToolbarLine', s:palette.fg0, s:palette.none)
else
  call gruvbox_material#highlight('Normal', s:palette.fg0, s:palette.bg0)
  if s:configuration.dim_inactive_windows
    call gruvbox_material#highlight('NormalNC', s:palette.fg0, s:palette.bg_dim)
  else
    call gruvbox_material#highlight('NormalNC', s:palette.fg0, s:palette.bg0)
  endif
  call gruvbox_material#highlight('Terminal', s:palette.fg0, s:palette.bg0)
  if s:configuration.show_eob
    if s:configuration.dim_inactive_windows
      call gruvbox_material#highlight('EndOfBuffer', s:palette.bg4, s:palette.bg_dim)
    else
      call gruvbox_material#highlight('EndOfBuffer', s:palette.bg5, s:palette.bg0)
    endif
  else
    if s:configuration.dim_inactive_windows
      call gruvbox_material#highlight('EndOfBuffer', s:palette.bg_dim, s:palette.bg_dim)
    else
      call gruvbox_material#highlight('EndOfBuffer', s:palette.bg0, s:palette.bg0)
    endif
  endif
  call gruvbox_material#highlight('Folded', s:palette.grey1, s:palette.bg2)
  call gruvbox_material#highlight('ToolbarLine', s:palette.fg1, s:palette.bg3)
  if s:configuration.sign_column_background ==# 'grey'
    call gruvbox_material#highlight('SignColumn', s:palette.fg0, s:palette.bg2)
    call gruvbox_material#highlight('FoldColumn', s:palette.grey1, s:palette.bg2)
  else
    call gruvbox_material#highlight('SignColumn', s:palette.fg0, s:palette.none)
    if s:configuration.ui_contrast ==# 'low'
      call gruvbox_material#highlight('FoldColumn', s:palette.bg5, s:palette.none)
    else
      call gruvbox_material#highlight('FoldColumn', s:palette.grey0, s:palette.none)
    endif
  endif
endif
call gruvbox_material#highlight('IncSearch', s:palette.bg0, s:palette.bg_red)
call gruvbox_material#highlight('Search', s:palette.bg0, s:palette.bg_green)
highlight! link CurSearch IncSearch
call gruvbox_material#highlight('ColorColumn', s:palette.none, s:palette.bg2)
if s:configuration.ui_contrast ==# 'low'
  call gruvbox_material#highlight('Conceal', s:palette.bg5, s:palette.none)
else
  call gruvbox_material#highlight('Conceal', s:palette.grey0, s:palette.none)
endif
if s:configuration.cursor ==# 'auto'
  call gruvbox_material#highlight('Cursor', s:palette.none, s:palette.none, 'reverse')
else
  call gruvbox_material#highlight('Cursor', s:palette.bg0, s:palette[s:configuration.cursor])
endif
highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
if &diff
  call gruvbox_material#highlight('CursorLine', s:palette.none, s:palette.none, 'underline')
  call gruvbox_material#highlight('CursorColumn', s:palette.none, s:palette.none, 'bold')
else
  call gruvbox_material#highlight('CursorLine', s:palette.none, s:palette.bg1)
  call gruvbox_material#highlight('CursorColumn', s:palette.none, s:palette.bg1)
endif
call gruvbox_material#highlight('LineNr', s:palette.bg5, s:palette.none)
if &diff
  call gruvbox_material#highlight('CursorLineNr', s:palette.grey1, s:palette.none, 'underline')
elseif (&relativenumber == 1 && &cursorline == 0) || s:configuration.sign_column_background ==# 'none'
  call gruvbox_material#highlight('CursorLineNr', s:palette.grey1, s:palette.none)
else
  call gruvbox_material#highlight('CursorLineNr', s:palette.grey1, s:palette.bg1)
endif
call gruvbox_material#highlight('DiffAdd', s:palette.none, s:palette.bg_diff_green)
call gruvbox_material#highlight('DiffChange', s:palette.none, s:palette.bg_diff_blue)
call gruvbox_material#highlight('DiffDelete', s:palette.none, s:palette.bg_diff_red)
call gruvbox_material#highlight('DiffText', s:palette.bg0, s:palette.blue)
call gruvbox_material#highlight('Directory', s:palette.green, s:palette.none)
call gruvbox_material#highlight('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
if s:configuration.ui_contrast ==# 'low'
  call gruvbox_material#highlight('LineNr', s:palette.bg5, s:palette.none)
  if &diff
    call gruvbox_material#highlight('CursorLineNr', s:palette.grey1, s:palette.none, 'underline')
  elseif (&relativenumber == 1 && &cursorline == 0) || s:configuration.sign_column_background ==# 'none'
    call gruvbox_material#highlight('CursorLineNr', s:palette.grey1, s:palette.none)
  else
    call gruvbox_material#highlight('CursorLineNr', s:palette.grey1, s:palette.bg1)
  endif
else
  call gruvbox_material#highlight('LineNr', s:palette.grey0, s:palette.none)
  if &diff
    call gruvbox_material#highlight('CursorLineNr', s:palette.grey2, s:palette.none, 'underline')
  elseif (&relativenumber == 1 && &cursorline == 0) || s:configuration.sign_column_background ==# 'none'
    call gruvbox_material#highlight('CursorLineNr', s:palette.grey2, s:palette.none)
  else
    call gruvbox_material#highlight('CursorLineNr', s:palette.grey2, s:palette.bg1)
  endif
endif
call gruvbox_material#highlight('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call gruvbox_material#highlight('ModeMsg', s:palette.fg0, s:palette.none, 'bold')
call gruvbox_material#highlight('MoreMsg', s:palette.yellow, s:palette.none, 'bold')
call gruvbox_material#highlight('MatchParen', s:palette.none, s:palette.bg4)
call gruvbox_material#highlight('NonText', s:palette.bg5, s:palette.none)
call gruvbox_material#highlight('Whitespace', s:palette.bg5, s:palette.none)
call gruvbox_material#highlight('SpecialKey', s:palette.bg5, s:palette.none)
call gruvbox_material#highlight('Pmenu', s:palette.fg1, s:palette.bg3)
call gruvbox_material#highlight('PmenuSbar', s:palette.none, s:palette.bg3)
if s:configuration.menu_selection_background ==# 'grey'
  call gruvbox_material#highlight('PmenuSel', s:palette.bg3, s:palette.grey2)
elseif s:configuration.menu_selection_background ==# 'green'
  call gruvbox_material#highlight('PmenuSel', s:palette.bg3, s:palette.bg_green)
elseif s:configuration.menu_selection_background ==# 'red'
  call gruvbox_material#highlight('PmenuSel', s:palette.bg3, s:palette.bg_red)
else
  call gruvbox_material#highlight('PmenuSel', s:palette.bg3, s:palette[s:configuration.menu_selection_background])
endif
call gruvbox_material#highlight('PmenuKind', s:palette.green, s:palette.bg3)
call gruvbox_material#highlight('PmenuExtra', s:palette.grey2, s:palette.bg3)
highlight! link WildMenu PmenuSel
call gruvbox_material#highlight('PmenuThumb', s:palette.none, s:palette.grey0)
call gruvbox_material#highlight('NormalFloat', s:palette.fg1, s:palette.bg3)
call gruvbox_material#highlight('FloatBorder', s:palette.grey1, s:palette.bg3)
call gruvbox_material#highlight('Question', s:palette.yellow, s:palette.none)
if s:configuration.spell_foreground ==# 'none'
  call gruvbox_material#highlight('SpellBad', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call gruvbox_material#highlight('SpellCap', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call gruvbox_material#highlight('SpellLocal', s:palette.none, s:palette.none, 'undercurl', s:palette.aqua)
  call gruvbox_material#highlight('SpellRare', s:palette.none, s:palette.none, 'undercurl', s:palette.purple)
else
  call gruvbox_material#highlight('SpellBad', s:palette.red, s:palette.none, 'undercurl', s:palette.red)
  call gruvbox_material#highlight('SpellCap', s:palette.blue, s:palette.none, 'undercurl', s:palette.blue)
  call gruvbox_material#highlight('SpellLocal', s:palette.aqua, s:palette.none, 'undercurl', s:palette.aqua)
  call gruvbox_material#highlight('SpellRare', s:palette.purple, s:palette.none, 'undercurl', s:palette.purple)
endif
if s:configuration.transparent_background == 2
  if s:configuration.statusline_style ==# 'original'
    call gruvbox_material#highlight('StatusLine', s:palette.grey2, s:palette.none)
    call gruvbox_material#highlight('StatusLineTerm', s:palette.grey2, s:palette.none)
    call gruvbox_material#highlight('StatusLineNC', s:palette.grey1, s:palette.none)
    call gruvbox_material#highlight('StatusLineTermNC', s:palette.grey1, s:palette.none)
    call gruvbox_material#highlight('TabLine', s:palette.grey2, s:palette.bg_statusline2)
    call gruvbox_material#highlight('TabLineFill', s:palette.grey2, s:palette.none)
    call gruvbox_material#highlight('TabLineSel', s:palette.bg0, s:palette.grey2)
  elseif s:configuration.statusline_style ==# 'mix'
    call gruvbox_material#highlight('StatusLine', s:palette.grey2, s:palette.none)
    call gruvbox_material#highlight('StatusLineTerm', s:palette.grey2, s:palette.none)
    call gruvbox_material#highlight('StatusLineNC', s:palette.grey1, s:palette.none)
    call gruvbox_material#highlight('StatusLineTermNC', s:palette.grey1, s:palette.none)
    call gruvbox_material#highlight('TabLine', s:palette.grey2, s:palette.bg_statusline3)
    call gruvbox_material#highlight('TabLineFill', s:palette.grey2, s:palette.none)
    call gruvbox_material#highlight('TabLineSel', s:palette.bg0, s:palette.grey2)
  else
    call gruvbox_material#highlight('StatusLine', s:palette.fg1, s:palette.none)
    call gruvbox_material#highlight('StatusLineTerm', s:palette.fg1, s:palette.none)
    call gruvbox_material#highlight('StatusLineNC', s:palette.grey1, s:palette.none)
    call gruvbox_material#highlight('StatusLineTermNC', s:palette.grey1, s:palette.none)
    call gruvbox_material#highlight('TabLine', s:palette.fg1, s:palette.bg_statusline3)
    call gruvbox_material#highlight('TabLineFill', s:palette.fg1, s:palette.none)
    call gruvbox_material#highlight('TabLineSel', s:palette.bg0, s:palette.grey2)
  endif
else
  if s:configuration.statusline_style ==# 'original'
    call gruvbox_material#highlight('StatusLine', s:palette.grey2, s:palette.bg_statusline2)
    call gruvbox_material#highlight('StatusLineTerm', s:palette.grey2, s:palette.bg_statusline2)
    call gruvbox_material#highlight('StatusLineNC', s:palette.grey1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('StatusLineTermNC', s:palette.grey1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('TabLine', s:palette.grey2, s:palette.bg_statusline2)
    call gruvbox_material#highlight('TabLineFill', s:palette.grey2, s:palette.bg0)
    call gruvbox_material#highlight('TabLineSel', s:palette.bg0, s:palette.grey2)
  elseif s:configuration.statusline_style ==# 'mix'
    call gruvbox_material#highlight('StatusLine', s:palette.grey2, s:palette.bg_statusline2)
    call gruvbox_material#highlight('StatusLineTerm', s:palette.grey2, s:palette.bg_statusline2)
    call gruvbox_material#highlight('StatusLineNC', s:palette.grey1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('StatusLineTermNC', s:palette.grey1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('TabLine', s:palette.grey2, s:palette.bg_statusline3)
    call gruvbox_material#highlight('TabLineFill', s:palette.grey2, s:palette.bg_statusline2)
    call gruvbox_material#highlight('TabLineSel', s:palette.bg0, s:palette.grey2)
  else
    call gruvbox_material#highlight('StatusLine', s:palette.fg1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('StatusLineTerm', s:palette.fg1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('StatusLineNC', s:palette.grey1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('StatusLineTermNC', s:palette.grey1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('TabLine', s:palette.fg1, s:palette.bg_statusline3)
    call gruvbox_material#highlight('TabLineFill', s:palette.fg1, s:palette.bg_statusline1)
    call gruvbox_material#highlight('TabLineSel', s:palette.bg0, s:palette.grey2)
  endif
endif
if s:configuration.dim_inactive_windows
  call gruvbox_material#highlight('VertSplit', s:palette.bg4, s:palette.bg_dim)
else
  call gruvbox_material#highlight('VertSplit', s:palette.bg5, s:palette.none)
endif
highlight! link WinSeparator VertSplit
if s:configuration.visual ==# 'grey background'
  call gruvbox_material#highlight('Visual', s:palette.none, s:palette.bg3)
  call gruvbox_material#highlight('VisualNOS', s:palette.none, s:palette.bg3)
elseif s:configuration.visual ==# 'green background'
  call gruvbox_material#highlight('Visual', s:palette.none, s:palette.bg_visual_green)
  call gruvbox_material#highlight('VisualNOS', s:palette.none, s:palette.bg_visual_green)
elseif s:configuration.visual ==# 'blue background'
  call gruvbox_material#highlight('Visual', s:palette.none, s:palette.bg_visual_blue)
  call gruvbox_material#highlight('VisualNOS', s:palette.none, s:palette.bg_visual_blue)
elseif s:configuration.visual ==# 'red background'
  call gruvbox_material#highlight('Visual', s:palette.none, s:palette.bg_visual_red)
  call gruvbox_material#highlight('VisualNOS', s:palette.none, s:palette.bg_visual_red)
elseif s:configuration.visual ==# 'reverse'
  call gruvbox_material#highlight('Visual', s:palette.none, s:palette.none, 'reverse')
  call gruvbox_material#highlight('VisualNOS', s:palette.none, s:palette.none, 'reverse')
endif
call gruvbox_material#highlight('QuickFixLine', s:palette.purple, s:palette.none, 'bold')
call gruvbox_material#highlight('Debug', s:palette.orange, s:palette.none)
call gruvbox_material#highlight('debugPC', s:palette.bg0, s:palette.green)
call gruvbox_material#highlight('debugBreakpoint', s:palette.bg0, s:palette.red)
call gruvbox_material#highlight('ToolbarButton', s:palette.bg0, s:palette.grey2)
if has('nvim')
  call gruvbox_material#highlight('Substitute', s:palette.bg0, s:palette.yellow)
  highlight! link WinBarNC Grey
  highlight! link DiagnosticFloatingError ErrorFloat
  highlight! link DiagnosticFloatingWarn WarningFloat
  highlight! link DiagnosticFloatingInfo InfoFloat
  highlight! link DiagnosticFloatingHint HintFloat
  highlight! link DiagnosticError ErrorText
  highlight! link DiagnosticWarn WarningText
  highlight! link DiagnosticInfo InfoText
  highlight! link DiagnosticHint HintText
  highlight! link DiagnosticVirtualTextError VirtualTextError
  highlight! link DiagnosticVirtualTextWarn VirtualTextWarning
  highlight! link DiagnosticVirtualTextInfo VirtualTextInfo
  highlight! link DiagnosticVirtualTextHint VirtualTextHint
  highlight! link DiagnosticUnderlineError ErrorText
  highlight! link DiagnosticUnderlineWarn WarningText
  highlight! link DiagnosticUnderlineInfo InfoText
  highlight! link DiagnosticUnderlineHint HintText
  highlight! link DiagnosticSignError RedSign
  highlight! link DiagnosticSignWarn YellowSign
  highlight! link DiagnosticSignInfo BlueSign
  highlight! link DiagnosticSignHint GreenSign
  highlight! link LspDiagnosticsFloatingError DiagnosticFloatingError
  highlight! link LspDiagnosticsFloatingWarning DiagnosticFloatingWarn
  highlight! link LspDiagnosticsFloatingInformation DiagnosticFloatingInfo
  highlight! link LspDiagnosticsFloatingHint DiagnosticFloatingHint
  highlight! link LspDiagnosticsDefaultError DiagnosticError
  highlight! link LspDiagnosticsDefaultWarning DiagnosticWarn
  highlight! link LspDiagnosticsDefaultInformation DiagnosticInfo
  highlight! link LspDiagnosticsDefaultHint DiagnosticHint
  highlight! link LspDiagnosticsVirtualTextError DiagnosticVirtualTextError
  highlight! link LspDiagnosticsVirtualTextWarning DiagnosticVirtualTextWarn
  highlight! link LspDiagnosticsVirtualTextInformation DiagnosticVirtualTextInfo
  highlight! link LspDiagnosticsVirtualTextHint DiagnosticVirtualTextHint
  highlight! link LspDiagnosticsUnderlineError DiagnosticUnderlineError
  highlight! link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn
  highlight! link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo
  highlight! link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint
  highlight! link LspDiagnosticsSignError DiagnosticSignError
  highlight! link LspDiagnosticsSignWarning DiagnosticSignWarn
  highlight! link LspDiagnosticsSignInformation DiagnosticSignInfo
  highlight! link LspDiagnosticsSignHint DiagnosticSignHint
  highlight! link LspReferenceText CurrentWord
  highlight! link LspReferenceRead CurrentWord
  highlight! link LspReferenceWrite CurrentWord
  highlight! link LspCodeLens VirtualTextInfo
  highlight! link LspCodeLensSeparator VirtualTextHint
  highlight! link LspSignatureActiveParameter Search
  highlight! link TermCursor Cursor
  highlight! link healthError Red
  highlight! link healthSuccess Green
  highlight! link healthWarning Yellow
endif
" }}}
" Syntax: {{{
call gruvbox_material#highlight('Boolean', s:palette.purple, s:palette.none)
call gruvbox_material#highlight('Number', s:palette.purple, s:palette.none)
call gruvbox_material#highlight('Float', s:palette.purple, s:palette.none)
if s:configuration.enable_italic
  call gruvbox_material#highlight('PreProc', s:palette.purple, s:palette.none, 'italic')
  call gruvbox_material#highlight('PreCondit', s:palette.purple, s:palette.none, 'italic')
  call gruvbox_material#highlight('Include', s:palette.purple, s:palette.none, 'italic')
  call gruvbox_material#highlight('Define', s:palette.purple, s:palette.none, 'italic')
  call gruvbox_material#highlight('Conditional', s:palette.red, s:palette.none, 'italic')
  call gruvbox_material#highlight('Repeat', s:palette.red, s:palette.none, 'italic')
  call gruvbox_material#highlight('Keyword', s:palette.red, s:palette.none, 'italic')
  call gruvbox_material#highlight('Typedef', s:palette.red, s:palette.none, 'italic')
  call gruvbox_material#highlight('Exception', s:palette.red, s:palette.none, 'italic')
  call gruvbox_material#highlight('Statement', s:palette.red, s:palette.none, 'italic')
else
  call gruvbox_material#highlight('PreProc', s:palette.purple, s:palette.none)
  call gruvbox_material#highlight('PreCondit', s:palette.purple, s:palette.none)
  call gruvbox_material#highlight('Include', s:palette.purple, s:palette.none)
  call gruvbox_material#highlight('Define', s:palette.purple, s:palette.none)
  call gruvbox_material#highlight('Conditional', s:palette.red, s:palette.none)
  call gruvbox_material#highlight('Repeat', s:palette.red, s:palette.none)
  call gruvbox_material#highlight('Keyword', s:palette.red, s:palette.none)
  call gruvbox_material#highlight('Typedef', s:palette.red, s:palette.none)
  call gruvbox_material#highlight('Exception', s:palette.red, s:palette.none)
  call gruvbox_material#highlight('Statement', s:palette.red, s:palette.none)
endif
call gruvbox_material#highlight('Error', s:palette.red, s:palette.none)
call gruvbox_material#highlight('StorageClass', s:palette.orange, s:palette.none)
call gruvbox_material#highlight('Tag', s:palette.orange, s:palette.none)
call gruvbox_material#highlight('Label', s:palette.orange, s:palette.none)
call gruvbox_material#highlight('Structure', s:palette.orange, s:palette.none)
call gruvbox_material#highlight('Operator', s:palette.orange, s:palette.none)
call gruvbox_material#highlight('Title', s:palette.orange, s:palette.none, 'bold')
call gruvbox_material#highlight('Special', s:palette.yellow, s:palette.none)
call gruvbox_material#highlight('SpecialChar', s:palette.yellow, s:palette.none)
call gruvbox_material#highlight('Type', s:palette.yellow, s:palette.none)
if s:configuration.enable_bold
  call gruvbox_material#highlight('Function', s:palette.green, s:palette.none, 'bold')
else
  call gruvbox_material#highlight('Function', s:palette.green, s:palette.none)
endif
call gruvbox_material#highlight('String', s:palette.green, s:palette.none)
call gruvbox_material#highlight('Character', s:palette.green, s:palette.none)
call gruvbox_material#highlight('Constant', s:palette.aqua, s:palette.none)
call gruvbox_material#highlight('Macro', s:palette.aqua, s:palette.none)
call gruvbox_material#highlight('Identifier', s:palette.blue, s:palette.none)
call gruvbox_material#highlight('Todo', s:palette.bg0, s:palette.blue, 'bold')
if s:configuration.disable_italic_comment
  call gruvbox_material#highlight('Comment', s:palette.grey1, s:palette.none)
  call gruvbox_material#highlight('SpecialComment', s:palette.grey1, s:palette.none)
else
  call gruvbox_material#highlight('Comment', s:palette.grey1, s:palette.none, 'italic')
  call gruvbox_material#highlight('SpecialComment', s:palette.grey1, s:palette.none, 'italic')
endif
call gruvbox_material#highlight('Delimiter', s:palette.fg0, s:palette.none)
call gruvbox_material#highlight('Ignore', s:palette.grey1, s:palette.none)
call gruvbox_material#highlight('Underlined', s:palette.none, s:palette.none, 'underline')
" }}}
" Predefined Highlight Groups: {{{
call gruvbox_material#highlight('Fg', s:palette.fg0, s:palette.none)
call gruvbox_material#highlight('Grey', s:palette.grey1, s:palette.none)
call gruvbox_material#highlight('Red', s:palette.red, s:palette.none)
call gruvbox_material#highlight('Orange', s:palette.orange, s:palette.none)
call gruvbox_material#highlight('Yellow', s:palette.yellow, s:palette.none)
call gruvbox_material#highlight('Green', s:palette.green, s:palette.none)
call gruvbox_material#highlight('Aqua', s:palette.aqua, s:palette.none)
call gruvbox_material#highlight('Blue', s:palette.blue, s:palette.none)
call gruvbox_material#highlight('Purple', s:palette.purple, s:palette.none)
if s:configuration.enable_italic
  call gruvbox_material#highlight('RedItalic', s:palette.red, s:palette.none, 'italic')
  call gruvbox_material#highlight('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
  call gruvbox_material#highlight('YellowItalic', s:palette.yellow, s:palette.none, 'italic')
  call gruvbox_material#highlight('GreenItalic', s:palette.green, s:palette.none, 'italic')
  call gruvbox_material#highlight('AquaItalic', s:palette.aqua, s:palette.none, 'italic')
  call gruvbox_material#highlight('BlueItalic', s:palette.blue, s:palette.none, 'italic')
  call gruvbox_material#highlight('PurpleItalic', s:palette.purple, s:palette.none, 'italic')
else
  call gruvbox_material#highlight('RedItalic', s:palette.red, s:palette.none)
  call gruvbox_material#highlight('OrangeItalic', s:palette.orange, s:palette.none)
  call gruvbox_material#highlight('YellowItalic', s:palette.yellow, s:palette.none)
  call gruvbox_material#highlight('GreenItalic', s:palette.green, s:palette.none)
  call gruvbox_material#highlight('AquaItalic', s:palette.aqua, s:palette.none)
  call gruvbox_material#highlight('BlueItalic', s:palette.blue, s:palette.none)
  call gruvbox_material#highlight('PurpleItalic', s:palette.purple, s:palette.none)
endif
if s:configuration.enable_bold
  call gruvbox_material#highlight('RedBold', s:palette.red, s:palette.none, 'bold')
  call gruvbox_material#highlight('OrangeBold', s:palette.orange, s:palette.none, 'bold')
  call gruvbox_material#highlight('YellowBold', s:palette.yellow, s:palette.none, 'bold')
  call gruvbox_material#highlight('GreenBold', s:palette.green, s:palette.none, 'bold')
  call gruvbox_material#highlight('AquaBold', s:palette.aqua, s:palette.none, 'bold')
  call gruvbox_material#highlight('BlueBold', s:palette.blue, s:palette.none, 'bold')
  call gruvbox_material#highlight('PurpleBold', s:palette.purple, s:palette.none, 'bold')
else
  call gruvbox_material#highlight('RedBold', s:palette.red, s:palette.none)
  call gruvbox_material#highlight('OrangeBold', s:palette.orange, s:palette.none)
  call gruvbox_material#highlight('YellowBold', s:palette.yellow, s:palette.none)
  call gruvbox_material#highlight('GreenBold', s:palette.green, s:palette.none)
  call gruvbox_material#highlight('AquaBold', s:palette.aqua, s:palette.none)
  call gruvbox_material#highlight('BlueBold', s:palette.blue, s:palette.none)
  call gruvbox_material#highlight('PurpleBold', s:palette.purple, s:palette.none)
endif
if s:configuration.transparent_background || s:configuration.sign_column_background ==# 'none'
  call gruvbox_material#highlight('RedSign', s:palette.red, s:palette.none)
  call gruvbox_material#highlight('OrangeSign', s:palette.orange, s:palette.none)
  call gruvbox_material#highlight('YellowSign', s:palette.yellow, s:palette.none)
  call gruvbox_material#highlight('GreenSign', s:palette.green, s:palette.none)
  call gruvbox_material#highlight('AquaSign', s:palette.aqua, s:palette.none)
  call gruvbox_material#highlight('BlueSign', s:palette.blue, s:palette.none)
  call gruvbox_material#highlight('PurpleSign', s:palette.purple, s:palette.none)
else
  call gruvbox_material#highlight('RedSign', s:palette.red, s:palette.bg2)
  call gruvbox_material#highlight('OrangeSign', s:palette.orange, s:palette.bg2)
  call gruvbox_material#highlight('YellowSign', s:palette.yellow, s:palette.bg2)
  call gruvbox_material#highlight('GreenSign', s:palette.green, s:palette.bg2)
  call gruvbox_material#highlight('AquaSign', s:palette.aqua, s:palette.bg2)
  call gruvbox_material#highlight('BlueSign', s:palette.blue, s:palette.bg2)
  call gruvbox_material#highlight('PurpleSign', s:palette.purple, s:palette.bg2)
endif
if s:configuration.diagnostic_text_highlight
  call gruvbox_material#highlight('ErrorText', s:palette.none, s:palette.bg_visual_red, 'undercurl', s:palette.red)
  call gruvbox_material#highlight('WarningText', s:palette.none, s:palette.bg_visual_yellow, 'undercurl', s:palette.yellow)
  call gruvbox_material#highlight('InfoText', s:palette.none, s:palette.bg_visual_blue, 'undercurl', s:palette.blue)
  call gruvbox_material#highlight('HintText', s:palette.none, s:palette.bg_visual_green, 'undercurl', s:palette.green)
else
  call gruvbox_material#highlight('ErrorText', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call gruvbox_material#highlight('WarningText', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
  call gruvbox_material#highlight('InfoText', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call gruvbox_material#highlight('HintText', s:palette.none, s:palette.none, 'undercurl', s:palette.green)
endif
if s:configuration.diagnostic_line_highlight
  call gruvbox_material#highlight('ErrorLine', s:palette.none, s:palette.bg_visual_red)
  call gruvbox_material#highlight('WarningLine', s:palette.none, s:palette.bg_visual_yellow)
  call gruvbox_material#highlight('InfoLine', s:palette.none, s:palette.bg_visual_blue)
  call gruvbox_material#highlight('HintLine', s:palette.none, s:palette.bg_visual_green)
else
  highlight clear ErrorLine
  highlight clear WarningLine
  highlight clear InfoLine
  highlight clear HintLine
endif
if s:configuration.diagnostic_virtual_text ==# 'grey'
  highlight! link VirtualTextWarning Grey
  highlight! link VirtualTextError Grey
  highlight! link VirtualTextInfo Grey
  highlight! link VirtualTextHint Grey
elseif s:configuration.diagnostic_virtual_text ==# 'colored'
  highlight! link VirtualTextWarning Yellow
  highlight! link VirtualTextError Red
  highlight! link VirtualTextInfo Blue
  highlight! link VirtualTextHint Green
else
  call gruvbox_material#highlight('VirtualTextWarning', s:palette.yellow, s:palette.bg_visual_yellow)
  call gruvbox_material#highlight('VirtualTextError', s:palette.red, s:palette.bg_visual_red)
  call gruvbox_material#highlight('VirtualTextInfo', s:palette.blue, s:palette.bg_visual_blue)
  call gruvbox_material#highlight('VirtualTextHint', s:palette.green, s:palette.bg_visual_green)
endif
call gruvbox_material#highlight('ErrorFloat', s:palette.red, s:palette.bg3)
call gruvbox_material#highlight('WarningFloat', s:palette.yellow, s:palette.bg3)
call gruvbox_material#highlight('InfoFloat', s:palette.blue, s:palette.bg3)
call gruvbox_material#highlight('HintFloat', s:palette.green, s:palette.bg3)
if &diff
  call gruvbox_material#highlight('CurrentWord', s:palette.bg0, s:palette.bg_green)
elseif s:configuration.current_word ==# 'grey background'
  call gruvbox_material#highlight('CurrentWord', s:palette.none, s:palette.bg_current_word)
else
  call gruvbox_material#highlight('CurrentWord', s:palette.none, s:palette.none, s:configuration.current_word)
endif
" Define a color for each LSP item kind to create highlights for nvim-cmp, aerial.nvim, nvim-navic and coc.nvim
let g:gruvbox_material_lsp_kind_color = [
      \ ["Array", "Aqua"],
      \ ["Boolean", "Aqua"],
      \ ["Class", "Red"],
      \ ["Color", "Aqua"],
      \ ["Constant", "Blue"],
      \ ["Constructor", "Green"],
      \ ["Default", "Aqua"],
      \ ["Enum", "Yellow"],
      \ ["EnumMember", "Purple"],
      \ ["Event", "Orange"],
      \ ["Field", "Green"],
      \ ["File", "Green"],
      \ ["Folder", "Aqua"],
      \ ["Function", "Green"],
      \ ["Interface", "Yellow"],
      \ ["Key", "Red"],
      \ ["Keyword", "Red"],
      \ ["Method", "Green"],
      \ ["Module", "Purple"],
      \ ["Namespace", "Purple"],
      \ ["Null", "Aqua"],
      \ ["Number", "Aqua"],
      \ ["Object", "Aqua"],
      \ ["Operator", "Orange"],
      \ ["Package", "Purple"],
      \ ["Property", "Blue"],
      \ ["Reference", "Aqua"],
      \ ["Snippet", "Aqua"],
      \ ["String", "Aqua"],
      \ ["Struct", "Yellow"],
      \ ["Text", "Fg"],
      \ ["TypeParameter", "Yellow"],
      \ ["Unit", "Purple"],
      \ ["Value", "Purple"],
      \ ["Variable", "Blue"],
      \ ]
" }}}
" }}}
" Terminal: {{{
if ((has('termguicolors') && &termguicolors) || has('gui_running')) && !s:configuration.disable_terminal_colors
  " Definition
  let s:terminal = {
        \ 'black':         &background ==# 'dark' ? s:palette.bg5 : s:palette.fg0,
        \ 'red':           s:palette.red,
        \ 'yellow':        s:palette.yellow,
        \ 'green':         s:palette.green,
        \ 'cyan':          s:palette.aqua,
        \ 'blue':          s:palette.blue,
        \ 'purple':        s:palette.purple,
        \ 'white':         &background ==# 'dark' ? s:palette.fg0 : s:palette.bg5,
        \ }
  " Implementation: {{{
  if !has('nvim')
    let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
          \ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
          \ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]
  else
    let g:terminal_color_0 = s:terminal.black[0]
    let g:terminal_color_1 = s:terminal.red[0]
    let g:terminal_color_2 = s:terminal.green[0]
    let g:terminal_color_3 = s:terminal.yellow[0]
    let g:terminal_color_4 = s:terminal.blue[0]
    let g:terminal_color_5 = s:terminal.purple[0]
    let g:terminal_color_6 = s:terminal.cyan[0]
    let g:terminal_color_7 = s:terminal.white[0]
    let g:terminal_color_8 = s:terminal.black[0]
    let g:terminal_color_9 = s:terminal.red[0]
    let g:terminal_color_10 = s:terminal.green[0]
    let g:terminal_color_11 = s:terminal.yellow[0]
    let g:terminal_color_12 = s:terminal.blue[0]
    let g:terminal_color_13 = s:terminal.purple[0]
    let g:terminal_color_14 = s:terminal.cyan[0]
    let g:terminal_color_15 = s:terminal.white[0]
  endif
  " }}}
endif
" }}}
" Plugins: {{{
" nvim-treesitter/nvim-treesitter {{{
call gruvbox_material#highlight('TSStrong', s:palette.none, s:palette.none, 'bold')
call gruvbox_material#highlight('TSEmphasis', s:palette.none, s:palette.none, 'italic')
call gruvbox_material#highlight('TSUnderline', s:palette.none, s:palette.none, 'underline')
call gruvbox_material#highlight('TSNote', s:palette.bg0, s:palette.green, 'bold')
call gruvbox_material#highlight('TSWarning', s:palette.bg0, s:palette.yellow, 'bold')
call gruvbox_material#highlight('TSDanger', s:palette.bg0, s:palette.red, 'bold')
highlight! link TSAnnotation Purple
highlight! link TSAttribute Purple
highlight! link TSBoolean Purple
highlight! link TSCharacter Aqua
highlight! link TSCharacterSpecial SpecialChar
highlight! link TSComment Comment
highlight! link TSConditional Red
highlight! link TSConstBuiltin PurpleItalic
highlight! link TSConstMacro PurpleItalic
highlight! link TSConstant Fg
highlight! link TSConstructor GreenBold
highlight! link TSDebug Debug
highlight! link TSDefine Define
highlight! link TSEnvironment Macro
highlight! link TSEnvironmentName Type
highlight! link TSError Error
highlight! link TSException Red
highlight! link TSField Blue
highlight! link TSFloat Purple
highlight! link TSFuncBuiltin GreenBold
highlight! link TSFuncMacro GreenBold
highlight! link TSFunction GreenBold
highlight! link TSFunctionCall GreenBold
highlight! link TSInclude Red
highlight! link TSKeyword Red
highlight! link TSKeywordFunction Red
highlight! link TSKeywordOperator Orange
highlight! link TSKeywordReturn Red
highlight! link TSLabel Orange
highlight! link TSLiteral String
highlight! link TSMath Blue
highlight! link TSMethod GreenBold
highlight! link TSMethodCall GreenBold
highlight! link TSNamespace YellowItalic
highlight! link TSNone Fg
highlight! link TSNumber Purple
highlight! link TSOperator Orange
highlight! link TSParameter Fg
highlight! link TSParameterReference Fg
highlight! link TSPreProc PreProc
highlight! link TSProperty Blue
highlight! link TSPunctBracket Fg
highlight! link TSPunctDelimiter Grey
highlight! link TSPunctSpecial Blue
highlight! link TSRepeat Red
highlight! link TSStorageClass Orange
highlight! link TSStorageClassLifetime Orange
highlight! link TSStrike Grey
highlight! link TSString Aqua
highlight! link TSStringEscape Green
highlight! link TSStringRegex Green
highlight! link TSStringSpecial SpecialChar
highlight! link TSSymbol Fg
highlight! link TSTag Orange
highlight! link TSTagAttribute Green
highlight! link TSTagDelimiter Green
highlight! link TSText Green
highlight! link TSTextReference Constant
highlight! link TSTitle Title
highlight! link TSTodo Todo
highlight! link TSType YellowItalic
highlight! link TSTypeBuiltin YellowItalic
highlight! link TSTypeDefinition YellowItalic
highlight! link TSTypeQualifier Orange
highlight! link TSURI markdownUrl
highlight! link TSVariable Fg
highlight! link TSVariableBuiltin PurpleItalic
if has('nvim-0.8.0')
  highlight! link @annotation TSAnnotation
  highlight! link @attribute TSAttribute
  highlight! link @boolean TSBoolean
  highlight! link @character TSCharacter
  highlight! link @character.special TSCharacterSpecial
  highlight! link @comment TSComment
  highlight! link @conceal Grey
  highlight! link @conditional TSConditional
  highlight! link @constant TSConstant
  highlight! link @constant.builtin TSConstBuiltin
  highlight! link @constant.macro TSConstMacro
  highlight! link @constructor TSConstructor
  highlight! link @debug TSDebug
  highlight! link @define TSDefine
  highlight! link @error TSError
  highlight! link @exception TSException
  highlight! link @field TSField
  highlight! link @float TSFloat
  highlight! link @function TSFunction
  highlight! link @function.builtin TSFuncBuiltin
  highlight! link @function.call TSFunctionCall
  highlight! link @function.macro TSFuncMacro
  highlight! link @include TSInclude
  highlight! link @keyword TSKeyword
  highlight! link @keyword.function TSKeywordFunction
  highlight! link @keyword.operator TSKeywordOperator
  highlight! link @keyword.return TSKeywordReturn
  highlight! link @label TSLabel
  highlight! link @math TSMath
  highlight! link @method TSMethod
  highlight! link @method.call TSMethodCall
  highlight! link @namespace TSNamespace
  highlight! link @none TSNone
  highlight! link @number TSNumber
  highlight! link @operator TSOperator
  highlight! link @parameter TSParameter
  highlight! link @parameter.reference TSParameterReference
  highlight! link @preproc TSPreProc
  highlight! link @property TSProperty
  highlight! link @punctuation.bracket TSPunctBracket
  highlight! link @punctuation.delimiter TSPunctDelimiter
  highlight! link @punctuation.special TSPunctSpecial
  highlight! link @repeat TSRepeat
  highlight! link @storageclass TSStorageClass
  highlight! link @storageclass.lifetime TSStorageClassLifetime
  highlight! link @strike TSStrike
  highlight! link @string TSString
  highlight! link @string.escape TSStringEscape
  highlight! link @string.regex TSStringRegex
  highlight! link @string.special TSStringSpecial
  highlight! link @symbol TSSymbol
  highlight! link @tag TSTag
  highlight! link @tag.attribute TSTagAttribute
  highlight! link @tag.delimiter TSTagDelimiter
  highlight! link @text TSText
  highlight! link @text.danger TSDanger
  highlight! link @text.diff.add diffAdded
  highlight! link @text.diff.delete diffRemoved
  highlight! link @text.emphasis TSEmphasis
  highlight! link @text.environment TSEnvironment
  highlight! link @text.environment.name TSEnvironmentName
  highlight! link @text.literal TSLiteral
  highlight! link @text.math TSMath
  highlight! link @text.note TSNote
  highlight! link @text.reference TSTextReference
  highlight! link @text.strike TSStrike
  highlight! link @text.strong TSStrong
  highlight! link @text.title TSTitle
  highlight! link @text.todo TSTodo
  highlight! link @text.todo.checked Green
  highlight! link @text.todo.unchecked Ignore
  highlight! link @text.underline TSUnderline
  highlight! link @text.uri TSURI
  highlight! link @text.warning TSWarning
  highlight! link @todo TSTodo
  highlight! link @type TSType
  highlight! link @type.builtin TSTypeBuiltin
  highlight! link @type.definition TSTypeDefinition
  highlight! link @type.qualifier TSTypeQualifier
  highlight! link @uri TSURI
  highlight! link @variable TSVariable
  highlight! link @variable.builtin TSVariableBuiltin
endif
if has('nvim-0.9.0')
  highlight! link @lsp.type.class TSType
  highlight! link @lsp.type.comment TSComment
  highlight! link @lsp.type.decorator TSFunction
  highlight! link @lsp.type.enum TSType
  highlight! link @lsp.type.enumMember TSProperty
  highlight! link @lsp.type.events TSLabel
  highlight! link @lsp.type.function TSFunction
  highlight! link @lsp.type.interface TSType
  highlight! link @lsp.type.keyword TSKeyword
  highlight! link @lsp.type.macro TSConstMacro
  highlight! link @lsp.type.method TSMethod
  highlight! link @lsp.type.modifier TSTypeQualifier
  highlight! link @lsp.type.namespace TSNamespace
  highlight! link @lsp.type.number TSNumber
  highlight! link @lsp.type.operator TSOperator
  highlight! link @lsp.type.parameter TSParameter
  highlight! link @lsp.type.property TSProperty
  highlight! link @lsp.type.regexp TSStringRegex
  highlight! link @lsp.type.string TSString
  highlight! link @lsp.type.struct TSType
  highlight! link @lsp.type.type TSType
  highlight! link @lsp.type.typeParameter TSTypeDefinition
  highlight! link @lsp.type.variable TSVariable
  highlight! link DiagnosticUnnecessary WarningText
endif
highlight! link TSModuleInfoGood Green
highlight! link TSModuleInfoBad Red
" }}}
" voldikss/vim-floaterm {{{
highlight! link FloatermBorder Grey
" }}}
if has('nvim')
" hrsh7th/nvim-cmp {{{
call gruvbox_material#highlight('CmpItemAbbrMatch', s:palette.green, s:palette.none, 'bold')
call gruvbox_material#highlight('CmpItemAbbrMatchFuzzy', s:palette.green, s:palette.none, 'bold')
highlight! link CmpItemAbbr Fg
highlight! link CmpItemAbbrDeprecated Grey
highlight! link CmpItemMenu Fg
highlight! link CmpItemKind Yellow
for kind in g:gruvbox_material_lsp_kind_color
  execute "highlight! link CmpItemKind" . kind[0] . " " . kind[1]
endfor
" }}}
" nvim-telescope/telescope.nvim {{{
call gruvbox_material#highlight('TelescopeMatching', s:palette.green, s:palette.none, 'bold')
highlight! link TelescopeBorder Grey
highlight! link TelescopePromptPrefix Orange
highlight! link TelescopeSelection DiffAdd
" }}}
" lewis6991/gitsigns.nvim {{{
highlight! link GitSignsAdd GreenSign
highlight! link GitSignsChange BlueSign
highlight! link GitSignsDelete RedSign
highlight! link GitSignsAddNr Green
highlight! link GitSignsChangeNr Blue
highlight! link GitSignsDeleteNr Red
highlight! link GitSignsAddLn DiffAdd
highlight! link GitSignsChangeLn DiffChange
highlight! link GitSignsDeleteLn DiffDelete
highlight! link GitSignsCurrentLineBlame Grey
" }}}
" rcarriga/nvim-dap-ui {{{
call gruvbox_material#highlight('DapUIModifiedValue', s:palette.blue, s:palette.none, 'bold')
call gruvbox_material#highlight('DapUIBreakpointsCurrentLine', s:palette.blue, s:palette.none, 'bold')
highlight! link DapUIScope Blue
highlight! link DapUIType Purple
highlight! link DapUIDecoration Blue
highlight! link DapUIThread Green
highlight! link DapUIStoppedThread Blue
highlight! link DapUISource Purple
highlight! link DapUILineNumber Blue
highlight! link DapUIFloatBorder Blue
highlight! link DapUIWatchesEmpty Red
highlight! link DapUIWatchesValue Green
highlight! link DapUIWatchesError Red
highlight! link DapUIBreakpointsPath Blue
highlight! link DapUIBreakpointsInfo Green
" }}}
endif
" }}}
" Extended File Types: {{{
" Whitelist: {{{ File type optimizations that will always be loaded.
" diff {{{
highlight! link diffAdded Green
highlight! link diffRemoved Red
highlight! link diffChanged Blue
highlight! link diffOldFile Yellow
highlight! link diffNewFile Orange
highlight! link diffFile Aqua
highlight! link diffLine Grey
highlight! link diffIndexLine Purple
" }}}
" }}}
" Generate the `after/syntax` directory based on the comment tags in this file.
" For example, the content between `syn_begin: sh/zsh` and `syn_end` will be placed in `after/syntax/sh/gruvbox_material.vim` and `after/syntax/zsh/gruvbox_material.vim`.
if gruvbox_material#syn_exists(s:path) " If the syntax files exist.
  if s:configuration.better_performance
    if !gruvbox_material#syn_newest(s:path, s:last_modified) " Regenerate if it's not up to date.
      call gruvbox_material#syn_clean(s:path, 0)
      call gruvbox_material#syn_gen(s:path, s:last_modified, 'update')
    endif
    finish
  else
    call gruvbox_material#syn_clean(s:path, 1)
  endif
else
  if s:configuration.better_performance
    call gruvbox_material#syn_gen(s:path, s:last_modified, 'generate')
    finish
  endif
endif
" syn_begin: packer {{{
" https://github.com/wbthomason/packer.nvim
highlight! link packerSuccess Aqua
highlight! link packerFail Red
highlight! link packerStatusSuccess Fg
highlight! link packerStatusFail Fg
highlight! link packerWorking Yellow
highlight! link packerString Yellow
highlight! link packerPackageNotLoaded Grey
highlight! link packerRelDate Grey
highlight! link packerPackageName Green
highlight! link packerOutput Orange
highlight! link packerHash Green
highlight! link packerTimeTrivial Blue
highlight! link packerTimeHigh Red
highlight! link packerTimeMedium Yellow
highlight! link packerTimeLow Green
" syn_end }}}
" syn_begin: netrw {{{
" https://www.vim.org/scripts/script.php?script_id=1075
highlight! link netrwDir Green
highlight! link netrwClassify Green
highlight! link netrwLink Grey
highlight! link netrwSymLink Fg
highlight! link netrwExe Yellow
highlight! link netrwComment Grey
highlight! link netrwList Aqua
highlight! link netrwHelpCmd Blue
highlight! link netrwCmdSep Grey
highlight! link netrwVersion Orange
" syn_end }}}
" syn_begin: undotree {{{
" https://github.com/mbbill/undotree
call gruvbox_material#highlight('UndotreeSavedBig', s:palette.purple, s:palette.none, 'bold')
highlight! link UndotreeNode Orange
highlight! link UndotreeNodeCurrent Red
highlight! link UndotreeSeq Green
highlight! link UndotreeNext Blue
highlight! link UndotreeTimeStamp Grey
highlight! link UndotreeHead Yellow
highlight! link UndotreeBranch Yellow
highlight! link UndotreeCurrent Aqua
highlight! link UndotreeSavedSmall Purple
" syn_end }}}
" syn_begin: vimwiki {{{
call gruvbox_material#highlight('VimwikiHeader1', s:palette.red, s:palette.none, 'bold')
call gruvbox_material#highlight('VimwikiHeader2', s:palette.orange, s:palette.none, 'bold')
call gruvbox_material#highlight('VimwikiHeader3', s:palette.yellow, s:palette.none, 'bold')
call gruvbox_material#highlight('VimwikiHeader4', s:palette.green, s:palette.none, 'bold')
call gruvbox_material#highlight('VimwikiHeader5', s:palette.blue, s:palette.none, 'bold')
call gruvbox_material#highlight('VimwikiHeader6', s:palette.purple, s:palette.none, 'bold')
call gruvbox_material#highlight('VimwikiLink', s:palette.blue, s:palette.none, 'underline')
call gruvbox_material#highlight('VimwikiItalic', s:palette.none, s:palette.none, 'italic')
call gruvbox_material#highlight('VimwikiBold', s:palette.none, s:palette.none, 'bold')
call gruvbox_material#highlight('VimwikiUnderline', s:palette.none, s:palette.none, 'underline')
highlight! link VimwikiList Red
highlight! link VimwikiTag Aqua
highlight! link VimwikiCode Green
highlight! link VimwikiHR Yellow
highlight! link VimwikiHeaderChar Grey
highlight! link VimwikiMarkers Grey
highlight! link VimwikiPre Green
highlight! link VimwikiPreDelim Green
highlight! link VimwikiNoExistsLink Red
" syn_end }}}
" syn_begin: tex {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_TEX {{{
highlight! link texStatement Green
highlight! link texOnlyMath Grey
highlight! link texDefName Yellow
highlight! link texNewCmd Orange
highlight! link texCmdName Blue
highlight! link texBeginEnd Red
highlight! link texBeginEndName Blue
highlight! link texDocType Purple
highlight! link texDocTypeArgs Orange
" }}}
" vimtex: https://github.com/lervag/vimtex {{{
highlight! link texCmd Green
highlight! link texCmdClass Purple
highlight! link texCmdTitle Purple
highlight! link texCmdAuthor Purple
highlight! link texCmdPart Purple
highlight! link texCmdBib Purple
highlight! link texCmdPackage Yellow
highlight! link texCmdNew Yellow
highlight! link texArgNew Orange
highlight! link texPartArgTitle BlueItalic
highlight! link texFileArg BlueItalic
highlight! link texEnvArgName BlueItalic
highlight! link texMathEnvArgName BlueItalic
highlight! link texTitleArg BlueItalic
highlight! link texAuthorArg BlueItalic
" }}}
" syn_end }}}
" syn_begin: html/markdown/javascriptreact/typescriptreact {{{
" builtin: https://notabug.org/jorgesumle/vim-html-syntax {{{
call gruvbox_material#highlight('htmlH1', s:palette.red, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH2', s:palette.orange, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH3', s:palette.yellow, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH4', s:palette.green, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH5', s:palette.blue, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH6', s:palette.purple, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlLink', s:palette.none, s:palette.none, 'underline')
call gruvbox_material#highlight('htmlBold', s:palette.none, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlBoldUnderline', s:palette.none, s:palette.none, 'bold,underline')
call gruvbox_material#highlight('htmlBoldItalic', s:palette.none, s:palette.none, 'bold,italic')
call gruvbox_material#highlight('htmlBoldUnderlineItalic', s:palette.none, s:palette.none, 'bold,underline,italic')
call gruvbox_material#highlight('htmlUnderline', s:palette.none, s:palette.none, 'underline')
call gruvbox_material#highlight('htmlUnderlineItalic', s:palette.none, s:palette.none, 'underline,italic')
call gruvbox_material#highlight('htmlItalic', s:palette.none, s:palette.none, 'italic')
highlight! link htmlTag Green
highlight! link htmlEndTag Blue
highlight! link htmlTagN OrangeItalic
highlight! link htmlTagName OrangeItalic
highlight! link htmlArg Aqua
highlight! link htmlScriptTag Purple
highlight! link htmlSpecialTagName RedItalic
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link htmlTSText TSNone
if has('nvim-0.8.0')
  highlight! link @text.html htmlTSText
endif
" }}}
" syn_end }}}
" syn_begin: xml {{{
" builtin: https://github.com/chrisbra/vim-xml-ftplugin {{{
highlight! link xmlTag Green
highlight! link xmlEndTag Blue
highlight! link xmlTagName OrangeItalic
highlight! link xmlEqual Orange
highlight! link xmlAttrib Aqua
highlight! link xmlEntity Red
highlight! link xmlEntityPunct Red
highlight! link xmlDocTypeDecl Grey
highlight! link xmlDocTypeKeyword PurpleItalic
highlight! link xmlCdataStart Grey
highlight! link xmlCdataCdata Purple
" }}}
" syn_end }}}
" syn_begin: less {{{
" vim-less: https://github.com/groenewege/vim-less {{{
highlight! link lessMixinChar Grey
highlight! link lessClass RedItalic
highlight! link lessVariable Blue
highlight! link lessAmpersandChar Orange
highlight! link lessFunction Yellow
" }}}
" syn_end }}}
" syn_begin: c/cpp/objc/objcpp {{{
" vim-cpp-enhanced-highlight: https://github.com/octol/vim-cpp-enhanced-highlight {{{
highlight! link cppSTLnamespace Purple
highlight! link cppSTLtype Yellow
highlight! link cppAccess PurpleItalic
highlight! link cppStructure RedItalic
highlight! link cppSTLios Aqua
highlight! link cppSTLiterator PurpleItalic
highlight! link cppSTLexception Purple
" }}}
" vim-cpp-modern: https://github.com/bfrg/vim-cpp-modern {{{
highlight! link cppSTLVariable Aqua
" }}}
" chromatica: https://github.com/arakashic/chromatica.nvim {{{
highlight! link Member TSVariable
highlight! link Variable TSVariable
highlight! link Namespace TSNamespace
highlight! link EnumConstant TSNumber
highlight! link chromaticaException TSException
highlight! link chromaticaCast TSLabel
highlight! link OperatorOverload TSOperator
highlight! link AccessQual TSOperator
highlight! link Linkage TSOperator
highlight! link AutoType TSType
" }}}
" vim-lsp-cxx-highlight https://github.com/jackguo380/vim-lsp-cxx-highlight {{{
highlight! link LspCxxHlSkippedRegion Grey
highlight! link LspCxxHlSkippedRegionBeginEnd TSKeyword
highlight! link LspCxxHlGroupEnumConstant BlueItalic
highlight! link LspCxxHlGroupNamespace TSNamespace
highlight! link LspCxxHlGroupMemberVariable TSVariable
" }}}
" syn_end }}}
" syn_begin: cs {{{
" builtin: https://github.com/nickspoons/vim-cs {{{
highlight! link csUnspecifiedStatement PurpleItalic
highlight! link csStorage RedItalic
highlight! link csClass RedItalic
highlight! link csNewType Aqua
highlight! link csContextualStatement PurpleItalic
highlight! link csInterpolationDelimiter Yellow
highlight! link csInterpolation Yellow
highlight! link csEndColon Fg
" }}}
" syn_end }}}
" syn_begin: python {{{
" builtin: {{{
highlight! link pythonBuiltin Yellow
highlight! link pythonExceptions Purple
highlight! link pythonDecoratorName Blue
" }}}
" python-syntax: https://github.com/vim-python/python-syntax {{{
highlight! link pythonExClass Purple
highlight! link pythonBuiltinType Yellow
highlight! link pythonBuiltinObj Blue
highlight! link pythonDottedName PurpleItalic
highlight! link pythonBuiltinFunc GreenBold
highlight! link pythonFunction AquaBold
highlight! link pythonDecorator Orange
highlight! link pythonInclude Include
highlight! link pythonImport PreProc
highlight! link pythonRun Blue
highlight! link pythonCoding Grey
highlight! link pythonOperator Orange
highlight! link pythonConditional RedItalic
highlight! link pythonRepeat RedItalic
highlight! link pythonException RedItalic
highlight! link pythonNone Aqua
highlight! link pythonDot Grey
" }}}
" semshi: https://github.com/numirias/semshi {{{
call gruvbox_material#highlight('semshiUnresolved', s:palette.yellow, s:palette.none, 'undercurl')
highlight! link semshiImported TSInclude
highlight! link semshiParameter TSParameter
highlight! link semshiParameterUnused Grey
highlight! link semshiSelf TSVariableBuiltin
highlight! link semshiGlobal TSType
highlight! link semshiBuiltin TSTypeBuiltin
highlight! link semshiAttribute TSAttribute
highlight! link semshiLocal TSKeyword
highlight! link semshiFree TSKeyword
highlight! link semshiSelected CurrentWord
highlight! link semshiErrorSign RedSign
highlight! link semshiErrorChar RedSign
" }}}
" syn_end }}}
" syn_begin: lua {{{
" builtin: {{{
highlight! link luaFunc GreenBold
highlight! link luaFunction Aqua
highlight! link luaTable Fg
highlight! link luaIn RedItalic
" }}}
" vim-lua: https://github.com/tbastos/vim-lua {{{
highlight! link luaFuncCall GreenBold
highlight! link luaLocal Orange
highlight! link luaSpecialValue GreenBold
highlight! link luaBraces Fg
highlight! link luaBuiltIn Purple
highlight! link luaNoise Grey
highlight! link luaLabel Purple
highlight! link luaFuncTable Yellow
highlight! link luaFuncArgName Blue
highlight! link luaEllipsis Orange
highlight! link luaDocTag Green
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link luaTSConstructor luaBraces
if has('nvim-0.8.0')
  highlight! link @constructor.lua luaTSConstructor
endif
" }}}
" syn_end }}}
" syn_begin: java {{{
" builtin: {{{
highlight! link javaClassDecl RedItalic
highlight! link javaMethodDecl RedItalic
highlight! link javaVarArg Green
highlight! link javaAnnotation Blue
highlight! link javaUserLabel Purple
highlight! link javaTypedef Aqua
highlight! link javaParen Fg
highlight! link javaParen1 Fg
highlight! link javaParen2 Fg
highlight! link javaParen3 Fg
highlight! link javaParen4 Fg
highlight! link javaParen5 Fg
" }}}
" syn_end }}}
" syn_begin: kotlin {{{
" kotlin-vim: https://github.com/udalov/kotlin-vim {{{
highlight! link ktSimpleInterpolation Yellow
highlight! link ktComplexInterpolation Yellow
highlight! link ktComplexInterpolationBrace Yellow
highlight! link ktStructure RedItalic
highlight! link ktKeyword Aqua
" }}}
" syn_end }}}
" syn_begin: scala {{{
" builtin: https://github.com/derekwyatt/vim-scala {{{
highlight! link scalaNameDefinition Aqua
highlight! link scalaInterpolationBoundary Yellow
highlight! link scalaInterpolation Blue
highlight! link scalaTypeOperator Orange
highlight! link scalaOperator Orange
highlight! link scalaKeywordModifier Orange
" }}}
" syn_end }}}
" syn_begin: go {{{
" builtin: https://github.com/fatih/vim-go {{{
highlight! link goPackage Define
highlight! link goImport Include
highlight! link goVar OrangeItalic
highlight! link goConst goVar
highlight! link goType Yellow
highlight! link goSignedInts goType
highlight! link goUnsignedInts goType
highlight! link goFloats goType
highlight! link goComplexes goType
highlight! link goVarDefs Aqua
highlight! link goDeclType OrangeItalic
highlight! link goFunctionCall Function
highlight! link goPredefinedIdentifiers Aqua
highlight! link goBuiltins GreenBold
highlight! link goVarArgs Grey
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link goTSInclude Purple
highlight! link goTSNamespace Fg
highlight! link goTSConstBuiltin AquaItalic
if has('nvim-0.8.0')
  highlight! link @include.go goTSInclude
  highlight! link @namespace.go goTSNamespace
  highlight! link @constant.builtin.go goTSConstBuiltin
endif
if has('nvim-0.9.0')
  highlight! link @lsp.typemod.variable.defaultLibrary.go goTSConstBuiltin
  highlight! link @lsp.type.namespace.go goTSNamespace
endif
" }}}
" syn_end }}}
" syn_begin: rust {{{
" builtin: https://github.com/rust-lang/rust.vim {{{
highlight! link rustStructure Orange
highlight! link rustIdentifier Purple
highlight! link rustModPath Orange
highlight! link rustModPathSep Grey
highlight! link rustSelf Blue
highlight! link rustSuper Blue
highlight! link rustDeriveTrait PurpleItalic
highlight! link rustEnumVariant Purple
highlight! link rustMacroVariable Blue
highlight! link rustAssert Aqua
highlight! link rustPanic Aqua
highlight! link rustPubScopeCrate PurpleItalic
" }}}
" coc-rust-analyzer: https://github.com/fannheyward/coc-rust-analyzer {{{
highlight! link CocRustChainingHint Grey
highlight! link CocRustTypeHint Grey
" }}}
" syn_end }}}
" syn_begin: swift {{{
" swift.vim: https://github.com/keith/swift.vim {{{
highlight! link swiftInterpolatedWrapper Yellow
highlight! link swiftInterpolatedString Blue
highlight! link swiftProperty Aqua
highlight! link swiftTypeDeclaration Orange
highlight! link swiftClosureArgument Purple
" }}}
" syn_end }}}
" syn_begin: matlab {{{
" builtin: {{{
highlight! link matlabSemicolon Fg
highlight! link matlabFunction RedItalic
highlight! link matlabImplicit GreenBold
highlight! link matlabDelimiter Fg
highlight! link matlabOperator GreenBold
highlight! link matlabArithmeticOperator Orange
highlight! link matlabArithmeticOperator Orange
highlight! link matlabRelationalOperator Orange
highlight! link matlabRelationalOperator Orange
highlight! link matlabLogicalOperator Orange
" }}}
" syn_end }}}
" syn_begin: octave {{{
" vim-octave: https://github.com/McSinyx/vim-octave{{{
highlight! link octaveDelimiter Fg
highlight! link octaveSemicolon Grey
highlight! link octaveOperator Orange
highlight! link octaveVariable YellowItalic
highlight! link octaveVarKeyword YellowItalic
" }}}
" syn_end }}}
" syn_begin: sh/zsh {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_SH {{{
highlight! link shRange Fg
highlight! link shTestOpr Orange
highlight! link shOption Aqua
highlight! link bashStatement Orange
highlight! link shOperator Orange
highlight! link shQuote Green
highlight! link shSet Orange
highlight! link shSetList Blue
highlight! link shSnglCase Orange
highlight! link shVariable Blue
highlight! link shVarAssign Orange
highlight! link shCmdSubRegion Green
highlight! link shCommandSub Orange
highlight! link shFunctionOne GreenBold
highlight! link shFunctionKey RedItalic
" }}}
" syn_end }}}
" syn_begin: zsh {{{
" builtin: https://github.com/chrisbra/vim-zsh {{{
highlight! link zshOptStart PurpleItalic
highlight! link zshOption Blue
highlight! link zshSubst Yellow
highlight! link zshFunction GreenBold
highlight! link zshDeref Blue
highlight! link zshTypes Orange
highlight! link zshVariableDef Blue
" }}}
" syn_end }}}
" syn_begin: ps1 {{{
" vim-ps1: https://github.com/PProvost/vim-ps1 {{{
highlight! link ps1FunctionInvocation AquaBold
highlight! link ps1FunctionDeclaration AquaBold
highlight! link ps1InterpolationDelimiter Yellow
highlight! link ps1BuiltIn Yellow
" }}}
" syn_end }}}
" syn_begin: vim {{{
call gruvbox_material#highlight('vimCommentTitle', s:palette.grey1, s:palette.none, 'bold')
highlight! link vimLet Orange
highlight! link vimFunction GreenBold
highlight! link vimIsCommand Fg
highlight! link vimUserFunc GreenBold
highlight! link vimFuncName GreenBold
highlight! link vimMap PurpleItalic
highlight! link vimNotation Aqua
highlight! link vimMapLhs Green
highlight! link vimMapRhs Green
highlight! link vimSetEqual Yellow
highlight! link vimSetSep Fg
highlight! link vimOption Aqua
highlight! link vimUserAttrbKey Yellow
highlight! link vimUserAttrb Green
highlight! link vimAutoCmdSfxList Aqua
highlight! link vimSynType Orange
highlight! link vimHiBang Orange
highlight! link vimSet Yellow
highlight! link vimSetSep Grey
highlight! link vimContinue Grey
" syn_end }}}
" syn_begin: make {{{
highlight! link makeIdent Aqua
highlight! link makeSpecTarget Yellow
highlight! link makeTarget Blue
highlight! link makeCommands Orange
" syn_end }}}
" syn_begin: cmake {{{
highlight! link cmakeCommand Orange
highlight! link cmakeKWconfigure_package_config_file Yellow
highlight! link cmakeKWwrite_basic_package_version_file Yellow
highlight! link cmakeKWExternalProject Aqua
highlight! link cmakeKWadd_compile_definitions Aqua
highlight! link cmakeKWadd_compile_options Aqua
highlight! link cmakeKWadd_custom_command Aqua
highlight! link cmakeKWadd_custom_target Aqua
highlight! link cmakeKWadd_definitions Aqua
highlight! link cmakeKWadd_dependencies Aqua
highlight! link cmakeKWadd_executable Aqua
highlight! link cmakeKWadd_library Aqua
highlight! link cmakeKWadd_link_options Aqua
highlight! link cmakeKWadd_subdirectory Aqua
highlight! link cmakeKWadd_test Aqua
highlight! link cmakeKWbuild_command Aqua
highlight! link cmakeKWcmake_host_system_information Aqua
highlight! link cmakeKWcmake_minimum_required Aqua
highlight! link cmakeKWcmake_parse_arguments Aqua
highlight! link cmakeKWcmake_policy Aqua
highlight! link cmakeKWconfigure_file Aqua
highlight! link cmakeKWcreate_test_sourcelist Aqua
highlight! link cmakeKWctest_build Aqua
highlight! link cmakeKWctest_configure Aqua
highlight! link cmakeKWctest_coverage Aqua
highlight! link cmakeKWctest_memcheck Aqua
highlight! link cmakeKWctest_run_script Aqua
highlight! link cmakeKWctest_start Aqua
highlight! link cmakeKWctest_submit Aqua
highlight! link cmakeKWctest_test Aqua
highlight! link cmakeKWctest_update Aqua
highlight! link cmakeKWctest_upload Aqua
highlight! link cmakeKWdefine_property Aqua
highlight! link cmakeKWdoxygen_add_docs Aqua
highlight! link cmakeKWenable_language Aqua
highlight! link cmakeKWenable_testing Aqua
highlight! link cmakeKWexec_program Aqua
highlight! link cmakeKWexecute_process Aqua
highlight! link cmakeKWexport Aqua
highlight! link cmakeKWexport_library_dependencies Aqua
highlight! link cmakeKWfile Aqua
highlight! link cmakeKWfind_file Aqua
highlight! link cmakeKWfind_library Aqua
highlight! link cmakeKWfind_package Aqua
highlight! link cmakeKWfind_path Aqua
highlight! link cmakeKWfind_program Aqua
highlight! link cmakeKWfltk_wrap_ui Aqua
highlight! link cmakeKWforeach Aqua
highlight! link cmakeKWfunction Aqua
highlight! link cmakeKWget_cmake_property Aqua
highlight! link cmakeKWget_directory_property Aqua
highlight! link cmakeKWget_filename_component Aqua
highlight! link cmakeKWget_property Aqua
highlight! link cmakeKWget_source_file_property Aqua
highlight! link cmakeKWget_target_property Aqua
highlight! link cmakeKWget_test_property Aqua
highlight! link cmakeKWif Aqua
highlight! link cmakeKWinclude Aqua
highlight! link cmakeKWinclude_directories Aqua
highlight! link cmakeKWinclude_external_msproject Aqua
highlight! link cmakeKWinclude_guard Aqua
highlight! link cmakeKWinstall Aqua
highlight! link cmakeKWinstall_files Aqua
highlight! link cmakeKWinstall_programs Aqua
highlight! link cmakeKWinstall_targets Aqua
highlight! link cmakeKWlink_directories Aqua
highlight! link cmakeKWlist Aqua
highlight! link cmakeKWload_cache Aqua
highlight! link cmakeKWload_command Aqua
highlight! link cmakeKWmacro Aqua
highlight! link cmakeKWmark_as_advanced Aqua
highlight! link cmakeKWmath Aqua
highlight! link cmakeKWmessage Aqua
highlight! link cmakeKWoption Aqua
highlight! link cmakeKWproject Aqua
highlight! link cmakeKWqt_wrap_cpp Aqua
highlight! link cmakeKWqt_wrap_ui Aqua
highlight! link cmakeKWremove Aqua
highlight! link cmakeKWseparate_arguments Aqua
highlight! link cmakeKWset Aqua
highlight! link cmakeKWset_directory_properties Aqua
highlight! link cmakeKWset_property Aqua
highlight! link cmakeKWset_source_files_properties Aqua
highlight! link cmakeKWset_target_properties Aqua
highlight! link cmakeKWset_tests_properties Aqua
highlight! link cmakeKWsource_group Aqua
highlight! link cmakeKWstring Aqua
highlight! link cmakeKWsubdirs Aqua
highlight! link cmakeKWtarget_compile_definitions Aqua
highlight! link cmakeKWtarget_compile_features Aqua
highlight! link cmakeKWtarget_compile_options Aqua
highlight! link cmakeKWtarget_include_directories Aqua
highlight! link cmakeKWtarget_link_directories Aqua
highlight! link cmakeKWtarget_link_libraries Aqua
highlight! link cmakeKWtarget_link_options Aqua
highlight! link cmakeKWtarget_precompile_headers Aqua
highlight! link cmakeKWtarget_sources Aqua
highlight! link cmakeKWtry_compile Aqua
highlight! link cmakeKWtry_run Aqua
highlight! link cmakeKWunset Aqua
highlight! link cmakeKWuse_mangled_mesa Aqua
highlight! link cmakeKWvariable_requires Aqua
highlight! link cmakeKWvariable_watch Aqua
highlight! link cmakeKWwrite_file Aqua
" syn_end }}}
" syn_begin: json {{{
highlight! link jsonKeyword Orange
highlight! link jsonQuote Grey
highlight! link jsonBraces Fg
" syn_end }}}
" syn_begin: yaml {{{
highlight! link yamlKey Orange
highlight! link yamlConstant Purple
" syn_end }}}
" syn_begin: toml {{{
call gruvbox_material#highlight('tomlTable', s:palette.purple, s:palette.none, 'bold')
highlight! link tomlKey Orange
highlight! link tomlBoolean Aqua
highlight! link tomlTableArray tomlTable
" syn_end }}}
" syn_begin: gitcommit {{{
" builtin {{{
highlight! link gitcommitSummary Red
highlight! link gitcommitUntracked Grey
highlight! link gitcommitDiscarded Grey
highlight! link gitcommitSelected Grey
highlight! link gitcommitUnmerged Grey
highlight! link gitcommitOnBranch Grey
highlight! link gitcommitArrow Grey
highlight! link gitcommitFile Green
" }}}
" nvim-treesitter/nvim-treesitter {{{
if has('nvim-0.8.0')
  highlight! link @text.gitcommit TSNone
endif
" }}}
" syn_end }}}
" syn_begin: help {{{
call gruvbox_material#highlight('helpNote', s:palette.purple, s:palette.none, 'bold')
call gruvbox_material#highlight('helpHeadline', s:palette.red, s:palette.none, 'bold')
call gruvbox_material#highlight('helpHeader', s:palette.orange, s:palette.none, 'bold')
call gruvbox_material#highlight('helpURL', s:palette.green, s:palette.none, 'underline')
call gruvbox_material#highlight('helpHyperTextEntry', s:palette.yellow, s:palette.none, 'bold')
highlight! link helpHyperTextJump Yellow
highlight! link helpCommand Aqua
highlight! link helpExample Green
highlight! link helpSpecial Blue
highlight! link helpSectionDelim Grey
" syn_end }}}
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
