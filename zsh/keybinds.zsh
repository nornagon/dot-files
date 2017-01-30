bindkey -e
 
# C-left and C-right to go back/forward a word.
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
# for URxvt
bindkey '\eOd' backward-word
bindkey '\eOc' forward-word
# for Terminal.app
bindkey '\e[5D' backward-word
bindkey '\e[5C' forward-word
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey "[1~" beginning-of-line
bindkey "[4~" end-of-line
bindkey "[3~" delete-char
