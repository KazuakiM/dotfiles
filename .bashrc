# .bashrc
# Get the aliases and functions {{{
if [ -f ~/.bashrc.win ]; then
    . ~/.bashrc.win
elif [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
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
export HISTFILE='/var/log/bash_history'
alias cl='clear'
alias lc='clear'
alias cp='cp -i -p'
alias df='df -h'
alias h='history'
alias mv='mv -i'
alias rm='rm -i'
alias tree='tree -af'
#}}}
#find {{{
findIgnore=''
findIgnore=${findIgnore}'    -type d -iname ".git"     -prune'
findIgnore=${findIgnore}' -o -type d -iname ".svn"     -prune'
findIgnore=${findIgnore}' -o -type f -iname "*.log"    -prune'
findIgnore=${findIgnore}' -o -type f -iname "*.json"   -prune'
findIgnore=${findIgnore}' -o -type f -iname "*min.js"  -prune'
findIgnore=${findIgnore}' -o -type f -iname "*min.css" -prune'
alias FIND='find ./ '${findIgnore}' -o -type f -print0 | xargs -0 grep --color -i -I -n "$@"'
#}}}
#diff {{{
if type colordiff >/dev/null 2>&1; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi
#}}}
#htop {{{
if type htop >/dev/null 2>&1; then
    alias top='sudo htop'
fi
#}}}
#grep {{{
export GREP_OPTIONS='--color=auto -i -I'
export GREP_COLOR='1;33'
alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS
#}}}
#xml {{{
export XMLLINT_INDENT='    '
#}}}
#history {{{
export HISTCONTROL=erasedups
export HISTSIZE=2000
export HISTTIMEFORMAT='%F %T '
#}}}
#less {{{
export LESS='-R --no-init'
export LESSHISTFILE='/var/log/lesshst'
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
export PS1="\[\e[1;36m\]\u \$ \[\e[1;0m\]"
#}}}
#tmux {{{
if type tmux >/dev/null 2>&1; then
    alias tm='tmux'
    alias tma0='tmux attach -d -t 0'
    alias tma1='tmux attach -d -t 1'
    alias tma2='tmux attach -d -t 2'
fi
#}}}
#MySQL {{{
export MYSQL_HISTFILE='/var/log/mysql_history'
#}}}
#OS Type {{{
case "${OSTYPE}" in
    darwin*)
        #command {{{
        alias l='ls -AGh'
        alias ll='ls -AGhl'
        alias ls='ls -AGh'
        alias sl='ls -AGh'
        alias lingr="sh $HOME/work/dotfiles/src/lingrStarter.sh"
        alias vi='gvim'
        alias composer='php -d memory_limit=1G /usr/local/opt/composer/libexec/composer.phar'
        alias HTTPD='sudo apachectl'
        alias MYSQL='mysql.server'
        alias sqlfix="cd $HOME/.vim/bundle/vim-sqlfix/       && $HOME/.vim/bundle/vim-themis/bin/themis tests/ -r --reporter dot"
        alias csfix=" cd $HOME/.vim/bundle/vim-php-cs-fixer/ && $HOME/.vim/bundle/vim-themis/bin/themis tests/ -r --reporter dot"
        #}}}
        # open {{{
        alias VNC='open    -a Chicken'
        alias BOOK='open   -a cooViewer'
        alias DIFF='open   -a FileMerge'
        alias FTP='open    -a FileZilla'
        alias FF='open     -a Firefox'
        alias IT='open     -a iTunes'
        alias KINDLE='open -a Kindle'
        alias LIBRE='open  -a LibreOffice'
        alias OFFICE='open -a LibreOffice'
        alias TT='open     -a "Night Owl"'
        alias YORU='open   -a "Night Owl"'
        alias MAIL='open   -a Thunderbird'
        alias TWI='open    -a TweetDeck'
        alias VPN='open    -a Tunnelblick'
        alias VB='open     -a VirtualBox'
        #}}}
        # export {{{
        export LSCOLORS=DxgxcxdxcxCxfxBxFxhxfx
        export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
        export VIM=$HOME
        if type rbenv >/dev/null 2>&1; then
            export RBENV_ROOT=/usr/local/bin
            eval "$(rbenv init -)";
        fi
        localPath=''
        #brew --prefix perl
        if [ -d /usr/local/opt/perl/bin ]; then
            localPath="/usr/local/opt/perl/bin:$localPath"
        fi
        #brew --prefix gnu-tar
        if [ -d /usr/local/opt/gnu-tar/libexec/gnubin ]; then
            localPath="/usr/local/opt/gnu-tar/libexec/gnubin:$localPath"
        fi
        #brew --prefix gnu-sed
        if [ -d /usr/local/opt/gnu-sed/libexec/gnubin ]; then
            localPath="/usr/local/opt/gnu-sed/libexec/gnubin:$localPath"
        fi
        #brew --prefix svn
        if [ -d /usr/local/opt/subversion/bin ]; then
            localPath="/usr/local/opt/subversion/bin:$localPath"
        fi
        #brew --prefix macvim-kaoriya
        if [ -d /usr/local/opt/macvim-kaoriya/MacVim.app/Contents/MacOS ]; then
            localPath="/usr/local/opt/macvim-kaoriya/MacVim.app/Contents/MacOS:$localPath"
        fi
        if [ -d /usr/local/heroku/bin ]; then
            localPath="/usr/local/heroku/bin:$localPath"
        fi
        #go applications
        if [ -d /srv/php_bot ]; then
            export GOPATH=/srv/php_bot
            localPath="$GOPATH/bin:$localPath"
        fi
        export PATH=$localPath$PATH
        export MYSQL_PS1="\d @\h> "
        #export MYSQL_PS1="\d @\h[\u] \n> "
        #}}}
        ;;
    linux*)
        # command {{{
        alias l='ls -AhX --color=auto'
        alias ls='ls -AhX --color=auto'
        alias sl='ls -AhX --color=auto'
        alias ll='ls -AhXl --color=auto'
        alias vi='vim'
        #}}}
        # export {{{
        export EDITOR=vim
        localPath=''
        if [ -d /usr/local/rbenv/bin ]; then
            localPath="/usr/local/rbenv/bin:$localPath"
        fi
        export PATH=$localPath$PATH
        if type rbenv >/dev/null 2>&1; then
            export RBENV_ROOT=/usr/local/rbenv
            eval "$(rbenv init -)";
        fi
        export MYSQL_PS1="\d> "
        #}}}
        ;;
    cygwin)
        # command {{{
        alias l='ls -Ak --color=auto'
        alias ls='ls -Ak --color=auto'
        alias sl='ls -Ak --color=auto'
        alias ll='ls -Akl --color=auto'
        alias vi="$HOME/src/vimStarter.sh"
        alias vim="$HOME/src/vimStarter.sh"
        alias gvim="$HOME/src/vimStarter.sh"
        #}}}
        # ssh-agent {{{
        if [ -f $HOME/.ssh/.ssh-agent ]; then
           . $HOME/.ssh/.ssh-agent > /dev/null
        fi
        if [ -z "$SSH_AGENT_PID" -o -z "`/usr/bin/ps -a|/usr/bin/egrep \"^[ ]+$SSH_AGENT_PID\"`" ]; then
           /usr/bin/ssh-agent > $HOME/.ssh/.ssh-agent
           . $HOME/.ssh/.ssh-agent > /dev/null
           ssh-add $HOME/.ssh/id_rsa
        fi
        #}}}
        ;;
esac
#}}}
