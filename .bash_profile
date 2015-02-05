# .bash_profile
# Get the aliases and functions {{{
if [ -f ~/.bash_profile.win ]; then
    . ~/.bash_profile.win
elif [ -f ~/.bash_profile.local ]; then
    . ~/.bash_profile.local
fi
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
#}}}
#User specific environment and startup programs {{{
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export LANG=ja_JP.UTF-8
cd
clear
#}}}
#Common {{{
shopt -s cdspell
alias cl='clear'
alias lc='clear'
alias cp='cp -i -p'
alias df='df -h'
alias gdiff='git diff -b'
alias h='history'
alias mv='mv -i'
alias rm='rm -i'
alias tree='tree -af'
alias FIND='find ./ -type d -name ".git" -prune -o -type d -name ".svn" -prune -o -type f -name "*min.js" -prune -o -type f -name "*min.css" -prune -o -type f -print | xargs grep --color -I -n "$@"'
if type colordiff >/dev/null 2>&1; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi
if type htop >/dev/null 2>&1; then
    alias top='htop'
fi
export GREP_OPTIONS='--color=auto -I'
export GREP_COLOR='1;33'
alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS
export XMLLINT_INDENT='    '
#}}}
# Less {{{
export LESS='-R --no-init'
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;32m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[1;34m") \
        LESS_TERMCAP_so=$(printf "\e[1;35m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;33m") \
        man "$@"
}
#}}}
#PS1(primary prompt string) {{{
export PS1="\[\e[1;36m\]\h \$ \[\e[1;0m\]"
#}}}
#tmux {{{
if type tmux >/dev/null 2>&1; then
    alias tm='tmux'
    alias tma0='tmux attach -d -t 0'
    alias tma1='tmux attach -d -t 1'
    alias tma2='tmux attach -d -t 2'
fi
#}}}
#OS Type {{{
case "${OSTYPE}" in
    darwin*)
        alias l='ls -AGh'
        alias ls='ls -AGh'
        alias sl='ls -AGh'
        alias ll='ls -AGhl'
        alias vi='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias vim='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias gvim='open -a MacVim "$@"'
        alias httpd='sudo apachectl'
        alias composer='php -d memory_limit=1G /usr/local/opt/composer/libexec/composer.phar'
        alias MYSQL='mysql.server'
        alias FF='open -a firefox'
        alias GG='open -a firefox'
        alias MM='open -a thunderbird'
        alias MAIL='open -a thunderbird'
        alias TT='open -a yorufukurou'
        alias RR='open -a yorufukurou'
        alias YORU='open -a yorufukurou'
        alias TWI='open -a tweetdeck'
        alias IT='open -a itunes'
        alias TI='open -a itunes'
        alias ITUNES='open -a itunes'
        alias OFFICE='open -a /Applications/OpenOffice.org.app/Contents/MacOS/soffice'
        alias FTP='open -a FileZilla'
        alias SFTP='open -a FileZilla'
        alias FTPS='open -a FileZilla'
        alias VPN='open -a tunnelblick'
        alias VNC='open -a "Chicken of the VNC"'
        alias VB='open -a virtualbox'
        alias BV='open -a virtualbox'
        alias VM='open -a virtualbox'
        alias MV='open -a virtualbox'
        alias KOBO='open -a kobo'
        alias KINDLE='open -a kindle'
        alias LINGR="sh $HOME/work/dotfiles/src/lingrStarter.sh"
        alias DEV="sh $HOME/work/dotfiles/src/virutalBoxManageForMac.sh devmabu"
        alias MABU="ssh -l mabulog -p 2222 localhost"
        alias WIRE='/usr/local/bin/wireshark'
        alias WIRESHARK='/usr/local/bin/wireshark'
        export LSCOLORS=DxgxcxdxcxCxfxBxFxhxfx
        export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
        if type rbenv >/dev/null 2>&1; then
            export RBENV_ROOT=/usr/local/bin
            eval "$(rbenv init -)";
        fi
        localPath=''
        #brew --prefix perl518
        if [ -d /usr/local/opt/perl518/bin ]; then
            localPath="/usr/local/opt/perl518/bin:$localPath"
        fi
        #brew --prefix gnu-tar
        if [ -d /usr/local/opt/gnu-tar/libexec/gnubin ]; then
            localPath="/usr/local/opt/gnu-tar/libexec/gnubin:$localPath"
        fi
        #brew --prefix svn
        if [ -d /usr/local/opt/subversion/bin ]; then
            localPath="/usr/local/opt/subversion/bin:$localPath"
        fi
        if [ -d /usr/local/heroku/bin ]; then
            localPath="/usr/local/heroku/bin:$localPath"
        fi
        export PATH=$localPath$PATH
        export MYSQL_PS1="\d @\h \n> "
        #export MYSQL_PS1="\d @\h[\u] \n> "
        ;;
    linux*)
        alias l='ls -AhX --color=auto'
        alias ls='ls -AhX --color=auto'
        alias sl='ls -AhX --color=auto'
        alias ll='ls -AhXl --color=auto'
        alias vi='vim'
        export EDITOR=vim
        localPath=''
        #rbenv
        if [ -d /usr/local/rbenv/bin ]; then
            localPath="/usr/local/rbenv/bin:$localPath"
        fi
        export PATH=$localPath$PATH
        if type rbenv >/dev/null 2>&1; then
            export RBENV_ROOT=/usr/local/rbenv
            eval "$(rbenv init -)";
        fi
        export MYSQL_PS1="\d> "
        ;;
    cygwin)
        alias l='ls -Ak --color=auto'
        alias ls='ls -Ak --color=auto'
        alias sl='ls -Ak --color=auto'
        alias ll='ls -Akl --color=auto'
        alias vi="$HOME/src/vimStarter.sh"
        alias vim="$HOME/src/vimStarter.sh"
        alias gvim="$HOME/src/vimStarter.sh"
        ;;
esac
#}}}
