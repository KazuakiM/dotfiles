# .bashrc
# Get the aliases and functions {{{
if [ -f ~/.bashrc.win ]; then
    . ~/.bashrc.win
elif [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
#}}}
#User specific environment and startup programs {{{
export LD_LIBRARY_PATH='/usr/local/lib'
export LANG=ja_JP.UTF-8
export LOCAL_PREFIX=/usr/local
export XDG_CONFIG_HOME="$HOME/.config"
cd
clear
#}}}
#Common {{{
shopt -s cdspell
export HISTFILE="$HOME/.log/bash/bash_history"
alias cl='clear'
alias lc='clear'
alias cp='cp -i -p'
alias df='df -h'
alias h='history'
alias mv='mv -i'
alias rm='rm -i'
alias tree='tree -af'
alias wget="wget --hsts-file=$HOME/.log/wget/wget-hsts"
localPath=''
#}}}
#find {{{
findIgnore=''
findIgnore=${findIgnore}'    -type d -iname ".git"     -prune'
findIgnore=${findIgnore}' -o -type d -iname ".svn"     -prune'
findIgnore=${findIgnore}' -o -type f -iname "*.log"    -prune'
findIgnore=${findIgnore}' -o -type f -iname "*min.js"  -prune'
findIgnore=${findIgnore}' -o -type f -iname "*min.css" -prune'
alias FIND='find ./ '${findIgnore}' -o -type f -print0 | xargs -0 grep --color -i -I -n "$@"'
#}}}
#diff {{{
if type colordiff >/dev/null 2>&1; then
    alias diff='colordiff -u'
else
    alias diff='diff      -u'
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
export LESS='--ignore-case --RAW-CONTROL-CHARS --no-init'
export LESSHISTFILE="$HOME/.log/less/lesshst"
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
#docker, tmux or screen {{{
if type docker >/dev/null 2>&1; then
    alias dcl="docker ps -a"
    alias dca="docker attach                           \"\$@\""
    alias dcr="docker run -d -i -t --privileged --name \"\$@\""
    alias dcs="docker start                            \"\$@\""
    alias dce="docker stop                             \"\$@\""
fi

if type tmux >/dev/null 2>&1; then
    alias tm="sh $HOME/work/dotfiles/src/tmuxStarter.sh"
    alias tml="tmux -u -f $XDG_CONFIG_HOME/tmux/tmux.conf list-sessions"
    alias tma="tmux -u -f $XDG_CONFIG_HOME/tmux/tmux.conf attach -d       \"\$@\""
    alias tmd="tmux -u -f $XDG_CONFIG_HOME/tmux/tmux.conf detach -s       \"\$@\""
    alias tmk="tmux -u -f $XDG_CONFIG_HOME/tmux/tmux.conf kill-session -t \"\$@\""
fi
if type screen >/dev/null 2>&1; then
    alias sc='screen'
    alias scl='screen -ls'
    alias sca='screen -r "$@"'
    alias scd='screen -d "$@"'
    export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
fi
#}}}
#Subversion {{{
export SUBVERSION_HOME="$XDG_CONFIG_HOME/subversion"
#}}}
#Mercurial {{{
export HGRCPATH="$XDG_CONFIG_HOME/hg/hgrc"
#}}}
#Atom {{{
export ATOM_DEV_RESOURCE_PATH="$XDG_CONFIG_HOME/atom/resource"
export ATOM_HOME="$XDG_CONFIG_HOME/atom/home"
#}}}
#MySQL {{{
export MYSQL_HISTFILE="$HOME/.log/mysql/mysql_history"
#}}}
#Redis {{{
export REDISCLI_HISTFILE="$HOME/.log/redis/rediscli_history"
#}}}
#Java {{{
export JAVA_HOME="$XDG_CONFIG_HOME/java"
#}}}
#PHP {{{
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
if [ -d $XDG_CONFIG_HOME/composer/vendor/bin ]; then
    localPath="$XDG_CONFIG_HOME/composer/vendor/bin:$localPath"
fi
if [ -f $LOCAL_PREFIX/bin/composer.phar ]; then
    alias composer="php -d memory_limit=1G $LOCAL_PREFIX/bin/composer.phar"
else
    curl -sS https://getcomposer.org/installer | php -- --install-dir=$LOCAL_PREFIX/bin
fi
#}}}
#node.js {{{
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
if [ -d $XDG_CONFIG_HOME/npm/bin ]; then
    localPath="$XDG_CONFIG_HOME/npm/bin:$localPath"
fi
#}}}
#Ruby {{{
export GEM_HOME="$HOME/.cache/gem"
#}}}
#Go {{{
#export GOROOT
#export PATH="$GOROOT/bin:$PATH"
export GOPATH='/srv/go'
#}}}
#OS Type {{{
case "${OSTYPE}" in
    darwin*)
        export BREW_PREFIX=`brew --prefix`
        #command {{{
        alias l='ls  -AGh'
        alias ll='ls -AGhl'
        alias ls='ls -AGh'
        alias sl='ls -AGh'
        alias lingr="sh $HOME/work/dotfiles/src/lingrStarter.sh"
        alias HTTPD='sudo apachectl'
        alias MYSQL='mysql.server'
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
        alias TT='open     -a TweetDeck'
        alias TWI='open    -a TweetDeck'
        alias VPN='open    -a Tunnelblick'
        alias VB='open     -a VirtualBox'
        #}}}
        # export {{{
        export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
        export HOMEBREW_NO_ANALYTICS=1
        export LSCOLORS=DxgxcxdxcxCxfxBxFxhxfx
        export MYSQL_PS1="\d @\h> "
        #export MYSQL_PS1="\d @\h[\u] \n> "
        export TRAVIS_CONFIG_PATH="$XDG_CONFIG_HOME/travisci"
        export VAGRANT_HOME="$HOME/.cache/vagrant/vagrant.d"
        export VIM=$HOME

        if [ -d $BREW_PREFIX/opt/macvim-kaoriya/bin ]; then
            alias vi=$BREW_PREFIX/opt/macvim-kaoriya/bin/gvim
        fi
        if type rbenv >/dev/null 2>&1; then
            export RBENV_ROOT=$BREW_PREFIX/bin
            eval "$(rbenv init -)";
        fi

        #TODO: error
        #brew --prefix bash-completion2
        #if [ -d $BREW_PREFIX/opt/bash-completion2 ]; then
        #    $BREW_PREFIX/opt/bash-completion2/share/bash-completion/bash_completion
        #fi

        ##brew --prefix perl
        #if [ -d $BREW_PREFIX/opt/perl/bin ]; then
        #    localPath="$BREW_PREFIX/opt/perl/bin:$localPath"
        #    #PERL_MM_OPT="INSTALL_BASE=$HOME/.lib/perl" cpan local::lib
        #    #eval "$(perl -I$HOME/.lib/perl -Mlocal::lib)";
        #fi
        #brew --prefix gnu-tar
        if [ -d $BREW_PREFIX/opt/gnu-tar/libexec/gnubin ]; then
            localPath="$BREW_PREFIX/opt/gnu-tar/libexec/gnubin:$localPath"
        fi
        #brew --prefix gnu-sed
        if [ -d $BREW_PREFIX/opt/gnu-sed/libexec/gnubin ]; then
            localPath="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$localPath"
        fi
        ##brew --prefix ruby
        #if [ -d $BREW_PREFIX/opt/ruby/bin ]; then
        #    localPath="$BREW_PREFIX/opt/ruby/bin:$localPath"
        #fi
        ##brew --prefix svn
        #if [ -d $BREW_PREFIX/opt/subversion/bin ]; then
        #    localPath="$BREW_PREFIX/opt/subversion/bin:$localPath"
        #fi
        #brew --prefix macvim-kaoriya
        if [ -d $BREW_PREFIX/opt/macvim-kaoriya/MacVim.app/Contents/MacOS ]; then
            localPath="$BREW_PREFIX/opt/macvim-kaoriya/MacVim.app/Contents/MacOS:$localPath"
        fi
        #git diff-highlight
        if [ -d $BREW_PREFIX/share/git-core/contrib/diff-highlight ]; then
            localPath="$BREW_PREFIX/share/git-core/contrib/diff-highlight:$localPath"
        fi
        #brew --prefix go
        if [ -d $BREW_PREFIX/opt/go ]; then
            export GOROOT="$BREW_PREFIX/opt/go/libexec"
            localPath="$GOROOT/bin:$localPath"
        fi
        ##heroku
        #if [ -d $BREW_PREFIX/heroku/bin ]; then
        #    localPath="$BREW_PREFIX/heroku/bin:$localPath"
        #fi
        ##go applications
        #if [ -d /srv/php_bot ]; then
        #    export GOPATH=/srv/php_bot
        #    localPath="$GOPATH/bin:$localPath"
        #fi
        export PATH=$localPath$PATH

        # ssh-agent {{{
        if [ -z "$SSH_AUTH_SOCK" ] ; then
            eval `ssh-agent`
            ssh-add -K $HOME/.ssh/id_rsa.pub
        fi
        #}}}

        ## git pull {{{
        gitPullVariable=''
        gitPullVariable="$gitPullVariable echo 'dotfiles' && cd $HOME/work/dotfiles/ && git fetch --prune && git pull;"
        gitPullVariable="$gitPullVariable echo 'composer' && cd $HOME && composer self-update && composer global update;"
        gitPullVariable="$gitPullVariable echo 'npm'      && cd $HOME && npm i -g npm && npm update -g;"
        gitPullVariable="$gitPullVariable echo 'homebrew' && cd $HOME && brew update && brew upgrade && brew cleanup && brew cask cleanup && brew doctor && brew cask doctor;"
        gitPullVariable="$gitPullVariable cd;"
        alias UP=$gitPullVariable
        #}}}
        #}}}
        ;;
    linux*)
        # command {{{
        alias l='ls  -AhX  --color=auto'
        alias ls='ls -AhX  --color=auto'
        alias sl='ls -AhX  --color=auto'
        alias ll='ls -AhXl --color=auto'
        alias vi='vim'
        #}}}
        # export {{{
        export EDITOR=vim
        export MYSQL_PS1="\d> "
        if [ -d $LOCAL_PREFIX/rbenv/bin ]; then
            localPath="$LOCAL_PREFIX/rbenv/bin:$localPath"
        fi
        #git diff-highlight
        if [ -d /usr/share/doc/git/contrib/diff-highlight ]; then
            localPath="/usr/share/doc/git/contrib/diff-highlight:$localPath"
        fi
        export PATH=$localPath$PATH
        if type rbenv >/dev/null 2>&1; then
            export RBENV_ROOT=$LOCAL_PREFIX/rbenv
            eval "$(rbenv init -)";
        fi
        #}}}
        # PHP7.1 {{{
        if [ -d /opt/remi/php71 ]; then
            source /opt/remi/php71/enable
        fi
        #}}}
        ;;
    cygwin)
        # command {{{
        alias l='ls  -Ak  --color=auto'
        alias ls='ls -Ak  --color=auto'
        alias sl='ls -Ak  --color=auto'
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
