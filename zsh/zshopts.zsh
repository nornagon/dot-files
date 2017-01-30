WORDCHARS='*?_-.[]~&;!#$%^(){}<>' # no /!
DIRSTACKSIZE=20
 
# cd = pushd.
setopt autopushd
# Do not print the directory stack after pushd or popd.
setopt pushdsilent
# Require >| or >! to clobber an existing file.
setopt noclobber
# It's useful to comment stuff out to save it to history.
setopt interactivecomments
# Automatically list choices on an ambiguous completion.
setopt autolist
# Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt notify
# Don't bug me about mail.
setopt nomailwarning
# Don't beep.
setopt nobeep
# Some prompt stuff?
setopt prompt_cr prompt_sp prompt_subst
 
# History stuff
HISTSIZE=100000
SAVEHIST=90000
HISTFILE=~/.history
 
setopt append_history         # don't sabotage $HISTFILE when we close a shell
setopt inc_append_history     # don't wait 'till we quit to write to $HISTFILE
setopt histignorealldups      # ignore duplicate entries in history
setopt hist_expire_dups_first # duplicate lines in the history will be deleted preferentially when $HISTSIZE is reached
setopt no_hist_beep           # it's usually pretty obvious when we hit the end XXX: needed with nobeep?
