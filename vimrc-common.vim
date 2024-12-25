" Common Global Configs ===============================================
"
" Common vim options used in both vim AND neovim.
"

" Debug Tips ==========================================================
"
" Which script changed an option setting:
"   :verbose set textwidth?


" Leader Key  =======================================================
"
" See `:help mapleader`
"  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
"
" Using a "leader" key ensures your custom key mappings won't collide with some existing mappings.
" The "local leader" key is meant for mappings that only take effect for certain types of files.
"
" See: https://learnvimscriptthehardway.stevelosh.com/chapters/06.html
"
" To use the SPACEBAR as the leader key you need to first remove the existing
" mapping for SPACE which defaults to moving forward a single key.
nnoremap <SPACE> <Nop>
let mapleader = " "
let maplocalleader = "\\"

" Common Editor Behavior ==============================================

" Highlight all search matches
set hlsearch

" Perform incremental searching as the search text is entered:
set incsearch

" Previously, I used the following mappings to copy, cut, and paste
" to the CLIPBOARD buffer (+):
"
" noremap <F1> "+y
" noremap <F2> "+d
" noremap <F3> "+p
"
" However, there appears to be a much better way: simply adding 'unnamedplus'
" to the clipboard setting causes vim to use the CLIPBOARD buffer instead of
" the UNNAMED buffer!
set clipboard=unnamedplus

" <Tab> behavior in normal mode:
"   Part 1: longest:full => Complete till longest common string and show menu.
"   Part 2: full => Cycle through menu fields.
"
" Note: wildmode=longest,list follows bash shell conventions.
"
set wildmode=longest:full,full

" Enable mouse support in the terminal:
"   a=all, n=normal, v=visual, i=insert
set mouse=a

" Ignore case when searching:
set ignorecase

" Enable "smart case", so that Vim intelligently respects case when an upper
" case character appears in the search.
set smartcase

" Set the terminal window title
set title

" Highlight the textwidth+1 column:
set colorcolumn=+1

" Open vertical splits on the right:
set splitright

" Open horizontal splits below:
" set splitbelow

" Automatically resize a window if textwidth is non-zero.
"
" The window width is calculated to be:
"    textwidth + line-number (prefix) + colorcolumn (suffix)
"
function! s:AutoResizeWindow()
    if &textwidth != 0
        let &l:winwidth=&textwidth + getwininfo(win_getid())[0].textoff + 1
    endif
endfunction

" It's considered good practice to put all auto commands into a group.
"
" In case this file is sourced more than once, we can use 'autocmd!' to remove
" the group's autocommands before adding them again.  This prevents the same
" autocommand from being run more than once.
augroup window_auto
    autocmd!
    autocmd WinEnter * :call s:AutoResizeWindow()
augroup END

" Common Key Maps ===============================================

" Easier quit:
nnoremap  <leader>qq <cmd>qa<cr>

" Easier window movement mappings:
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Better movement
"
" gj/gk move to the next display line, which when wrapping is enabled, may not
" correpond to the line number.
nnoremap <silent><expr> j v:count == 0 ? "gj" : "j"
nnoremap <silent><expr> k v:count == 0 ? "gk" : "k"

" Toggle between absolute/relative/none line numbering
nnoremap <silent> <leader>ul :call ToggleLineNumberType()<cr>

function! ToggleLineNumberType()
    if !&relativenumber && !&number
        setlocal number
    elseif !&relativenumber
        setlocal relativenumber
    else
        setlocal nonumber norelativenumber
    endif
endfunction

" Toggle trailing whitespace highlighting
highlight TrailingSpaces ctermbg=red guibg=red
match TrailingSpaces /\s\+$/
let s:activeh = 1
function! ToggleTrailingSpaceHighlight()
    if s:activeh == 0
        let s:activeh = 1
        match TrailingSpaces /\s\+$/
    else
        let s:activeh = 0
        match none
    endif
endfunction

nnoremap <silent> <leader>uw :call ToggleTrailingSpaceHighlight()<cr>

" Function to clear redundant (trailing) whitespace
function! TrimTrailingWhitespace()
  let l:view = winsaveview()
  keeppatterns %substitute/\m\s\+$//e
  call winrestview(l:view)
endfunction

nnoremap <silent> <leader>fw :call TrimTrailingWhitespace()<cr>

" Resize with arrows
"
" NOTE: This feels natural for the top-left window, but a bit surprising when
" dealing with windows on the bottom or the right.
nnoremap <c-up> :resize -2<CR>
nnoremap <c-down> :resize +2<CR>
nnoremap <c-left> :vertical resize -2<CR>
nnoremap <c-right> :vertical resize +2<CR>

" Easily clear the last search result by pressing escape.
"
" NOTE: This mapping caused vim 8.2 to run `[I` everytime the terminal regained
" focus.  It could be related to this bug:
"
"   https://github.com/vim/vim/commit/85ef2df075a189da8b767d7554caaed8077de868
"
"nnoremap <esc><esc> <cmd>noh<cr><esc>
"inoremap <esc><esc> <cmd>noh<cr><esc>
nnoremap <leader>h <cmd>noh<cr>

" Easily toggle the NetRW window
nnoremap <leader>e :Lex 30<cr>

" Navigate between buffers:
nnoremap [b <cmd>exe v:count .. "bprevious"<cr>
nnoremap <S-tab> <cmd>bprevious<cr>
nnoremap ]b <cmd>exe v:count .. "bnext"<cr>
nnoremap <tab> <cmd>bnext<cr>

"  Go to last buffer
nnoremap <leader>bb :e #<cr>


" Navigate the quickfix list
nnoremap [q <cmd>exe v:count .. "cprev"<cr>
nnoremap ]q <cmd>exe v:count .. "cnext"<cr>
nnoremap [Q <cmd>cfirst<cr>
nnoremap ]Q <cmd>clast<cr>
nnoremap [l <cmd>lnext<cr>
nnoremap ]l <cmd>lprevious<cr>


" -- Insert Mode --

" Make 'jk' an escape sequence (convenient shortcut):
inoremap jk <esc>

" Make the current word upper-case:
inoremap UU <esc>gUawea


" -- Visual Mode --

" Stay in indent mode
vnoremap < <gv
vnoremap > >gv
