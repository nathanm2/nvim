" GuiFont DejaVuSansM Nerd Font Mono:h11
GuiFont! UbuntuMono Nerd Font Mono:h12
" GuiFont! Monospace:h11

" GuiAdaptiveStyle Fusion
" GuiAdaptiveFont 1
GuiTabline 0
GuiPopupmenu 0
GuiScrollBar 1

set lines=45
set columns=100

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
