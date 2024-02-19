# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath
 
[ -x "$(which rbenv)" ] && eval "$(rbenv init -)"
[ -x "$(which pyenv)" ] && eval "$(pyenv init -)"

. ~/.ellipsis/init.sh

export EDITOR=`which nvim`
export VISUAL=$EDITOR
export PYTHONSTARTUP=$HOME/.pythonrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.zshrc_local" && source "${HOME}/.zshrc_local"
