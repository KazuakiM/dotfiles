# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
eval "$(rbenv init -)"
export PATH
export LD_LIBRARY_PATH
# alias
#{{{
# Regular
alias vi='vim'
alias rm='rm -i'
alias cp='cp -p'
# Directory
alias l='ls --color=auto'
alias ls='ls -a --color=auto'
alias sl='ls -a --color=auto'
alias ll='ls -a -l --color=auto'
#}}}
