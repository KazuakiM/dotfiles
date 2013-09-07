# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
#{{{
export PATH=$HOME/.anyenv/bin:$PATH:$HOME/bin
eval "$(anyenv init -)"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
cd
clear
#}}}
# GitHub
#{{{
unset SSH_ASKPASS
#}}}
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
