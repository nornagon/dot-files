bindkey -e
 
# C-left and C-right to go back/forward a word.
# NB. in OS X, these are bound to Mission Control by default, and you'll need
# to disable them there before these will work.
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word

# for URxvt
bindkey '\eOd' backward-word
bindkey '\eOc' forward-word

# for iTerm2
bindkey '\e[3~' delete-char

bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
