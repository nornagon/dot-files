function __ps1_git_state() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ' %{'$fg[red]'%}'${ref#refs/heads/}'%{'$terminfo[sgr0]'%}'
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
 
PS1=$_bracket_color'[\
%{$terminfo[sgr0]%}$(__custom_pwd)\
$(__ps1_git_state)\
'$_bracket_color']%{$terminfo[sgr0]%} '
#%{'$_hostcolor'%}%m%{$fg_bold[red]%}:%{$terminfo[sgr0]%}$(__custom_pwd)\
