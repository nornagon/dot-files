export EDITOR=`which vim`
export VISUAL=$EDITOR

export PYTHONSTARTUP=~/.pythonrc
 
# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath
 
[ -x "$(which rbenv)" ] && eval "$(rbenv init -)"

. ~/.ellipsis/init.sh
