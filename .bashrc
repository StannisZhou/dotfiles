HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=200000
shopt -s checkwinsize
. ~/.bash_prompt
# Forward/backward search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# Ignore case for completion
bind 'set completion-ignore-case on'
/usr/bin/xcape -e "Super_L=Escape" -t 150
/usr/bin/xbindkeys --poll-rc
