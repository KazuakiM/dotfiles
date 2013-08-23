# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export RBENV_ROOT=$HOME/.rbenv
export PATH=$PATH:$HOME/bin:$RBENV_ROOT/bin
eval "$(rbenv init -)"
export PATH=$HOME/.phpenv/bin:$PATH
eval "$(phpenv init -)"
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
# Directory
alias l='ls --color=auto'
alias ls='ls -a --color=auto'
alias sl='ls -a --color=auto'
alias ll='ls -a -l --color=auto'
#}}}
