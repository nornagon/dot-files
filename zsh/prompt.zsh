function __ps1_git_state() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ' %{'$fg[red]'%}'${ref#refs/heads/}'%{'$terminfo[sgr0]'%}'
}

function __ps1_dir_color() {
  # Hash PWD into a custom background color for iterm
  # form: ESC]11;rgb:RRRR/GGGG/BBBB/ST
  # e.g. echo -e "\033]11;rgb:1a1a/1a1a/1a1a\007"
  local h
  h=$(echo -n $PWD | md5sum)
  local r=$(printf "%02x" $(( (0x${h:1:2} / 16) )))
  local g=$(printf "%02x" $(( (0x${h:3:2} / 16) )))
  local b=$(printf "%02x" $(( (0x${h:5:2} / 16) )))
  echo -ne "%{\e]11;rgb:${r}/${g}/${b}\007%}"
}
 
function __custom_pwd() {
  local d slash
  d=${PWD/#$HOME/\~}
  case $d in
    /*) slash=/ ;;
    *) slash= ;;
  esac
  d=(${(s:/:)d})
  d[1]=$slash$d[1]
  num=$#d
  ellipsis=
  if (( num > 3 )); then num=3; ellipsis='…'; fi
  d=$ellipsis${(j./.)d[-$num,-1]}
  echo -ne "%{\e]0;$d\007%}"
  echo $d
}
 
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
 
local _hostcolor="$fg_bold[green]"
if [ -f ~/.hostcolor ]; then
  _hostcolor="$fg_bold[$(cat ~/.hostcolor)]"
fi
 
# Turn brackets green when in ':sh' from vim
local _bracket_color='%(!.%{$fg_bold[red]%}.%{$fg_bold[blue]%})'
if [[ -n $MYVIMRC ]]; then
  _bracket_color='%{$fg_bold[green]%}'
fi
 
PS1=$_bracket_color'[$(__ps1_dir_color)\
%{'$_hostcolor'%}%m%{$fg_bold[red]%}:%{$terminfo[sgr0]%}$(__custom_pwd)\
$(__ps1_git_state)\
'$_bracket_color']%{$terminfo[sgr0]%} '
#%{$terminfo[sgr0]%}$(__custom_pwd)\
