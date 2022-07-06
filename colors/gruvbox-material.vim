" -----------------------------------------------------------------------------
" Name:           Gruvbox Material
" Description:    Gruvbox with Material Palette
" Author:         sainnhe <sainnhe@gmail.com>
" Website:        https://github.com/sainnhe/gruvbox-material
" License:        MIT
" -----------------------------------------------------------------------------

" Initialization: {{{
let s:configuration = gruvbox_material#get_configuration()
let s:palette = gruvbox_material#get_palette(s:configuration.background, s:configuration.foreground, s:configuration.colors_override)
let s:path = expand('<sfile>:p') " the path of this script
let s:last_modified = 'Sun Jul  3 03:04:21 UTC 2022'
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
if s:configuration.transparent_background == 1
  call gruvbox_material#highlight('Normal', s:palette.fg0, s:palette.none)
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
  call gruvbox_material#highlight('Terminal', s:palette.fg0, s:palette.bg0)
  if s:configuration.show_eob
    call gruvbox_material#highlight('EndOfBuffer', s:palette.bg5, s:palette.bg0)
  else
    call gruvbox_material#highlight('EndOfBuffer', s:palette.bg0, s:palette.bg0)
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
call gruvbox_material#highlight('VertSplit', s:palette.bg5, s:palette.none)
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
  highlight! link DiagnosticSignHint AquaSign
  highlight! link LspDiagnosticsFloatingError ErrorFloat
  highlight! link LspDiagnosticsFloatingWarning WarningFloat
  highlight! link LspDiagnosticsFloatingInformation InfoFloat
  highlight! link LspDiagnosticsFloatingHint HintFloat
  highlight! link LspDiagnosticsDefaultError ErrorText
  highlight! link LspDiagnosticsDefaultWarning WarningText
  highlight! link LspDiagnosticsDefaultInformation InfoText
  highlight! link LspDiagnosticsDefaultHint HintText
  highlight! link LspDiagnosticsVirtualTextError VirtualTextError
  highlight! link LspDiagnosticsVirtualTextWarning VirtualTextWarning
  highlight! link LspDiagnosticsVirtualTextInformation VirtualTextInfo
  highlight! link LspDiagnosticsVirtualTextHint VirtualTextHint
  highlight! link LspDiagnosticsUnderlineError ErrorText
  highlight! link LspDiagnosticsUnderlineWarning WarningText
  highlight! link LspDiagnosticsUnderlineInformation InfoText
  highlight! link LspDiagnosticsUnderlineHint HintText
  highlight! link LspDiagnosticsSignError RedSign
  highlight! link LspDiagnosticsSignWarning YellowSign
  highlight! link LspDiagnosticsSignInformation BlueSign
  highlight! link LspDiagnosticsSignHint AquaSign
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
if s:configuration.disable_italic_comment
  call gruvbox_material#highlight('Comment', s:palette.grey1, s:palette.none)
  call gruvbox_material#highlight('SpecialComment', s:palette.grey1, s:palette.none)
  call gruvbox_material#highlight('Todo', s:palette.purple, s:palette.none)
else
  call gruvbox_material#highlight('Comment', s:palette.grey1, s:palette.none, 'italic')
  call gruvbox_material#highlight('SpecialComment', s:palette.grey1, s:palette.none, 'italic')
  call gruvbox_material#highlight('Todo', s:palette.purple, s:palette.none, 'italic')
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
else
  highlight! link VirtualTextWarning Yellow
  highlight! link VirtualTextError Red
  highlight! link VirtualTextInfo Blue
  highlight! link VirtualTextHint Green
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
" neoclide/coc.nvim {{{
call gruvbox_material#highlight('CocHoverRange', s:palette.none, s:palette.none, 'bold,underline')
call gruvbox_material#highlight('CocSearch', s:palette.green, s:palette.none, 'bold')
highlight! link CocDisabled Grey
highlight! link CocSnippetVisual DiffAdd
highlight! link CocInlayHint Grey
highlight! link CocNotificationProgress Green
highlight! link CocNotificationButton PmenuSel
highlight! link CocSemClass TSType
highlight! link CocSemEnum TSType
highlight! link CocSemInterface TSType
highlight! link CocSemStruct TSType
highlight! link CocSemTypeParameter TSType
highlight! link CocSemVariable TSVariable
highlight! link CocSemEnumMember TSVariableBuiltin
highlight! link CocSemEvent TSLabel
highlight! link CocSemModifier TSOperator
highlight! link CocErrorFloat ErrorFloat
highlight! link CocWarningFloat WarningFloat
highlight! link CocInfoFloat InfoFloat
highlight! link CocHintFloat HintFloat
highlight! link CocErrorHighlight ErrorText
highlight! link CocWarningHighlight WarningText
highlight! link CocInfoHighlight InfoText
highlight! link CocHintHighlight HintText
highlight! link CocHighlightText CurrentWord
highlight! link CocHoverRange CurrentWord
highlight! link CocErrorSign RedSign
highlight! link CocWarningSign YellowSign
highlight! link CocInfoSign BlueSign
highlight! link CocHintSign AquaSign
highlight! link CocWarningVirtualText VirtualTextWarning
highlight! link CocErrorVirtualText VirtualTextError
highlight! link CocInfoVirtualText VirtualTextInfo
highlight! link CocHintVirtualText VirtualTextHint
highlight! link CocErrorLine ErrorLine
highlight! link CocWarningLine WarningLine
highlight! link CocInfoLine InfoLine
highlight! link CocHintLine HintLine
highlight! link CocCodeLens Grey
highlight! link CocFadeOut Grey
highlight! link CocStrikeThrough Grey
highlight! link CocListMode StatusLine
highlight! link CocListPath StatusLine
highlight! link CocSelectedText Orange
highlight! link CocListsLine Fg
highlight! link CocListsDesc Grey
highlight! link HighlightedyankRegion Visual
highlight! link CocGitAddedSign GreenSign
highlight! link CocGitChangeRemovedSign PurpleSign
highlight! link CocGitChangedSign BlueSign
highlight! link CocGitRemovedSign RedSign
highlight! link CocGitTopRemovedSign RedSign
" }}}
" junegunn/fzf.vim {{{
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Green'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Aqua'],
      \ 'info':    ['fg', 'Aqua'],
      \ 'border':  ['fg', 'Grey'],
      \ 'prompt':  ['fg', 'Orange'],
      \ 'pointer': ['fg', 'Blue'],
      \ 'marker':  ['fg', 'Yellow'],
      \ 'spinner': ['fg', 'Yellow'],
      \ 'header':  ['fg', 'Grey']
      \ }
" }}}
" }}}
" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
