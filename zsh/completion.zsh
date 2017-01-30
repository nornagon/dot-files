# Honestly I have no idea what most of the things in this file do
autoload -U compinit
compinit
 
# Completion Styles
 
# recognizes new commands
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}
 
# list of completers to use
zstyle ':completion:*::::' completer _force_rehash _expand _complete _approximate _ignored
zstyle ':completion:*' menu select
 
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
 
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# command for process lists, the local web server details and host completion
zstyle ':completion:*:processes' command 'ps -axo pid,s,nice,stime,args'
 
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
 
# for git-{name-rev,add,rm}, don't complete words that are already on the line
zstyle ':completion::*:git-{name-rev,add,rm}:*' ignore-line true

autoload bashcompinit
