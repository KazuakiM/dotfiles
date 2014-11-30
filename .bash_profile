# .bash_profile
# Get the aliases and functions
if [ -f ~/.bash_profile.win ]; then
    . ~/.bash_profile.win
elif [ -f ~/.bash_profile.local ]; then
    . ~/.bash_profile.local
fi
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

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
export XMLLINT_INDENT='    '
#}}}
# Less {{{
export LESS='-R'
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
#Linux Desktop Hacks Custopm prompt {{{
function prompt_command
{
    tput sc
    let backwash=$(tput cols)-$(echo $(pwd)@$USER | wc -m | tr -d ' ')-2
    tput cup 0 ${backwash}
    tput setaf 4
    echo -n "["
    tput setaf 6
    echo -n "$(pwd)"
    tput setaf 8
    echo -n "@$USER"
    tput setaf 4
    echo -n "]"
    tput rc
}
PROMPT_COMMAND=prompt_command
#}}}
#PS1(primary prompt string) {{{
lc='\[\e[1;'
ps1StartCyan=${lc}36m
ps1EndNormal=${lc}0m
export PS1="${ps1StartCyan}\]\h \$ ${ps1EndNormal}\]"
export MYSQL_PS1="\d @\h \n> "
#export MYSQL_PS1="\d @\h[\u] \n> "
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
        ;;
    linux*)
        alias l='ls -AhX --color=auto'
        alias ls='ls -AhX --color=auto'
        alias sl='ls -AhX --color=auto'
        alias ll='ls -AhXl --color=auto'
        alias vi='vim'
        export EDITOR=vim
        # export LS_COLORS {{{
        export LS_COLORS='rs=0:di=01;33:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01;35:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.tbz=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:'
        #}}}
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
