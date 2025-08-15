autoload -U compinit; compinit -i -C
# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath
 
[ -x "$(which rbenv)" ] && eval "$(rbenv init -)"
[ -x "$(which pyenv)" ] && eval "$(pyenv init -)"

. ~/.ellipsis/init.sh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export EDITOR=`which nvim`
export VISUAL=$EDITOR
export PYTHONSTARTUP=$HOME/.pythonrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

which fzf >/dev/null && source <(fzf --zsh)

test -e "${HOME}/.zshrc_local" && source "${HOME}/.zshrc_local"

. "$HOME/.local/bin/env"
