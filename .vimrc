set encoding=utf-8
scriptencoding utf-8

" vim-plug ===============================================
call plug#begin('~/.vim/plugged')
Plug 'shougo/neosnippet.vim'
Plug 'shougo/neosnippet-snippets'
Plug 'tyru/caw.vim'
Plug 'itchyny/lightline.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'fatih/vim-go'

call plug#end()
" General ================================================
" setting
set backspace=indent,eol,start
set nobackup
set expandtab
set noswapfile
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent
set autoread
set wildmenu
set mouse-=a
nnoremap j gj
nnoremap k gk

nnoremap <Up> <Nop>
nnoremap <Down> <Nop>

" display
set number
set title
set showcmd
set showmatch
set laststatus=2
set background=dark
set t_Co=256
set cursorline
syntax on

" search
set incsearch
set smartcase
set ignorecase
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Plugin neosnippet ======================================
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB>
			\ pumvisible() ? "\<C-n>" :
			\ neosnippet#expandable_or_jumpable() ?
			\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_direcotry='~/.vim/plugged/neosnippet-snippets/neosnippets/,~/.vim/mysnippets'

" Plugin caw.vim =========================================
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

" Plguin lightline.vim ===================================
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode'
      \ }
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" python ===================================
autocmd BufNewfile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewfile,BufRead *.py setfiletype python 
autocmd BUfNewFile,BufRead *.py nnoremap <C-e> :!python3 %

" golang ===================================
autocmd BufNewfile,BufRead *.go nnoremap <C-e> :!go run %
