export EDITOR=`which nvim`
export VISUAL=$EDITOR

export PYTHONSTARTUP=~/.pythonrc
 
# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath
 
[ -x "$(which rbenv)" ] && eval "$(rbenv init -)"
[ -x "$(which pyenv)" ] && eval "$(pyenv init -)"

. ~/.ellipsis/init.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export AGREE_NOTGOMA_TOS=1
