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

# Aliases for syncing code
alias sync_rna_stats='rsync -avzh -e "ssh -i /Users/zguangya/Dropbox/aws_key_pairs/aws_deep_learning.pem" /Users/zguangya/Dropbox/rna_statistics_git_repo/ ubuntu@ec2-34-238-38-216.compute-1.amazonaws.com:/home/ubuntu/rna_statistics/rna_statistics_git_repo/ --delete --exclude __pycache__ --exclude intermediate --exclude paper'
alias sync_hedge_fund='rsync -avzh -e "ssh -i /Users/zguangya/Dropbox/aws_key_pairs/aws_deep_learning.pem" /Users/zguangya/MEGA/hedge_fund ubuntu@ec2-34-238-38-216.compute-1.amazonaws.com:/home/ubuntu/hedge_fund/ --delete --exclude *.egg-info'

# Misc
alias texmacs='/Applications/TeXmacs-1.99.6.app/Contents/MacOS/TeXmacs &'
export PATH="/usr/local/opt/qt/bin:$PATH"
