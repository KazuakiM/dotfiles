# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin:$HOME/.phpenv/bin:$HOME/.pyenv/bin
eval "$(rbenv init -)"
eval "$(phpenv init -)"
eval "$(pyenv init -)"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
# GitHub
unset SSH_ASKPASS
# alias
#{{{
# Common
alias vi='vim'
alias rm='rm -i'
alias cp='cp -p'
alias mv='mv -i'
alias h='history'
alias cl='clear'
alias df='df -h'
# Directory
alias l='ls --color=auto'
alias ls='ls -a --color=auto'
alias sl='ls -a --color=auto'
alias ll='ls -a -l --color=auto'
#}}}
