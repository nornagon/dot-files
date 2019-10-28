case "$(uname)" in
  Darwin)
    alias ls='ls -GFh' # OSX
    # See `man ls` for details
    export LSCOLORS="ExGxcxdxCxegedabagacad"
    ;;
  Linux)
    alias ls='ls -GFh --color=auto' # Linux
    if [[ -f $HOME/.dircolors ]]; then
      eval `dircolors -b ~/.dircolors`
    else
      eval `dircolors -b`
    fi
    ;;
esac
 
alias nethack="[ -f ~/.nethack-reminder ] && (cat ~/.nethack-reminder;echo -n Press enter to play...;read);nethack"
alias locate='noglob locate'
alias find='noglob find'

alias gdb='gdb -q'
 
alias a='ls'

vim() {
  if which nvim >/dev/null; then
    nvim "$@"
  else
    =vim "$@"
  fi
}

mvim() {
  if which vimr >/dev/null; then
    vimr "$@"
  else
    =mvim "$@"
  fi
}

alias e='vim -p'
alias vi='vim'
alias svi='sudo -e'


alias m='mvim -p'
alias mvim='mvim -p'

alias grep=egrep
 
alias sagi='sudo apt-get install'
alias sag='sudo apt-get'
alias acs='apt-cache search'
alias acsh='apt-cache show'

alias pingle='ping www.google.com'
alias mtr='sudo mtr'
alias mtrgle='mtr www.google.com'

alias gp='git pull --rebase && git push'
alias gs='git status'
alias gap='git add -p'
 
# At least let me see what I fucked up
alias cp='cp -v'
alias rm='rm -v'

alias rc='bundle exec rails c'
alias hrc='heroku run rails c -a transcriptic'
 
# Global aliases -- These do not have to be at the beginning of the command
# line.
alias -g L='|less'
 
mkcd() { mkdir -p $1 && cd $1 }
 
# Just type the name of a host in your ssh config to teleport there.
if [[ -f ~/.ssh/config && -r ~/.ssh/config ]]; then
  while read line; do
    if [[ $line =~ '^Host (.+)$' ]]; then
      alias $match[1]="ssh $match[1] -t"
    fi
  done < ~/.ssh/config
fi
 
# ssh to ec2 instances by name
ip_for_ec2_instance() {
  aws ec2 describe-instances \
    --region us-west-2 \
    --filters '{"Name":"tag:Name", "Values":["'"$1"'"]}' \
    --query="Reservations[0].Instances[0].PublicIpAddress" \
    | tr -d '"'
}
ec2() {
  ssh ubuntu@$(ip_for_ec2_instance "$1") ${*:2}
}

unwhiteboard() {
  convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$2"
}

who_the_fuck_is_using_port() { sudo lsof -iTCP:$1 }

sar() {
  rg -l "$1" | xargs sed -i '' "s/$1/$2/g"
}
