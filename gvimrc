set guioptions-=m    " No menus
set guioptions-=T    " No toolbar
set guioptions-=r    " No scrollbars
 
set guicursor=a:blinkon0 " No cursor blinky
 
" Fonts and other GUI settings
if has("gui_gtk2")
  " Try and pick it up from GNOME if we can
  if executable("gconftool-2")
      let &gfn=system("gconftool-2 -g /desktop/gnome/interface/monospace_font_name")
  else
      set guifont=Terminus\ 10
  endif
elseif has("gui_macvim") || has("gui_vimr")
  set guifont=Menlo:h12
  set transparency=10
 
  " Switch tabs with Cmd-Alt-<Arrows>, like Chrome
  nmap <D-M-Right> gt
  nmap <D-M-Left> gT
 
  colo desert
  hi LineNr guifg=#a0a0a0 guibg=NONE
 
  " Fill the screen in fullscreen mode
  set fuopt=maxhorz,maxvert
else
  " Windows?
  set guifont=Bitstream_Vera_Sans_Mono:h9:cDEFAULT
endif

" omg don't balloon at me
set noballooneval
