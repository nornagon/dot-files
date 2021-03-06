set nocompatible

call plug#begin()

" Utils
Plug 'jazzcore/ctrlp-cmatcher', { 'do': './install.sh' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'AndrewRadev/sideways.vim'
Plug 'michaeljsmith/vim-indent-object' " vii selects block by indent
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'

" Language support
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'scrooloose/syntastic'

Plug 'pangloss/vim-javascript'
Plug 'flowtype/vim-flow'
Plug 'leafgarland/typescript-vim' " typescript syntax
"Plug 'Quramy/tsuquyomi'           " typescript fanciness
"Plug 'Shougo/vimproc.vim'         " required by tsuquyomi
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less' " lesscss
Plug 'elzr/vim-json'
Plug 'Shirk/vim-gas'
Plug 'derekwyatt/vim-scala'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hashivim/vim-terraform'
Plug 'justinj/vim-pico8-syntax'
Plug 'evanrelf/vim-pico8-color'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'ziglang/zig.vim'

call plug#end()

set visualbell " omg stop beeping at me

syn on
filetype plugin indent on
 
set ts=2 sw=2 expandtab
set textwidth=79
set autoindent smarttab
 
" keep 4 lines between the cursor and the edge of the screen where possible
set scrolloff=4

" r=insert comment leader when <Return> in insert mode
" j=remove comment leader when joining lines
" This is in an autocmd because it seems to be often overridden
autocmd BufNewFile,BufRead * setlocal formatoptions+=rj
 
" copy indentation style from the previous line. this means if i do:
" if (blah) {<CR>
" <TAB>int x = 0,<CR>
" <TAB>____y = 3,<CR>
"
" i will get
" <TAB>____(cursor)
" instead of
" <TAB><TAB><TAB>(cursor)
"
" good for using tabs as they were intended (i.e, to indent) and then using
" spaces for formatting.
set copyindent
 
" highlight the line the cursor is on. usually done with an underline, but it
" is configurable by color scheme.
set cursorline
 
" when i :set list, show tabs with unicode arrows instead of as ^I
set listchars+=tab:►─
 
" wrap on word breaks, not between characters
" there's a space at the end of that line, after the \. that's important.
set wrap linebreak showbreak=↪\ 
 
" when you open a file you were just editing, vim should remember which line
" you were on and put you back there.
set viminfo='50,\"100,:40,n~/.viminfo
au BufReadPost * if line("'\"") > 0 | if line("'\"") <= line("$") |
    \ exe("norm '\"") | else | exe("norm $") | endif | endif
 
" for completing file names, etc. complete the longest match. if i press tab
" again, show me a list. if i press tab again, start cycling through the
" options.
set wildmode=longest,list,full
 
" let the mouse work in console mode. I generally just use it for the scroll
" wheel.
if &term == "screen"
  set ttymouse=xterm2
endif
if has("mouse") && !has("gui_running")
  set mouse=nvir
endif
 
" helps for function completion.
set path=.,/usr/include,/usr/include/*,,
 
" for completion in insert mode (^X^P etc).
set completeopt=longest,menuone
 
" put swap files in ~/.vim-swp instead of in the directory of the file.
" double / at the end means to uniquify the swap file names by using the full
" path and replacing / with %
silent !mkdir -p ~/.vim-swp
set directory=~/.vim-swp//
 
" show file position in bottom-right corner
set ruler
 
" incremental search
set incsearch
 
" iirc, the vim xml stuff is pretty annoying without this.
let xml_use_xhtml = 1
 
" i hold shift down too long when i hit :w...
command! W :w
command! Wq :wq
command! WQ :wq
command! Q :q
 
noremap <S-m> :w<CR>:!mvim %<CR>:q<CR>
 
" f1 does not need to do :h for me, thanks. especially since it's so close to
" ESC
nmap <F1> <nop>
imap <F1> <nop>
map <S-CR> <nop>
noremap H <nop>
noremap L <nop>

" C-h is a more ergonomic way to type 'esc'
inoremap <C-h> <esc>
vnoremap <C-h> <esc>
onoremap <C-h> <esc>
nnoremap <C-h> <esc>
 
" do sane things with insane line endings, hopefully.
set fileformats=unix,mac,dos
 
" the one true shell
set shell=/bin/zsh
 
" Clever tab - if at start of line insert spaces; else complete word
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
 
" for C files, expand #i<SPACE> to #include<SPACE>, and similarly for #define.
" set foldmethod=marker because C sucks at modularisation, and {{{/}}} makes
" code much easier to move around. 'zt' -> 'z(this)', closes all folds but the
" one under the cursor.
au FileType c,cpp iab #i #include| iab #d #define| set foldmethod=marker

" Don't wrap JSON at 80 chars.
au FileType json set tw=0

" Let's all pretend
au BufNewFile,BufRead *.glsl,*.vert,*.frag set ft=c

au BufNewFile,BufRead *.scss,*.css set iskeyword+=-

au BufNewFile,BufRead *.p8 set nowrap | colo pico8
"au BufNewFile,BufRead *.p8 set guifont=PICO-8:h12 | set linespace=3
 
" vim -b : edit binary using xxd format
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd -p -c 64
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -p -c 64 -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd -p -c 64
  au BufWritePost *.bin set nomod | endif
augroup END
 
if !has("gui_running")
  set bg=dark
endif
 
" dvorak bindings for htns -> navigation. ... wish i could work out a way to
" hook this into OS X to work out the currently active keymap.
"
" k becomes 'find next' (in place of 'n')
" j becomes 'until before next occurrance of' (in place of t)
 
if 1
  noremap t j
  noremap j t
  noremap n k
  noremap k n
  noremap s l
  noremap l s
  noremap <S-t> 12j
  noremap <S-n> 12k
  noremap K N
endif

" ctrl-(up/down) nav keys change tabs
noremap <C-t> <C-PageDown>
noremap <C-n> <C-PageUp>
inoremap <C-t> <C-PageDown>
inoremap <C-n> <C-PageUp>
 
" editor
 
set hls
nmap z zz
"nmap * *K
nmap \ :noh<CR>
 
" Alt-O opens .h file if pressed in .cpp file and vice-versa.
function! RelatedFiles()
  return filter(split(globpath(expand('%:h'), expand('%:t:r').'.*')), '!bufloaded(v:val)')
endfunction
function! OpenRelatedFile()
  let files = RelatedFiles()
  if len(files) > 0
    if match(files[0], "\.h$") >= 0
      exec 'lefta vsplit '.files[0]
    else
      exec 'rightb vsplit '.files[0]
    endif
  endif
endfunction
nmap o :call OpenRelatedFile()<CR>
nmap <M-o> :call OpenRelatedFile()<CR>
nmap ø :call OpenRelatedFile()<CR>
 
" Search should only be case-sensitive if a non-lowercase letter is typed.
set ignorecase smartcase
 
set nocompatible
set backspace=indent,eol,start

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 0
let g:ctrlp_match_func = {'match' : 'matcher#cmatch'}
"let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_use_caching = 0
" Requires The Silver Searcher https://geoff.greer.fm/ag/
let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'

" Don't show these in CtrlP
set wildignore+=*/gen/*,*.so,*.swp,*.zip,*/tmp/*,*.pyc,*.class
set wildignore+=*/scala-2.10/cache/*,*.class,*/$global/*,*/reports/*
set wildignore+=*/_site/*

" + greps for the token under the cursor
set grepprg=ag\ --nogroup\ --nocolor
nnoremap + :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>
set switchbuf+=usetab,newtab

let g:syntastic_coffee_coffeelint_args = "--csv --file ~/.coffeelint.json"
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='✦'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++1z -stdlib=libc++'

let g:jsx_ext_required = 0

let g:javascript_plugin_flow = 1

nnoremap <s-h> :SidewaysLeft<cr>
nnoremap <s-s> :SidewaysRight<cr>
