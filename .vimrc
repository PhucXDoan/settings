function! Configure_Syntax(kind)
	syntax match ExWhitespace /\v^ /         containedin=ALL " Lines beginning with a space.
	syntax match ExWhitespace /\v\s+$/       containedin=ALL " Lines ending with a space.
	syntax match ExWhitespace /\v\zs \ze\t/  containedin=ALL " Space followed by a tab.
	syntax match ExWhitespace /\v\t\zs \ze/  containedin=ALL " Tab followed by a space.
	syntax match ExWhitespace /\v\S\zs\t\ze/ containedin=ALL " Non-whitespace followed by a tab.
	highlight ExWhitespace ctermfg=white        ctermbg=red

	if a:kind != 'base'
		set syntax=off
	endif

	if a:kind == 'c'
		syntax match  Comment                                                     /\v\/\/.*$/
		syntax region Comment                                                     start=/\v\/\*/ end=/\v\*\//
		syntax region String      transparent                                     start=/\v\"/   end=/\v\"/
		syntax match  Debug       containedin=ALLBUT,Comment                      /\v<(_)*DEBUG(_)?\w*/
		syntax match  Meta                                                        /\v(^\s*\#include>.*\n\s*)?(^\s*\/\*\s*\#meta>.*\n\s*)\_.{-}\*\//
		syntax match  MetaBody    contained containedin=Meta      contains=Assert /\v(^\s*\#include>.*\n\s*)?(^\s*\/\*\s*\#meta>.*\n\s*)@<=\s*\_.{-}\*\//
		syntax match  MetaComment contained containedin=MetaBody                  /\v(^|\s)\zs\#.*$/
	elseif a:kind == 'python'
		syntax match  Comment   /\v(^|\s)\zs\#.*$/
		syntax match  Meta      /\v%^(^\s*\#include>.*\n\s*)?#meta>.*\n/
	endif

	if a:kind != 'base'
		syntax match   Assert /\v<(static_)?assert\w*>/
		syntax match   Tmp    containedin=ALL /\v<TMP(_)?\w*>*/
		syntax keyword Todo   containedin=ALL TODO
		syntax keyword Sorry  containedin=ALL sorry
	endif

	" Useful color picker and previewer: michurin.github.io/xterm256-color-picker/
	highlight Comment      ctermfg=cyan         ctermbg=none
	highlight Meta         ctermfg=lightgreen   ctermbg=none
	highlight MetaBody     ctermfg=lightgreen   ctermbg=none
	highlight MetaComment  ctermfg=darkgreen    ctermbg=none
	highlight Assert       ctermfg=yellow       ctermbg=none
	highlight Search       ctermfg=59           ctermbg=230
	highlight Tmp          ctermfg=black        ctermbg=yellow
	highlight Debug        ctermfg=darkgray     ctermbg=none
	highlight CursorLine   ctermfg=none         ctermbg=none    ctermul=203
	highlight Todo         ctermfg=black        ctermbg=magenta
	highlight Sorry        ctermfg=white        ctermbg=darkred
	highlight String       ctermfg=lightmagenta ctermbg=none
	highlight ExWhitespace ctermfg=white        ctermbg=red

	syntax sync fromstart " Makes region highlighting more reliable.
endfunction

function! Handle_File_Extension()
	filetype plugin indent off
	set noet ci pi sts=0 sw=4 ts=4

	nnoremap / /\v

	set nowrap                  " Lines will not wrap and only part of long lines will be displayed.
	set hlsearch                " When there is a previous search pattern, highlight all its matches.
	set incsearch               " While typing a search command, show where the pattern, as it was typed so far, matches.
	set autoindent              " Copy indent from current line when starting a new line.
	set showcmd                 " Show (partial) command in the last line of the screen. This is useful for showing amount of lines/characters selected.
	set ruler                   " Show the line and column number of the cursor position.
	set rulerformat=%(%=%l,%c%) " Determines the content of the ruler string, as displayed for the 'ruler' option.
	set timeoutlen=0            " The time in milliseconds that is waited for a key code or mapped key sequence to complete. Otherwise, there'll be a delay after <ESC>.
	set nrformats+=alpha        " Single alphabetical characters will be incremented or decremented.
	set scrolloff=4             " Minimal number of screen lines to keep above and below the cursor.
	set shortmess-=S            " Show search count message when searching.
"	set fileformat=unix         " Use LF endings.
	set fileformats=unix,dos    " "
	syntax enable               " Switch on syntax highlighting.
	nohlsearch                  " Stop the highlighting for the 'hlsearch' option. This is set automatically due to 'set hlsearch'.

	call Configure_Syntax('base')
endfunction

augroup Main_Augroup
	autocmd!
	autocmd VimEnter                             * :if !argc() | Explore | endif " Go into Netrw on startup only if no explicit files to be edited were given.
	autocmd BufEnter,WinEnter                    * :set cursorline
	autocmd WinLeave                             * :set nocursorline
	autocmd VimEnter,BufRead,BufNewFile,BufEnter * :call Handle_File_Extension()
augroup END
