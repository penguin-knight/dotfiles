set encoding=utf-8
scriptencoding utf-8

" vim-plug ===============================================
call plug#begin('~/.vim/plugged')
Plug 'shougo/neosnippet.vim'
Plug 'shougo/neosnippet-snippets'

call plug#end()
" General ================================================
set tabstop=2
set number
set smartindent
set title
set shiftwidth=2
syntax on


" Plugin neosnippet ======================================
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
			\ pumvisible() ? "\<C-n>" :
			\ neosnippet#expandable_or_jumpable() ?
			\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_direcotry='~/.vim/plugged/neosnippet-snippets/neosnippets/,~/.vim/mysnippets'
