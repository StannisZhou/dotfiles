function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Use bash-completion, if available
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# added by Miniconda3 installer
export PATH="/Users/zguangya/miniconda3/bin:$PATH"
export EDITOR='gvim --remote'

# For terminal colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Forward/backward search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Ignore case for completion
bind 'set completion-ignore-case on'

# Alias for managing dotfiles
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
