set spell

call plug#begin('~/.vim/plugged')
" Neovim in the browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Airline
Plug 'vim-airline/vim-airline'

call plug#end()

if exists('g:started_by_firenvim')
let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'nvim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea'
        \ },
    \ }
\ }"

au BufEnter github.com_*.txt set filetype=markdown
set guifont=Operator_Mono:h25
endif