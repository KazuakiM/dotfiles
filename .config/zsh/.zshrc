export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

#User specific environment and startup programs {{{
export LD_LIBRARY_PATH='/usr/local/lib'
export LANG=ja_JP.UTF-8
export LOCAL_PREFIX=/usr/local
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_LOG_HOME="$HOME/.log"
cd
clear
#}}}

#zsh {{{
# Vi mode
bindkey '^]'   vi-find-next-char
bindkey '^[^]' vi-find-prev-char

# 補完
autoload -Uz compinit && compinit
#autoload predict-on  && predict-on
autoload colors
setopt correct

#zstyle ':completion::complete:*' use-cache true
#zstyle ':completion:*:default' menu select=1
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*' list-colors "${LS_COLORS}"
#zstyle ':completion:*' insert-tab false
#}}}

#Common {{{
#shopt -s cdspell
alias cl='clear'
alias lc='clear'
alias cp='cp -i -p'
alias df='df -h'
alias diff='diff --color=always --ignore-all-space --ignore-blank-lines --ignore-space-change --ignore-tab-expansion --ignore-trailing-space --unified'
alias h='history'
alias mv='mv -i'
alias rm='rm -i'
alias tree='tree -af'
alias wget="wget --hsts-file=$XDG_LOG_HOME/wget/wget-hsts"
localPath=''
#}}}
#find {{{
findIgnore=''
findIgnore=${findIgnore}'    -type d -iname ".git"     -prune'
findIgnore=${findIgnore}' -o -type d -iname ".svn"     -prune'
findIgnore=${findIgnore}' -o -type d -iname "coverage" -prune'
findIgnore=${findIgnore}' -o -type f -iname "*.cache"  -prune'
findIgnore=${findIgnore}' -o -type f -iname "*.log"    -prune'
findIgnore=${findIgnore}' -o -type f -iname "*min.js"  -prune'
findIgnore=${findIgnore}' -o -type f -iname "*min.css" -prune'
alias FIND='find -L ./ '${findIgnore}' -o -type f -print0 | xargs -0 grep --color -i -I -n "$@"'
alias find='find -L'
#}}}
#htop {{{
if type htop >/dev/null 2>&1; then
    alias top='sudo htop'
fi
#}}}
#grep {{{
export GREP_OPTIONS='--color=auto -i -I'
export GREP_COLOR='mt=1;33'
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
export LESSHISTFILE="$XDG_LOG_HOME/less/lesshst"
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
#export PS1="\[\e[1;36m\]\u \$ \[\e[1;0m\]"
export PROMPT='%F{cyan}%n%f $ '
#}}}
#docker, tmux or screen {{{
if type docker >/dev/null 2>&1; then
    alias dcl="docker ps -a"
    alias dca="docker attach                           \"\$@\""
    alias dcr="docker run -d -i -t --privileged --name \"\$@\""
    alias dcs="docker start                            \"\$@\""
    alias dce="docker stop                             \"\$@\""
    alias drm="docker rm                               \"\$@\""
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
export MYSQL_HOME="$XDG_CONFIG_HOME/mysql/my.cnf"
export MYSQL_HISTFILE="$XDG_LOG_HOME/mysql/mysql_history"
#}}}
#Redis {{{
export REDISCLI_HISTFILE="$XDG_LOG_HOME/redis/rediscli_history"
#}}}
#PHP {{{
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export PHAN_ALLOW_XDEBUG=1
if [ -f $LOCAL_PREFIX/bin/composer.phar ]; then
    alias composer="php -d memory_limit=2G $LOCAL_PREFIX/bin/composer.phar"
else
    curl -sS https://getcomposer.org/installer | php -- --install-dir=$LOCAL_PREFIX/bin
fi
#}}}
#Ruby {{{
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
localPath="$GEM_SPEC_CACHE/bin:$localPath"
#}}}
#Python {{{
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
#}}}
#PlantUML {{{
export PLANTUML_LIMIT_SIZE=8192
#}}}
#Gradle {{{
export GRADLE_USER_HOME="$XDG_CONFIG_HOME/gradle"
#}}}
#GnuPG {{{
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
#}}}
#Docker {{{
export BUILDKIT_COLORS="run=123,20,245:error=yellow:cancel=blue:warning=white"
export DOCKER_STORAGE_OPTIONS=" --storage-opt dm.basesize=300G"
#}}}
#MPlayer {{{
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
#}}}
#readline {{{
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
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
        alias HTTPD='sudo apachectl'
        alias MYSQL='mysql.server'
        #}}}
        # export {{{
        export EDITOR=/usr/local/opt/macvim/MacVim.app/Contents/MacOS/vim
        export HOMEBREW_NO_ANALYTICS=1
        export LSCOLORS=DxgxcxdxcxCxfxBxFxhxfx
        export MYSQL_PS1="\d @\h> "
        #export MYSQL_PS1="\d @\h[\u] \n> "
        export TRAVIS_CONFIG_PATH="$XDG_CONFIG_HOME/travisci"
        export VAGRANT_HOME="$XDG_CACHE_HOME/vagrant/vagrant.d"
        export VIM=$HOME

        if [ -d $BREW_PREFIX/opt/macvim/bin ]; then
            alias vi=$BREW_PREFIX/opt/macvim/bin/gvim
        fi
        #rbenv
        if type rbenv >/dev/null 2>&1; then
            export RBENV_ROOT=$BREW_PREFIX/bin
            eval "$(rbenv init -)";
        fi
        #pyenv
        if type pyenv >/dev/null 2>&1; then
            export PYENV_ROOT=$BREW_PREFIX/bin
            eval "$(pyenv init -)";
        fi
        #direnv
        if type direnv >/dev/null 2>&1; then
            eval "$(direnv hook zsh)"
        fi

        ##brew --prefix perl
        #if [ -d $BREW_PREFIX/opt/perl/bin ]; then
        #    localPath="$BREW_PREFIX/opt/perl/bin:$localPath"
        #    #PERL_MM_OPT="INSTALL_BASE=$HOME/.lib/perl" cpan local::lib
        #    #eval "$(perl -I$HOME/.lib/perl -Mlocal::lib)";
        #fi

        #brew --prefix apr
        if [ -d $BREW_PREFIX/opt/apr/bin ]; then
            localPath="$BREW_PREFIX/opt/apr/bin:$localPath"
        fi
        #brew --prefix apr-util
        if [ -d $BREW_PREFIX/opt/apr-util/bin ]; then
            localPath="$BREW_PREFIX/opt/apr-util/bin:$localPath"
        fi
        #brew --prefix curl
        if [ -d $BREW_PREFIX/opt/curl/bin ]; then
            localPath="$BREW_PREFIX/opt/curl/bin:$localPath"
        fi
        #brew --prefix openjdk
        if [ -d $BREW_PREFIX/opt/openjdk@11/bin ]; then
            localPath="$BREW_PREFIX/opt/openjdk@11/bin:$localPath"
            export JAVA_HOME="$BREW_PREFIX/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home"
        fi
        #brew --prefix curl-openssl
        if [ -d $BREW_PREFIX/opt/curl-openssl/bin ]; then
            localPath="$BREW_PREFIX/opt/curl-openssl/bin:$localPath"
        fi
        #brew --prefix gnu-tar
        if [ -d $BREW_PREFIX/opt/gnu-tar/libexec/gnubin ]; then
            localPath="$BREW_PREFIX/opt/gnu-tar/libexec/gnubin:$localPath"
        fi
        #brew --prefix gnu-sed
        if [ -d $BREW_PREFIX/opt/gnu-sed/libexec/gnubin ]; then
            localPath="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$localPath"
        fi
        #brew --prefix go
        if [ -d $BREW_PREFIX/opt/go ]; then
            export GOROOT="$BREW_PREFIX/opt/go/libexec"
            export GO111MODULE="on"
            localPath="$GOROOT/bin:$localPath"

            if [ -d $HOME/go ]; then
                export GOPATH="$HOME/go"
                localPath="$GOPATH/bin:$localPath"
            fi

            #goenv
            if [ -d $HOME/.goenv ]; then
                export GOENV_ROOT="$HOME/.goenv"
                localPath="$GOENV_ROOT/bin:$localPath"
           fi
        fi
        #brew --prefix grep
        if [ -d $BREW_PREFIX/opt/grep/libexec/gnubin ]; then
            localPath="$BREW_PREFIX/opt/grep/libexec/gnubin:$localPath"
        fi
        #brew cask google-cloud-sdk
        if [ -d $BREW_PREFIX/Caskroom/google-cloud-sdk ]; then
            source "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
            source "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
        fi
        #brew --prefix icu4c
        if [ -d $BREW_PREFIX/opt/icu4c/bin ]; then
            localPath="$BREW_PREFIX/opt/icu4c/bin:$BREW_PREFIX/opt/icu4c/sbin:$localPath"
        fi
        #brew --prefix libpq
        if [ -d $BREW_PREFIX/opt/libpq/bin ]; then
            localPath="$BREW_PREFIX/opt/libpq/bin:$localPath"
        fi
        #brew --prefix libiconv
        if [ -d $BREW_PREFIX/opt/libiconv/bin ]; then
            localPath="$BREW_PREFIX/opt/libiconv/bin:$localPath"
        fi
        #brew --prefix libxml2
        if [ -d $BREW_PREFIX/opt/libxml2/bin ]; then
            localPath="$BREW_PREFIX/opt/libxml2/bin:$localPath"
        fi
        #brew --prefix ncurses
        if [ -d $BREW_PREFIX/opt/ncurses/bin ]; then
            localPath="$BREW_PREFIX/opt/ncurses/bin:$localPath"
        fi
        #brew --prefix nvm
        if [ -d $BREW_PREFIX/opt/nvm ]; then
            export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
            export NVM_DIR="$XDG_CONFIG_HOME/nvm"
            [ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && . "$BREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
            nvm use --delete-prefix v18.12.1 --silent
        fi
        #brew --prefix openldap
        if [ -d $BREW_PREFIX/opt/openldap/bin ]; then
            localPath="$BREW_PREFIX/opt/openldap/bin:$BREW_PREFIX/opt/openldap/sbin:$localPath"
        fi
        #brew --prefix openssl
        if [ -d $BREW_PREFIX/opt/openssl/bin ]; then
            localPath="$BREW_PREFIX/opt/openssl/bin:$localPath"
        fi
        #brew --prefix python3
        python3dir="$BREW_PREFIX/opt/python@3"
        if [ -d $python3dir/bin ]; then
            localPath="$python3dir/bin:$localPath"
            export PYTHON_DLL="$python3dir/Frameworks/Python.framework/Python"
        fi
        #brew --prefix sqlite
        if [ -d $BREW_PREFIX/opt/sqlite/bin ]; then
            localPath="$BREW_PREFIX/opt/sqlite/bin:$localPath"
        fi
        #brew --prefix tfenv
        #if [ -d $BREW_PREFIX/opt/tfenv/bin ]; then
        #    export TF_CLI_ARGS_plan=20
        #    export TF_CLI_ARGS_apply=20
        #fi
        #git diff-highlight
        if [ -d $BREW_PREFIX/share/git-core/contrib/diff-highlight ]; then
            localPath="$BREW_PREFIX/share/git-core/contrib/diff-highlight:$localPath"
        fi
        export PATH=$localPath$PATH
        if type goenv >/dev/null 2>&1; then
            eval "$(goenv init -)"
        fi

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
        gitPullVariable="$gitPullVariable echo 'homebrew' && cd $HOME && brew update && brew upgrade && brew cleanup && brew doctor && brew cask doctor;"
        gitPullVariable="$gitPullVariable cd;"
        alias UP=$gitPullVariable
        #}}}

        # Get the aliases and functions {{{
        source $XDG_CONFIG_HOME/zsh/zshrc.local
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
        ;;
esac
#}}}

typeset -U path cdpath fpath manpath

test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
