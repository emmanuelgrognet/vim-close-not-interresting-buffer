"=====================================================================================
" Description:  Close Vim if only "not interresting buffers" are open 
" Maintener:    Emmanuel Grognet <emmanuel AT grognet DOT fr>
" Based_on:	https://yous.be/2014/11/30/automatically-quit-vim-if-actual-files-are-closed/
" License:      DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"	                   Version 2, December 2004
"
"		Copyright (C) 2016 Emmanuel Grognet
"
"		Everyone is permitted to copy and distribute verbatim or modified
"		copies of this license document, and changing it is allowed as long
"		as the name is changed.
"
"	        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"		TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
"
"		0. You just DO WHAT THE FUCK YOU WANT TO.
"=====================================================================================

if exists('g:not_interresting_buffers_loaded')
        finish
endif
let g:not_interresting_buffers_loaded = 1

function! CheckNotInterrestingBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction

autocmd BufEnter * call CheckNotInterrestingBuffers()

