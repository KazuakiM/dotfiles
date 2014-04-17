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
## GitHub
##{{{
#unset SSH_ASKPASS
##}}}
# alias / export
## Common
#{{{
alias rm='rm -i'
alias cp='cp -i -p'
alias mv='mv -i'
alias h='history'
alias cl='clear'
alias lc='clear'
alias df='df -h'
alias grep='grep --color=auto'
export LANG=ja_JP.UTF-8
#}}}
## OS
#{{{
case "${OSTYPE}" in
    darwin*)
        alias l='ls -Ga'
        alias ls='ls -Ga'
        alias sl='ls -Ga'
        alias ll='ls -Gla'
        alias vi='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias vim='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        export LSCOLORS=DxgxcxdxbxCxfxBxFxhxGx
        ;;
    linux*)
        alias l='ls --color=auto'
        alias ls='ls -a --color=auto'
        alias sl='ls -a --color=auto'
        alias ll='ls -a -l --color=auto'
        alias vi='vim'
        ;;
esac
#}}}
