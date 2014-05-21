# .bash_profile
# Get the aliases and functions
if [ -f ~/.bash_profile.local ]; then
    . ~/.bash_profile.local
fi
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
#{{{
if [ -d $HOME/.anyenv ]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi
if [ -d /usr/local/opt/perl518 ]; then
    export PATH="/usr/local/opt/perl518/bin:$PATH"
fi
if [ -d /usr/local/opt/gnu-tar ]; then
    export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
fi
if [ -d /usr/local/heroku ]; then
    export PATH="/usr/local/heroku/bin:$PATH"
fi
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export LANG=ja_JP.UTF-8
cd
clear
#}}}
# Common
#{{{
alias rm='rm -i'
alias cp='cp -i -p'
alias mv='mv -i'
alias h='history'
alias cl='clear'
alias lc='clear'
alias df='df -h'
if type python >/dev/null 2>&1; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi
export GREP_OPTIONS='--color=auto -I'
export GREP_COLOR='1;33'
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
# Linux Desktop Hacks Custopm prompt
#{{{
function prompt_command
{
    # Save current cursor position
    tput sc
    # backwash is where to set cursor (upper right side)
    # to write CWD [col=screen width - (CWD +2) for brackets]
    let backwash=$(tput cols)-$(echo $(pwd)@$USER | wc -m | tr -d ' ')-2
    #position cursor at Y=0, X=calculated columr (see above)
    tput cup 0 ${backwash}
    #Wrap path in brackets
    tput setaf 4
    echo -n "["
    # show path
    tput setaf 6
    echo -n "$(pwd)"
    tput setaf 8
    echo -n "@$USER"
    #show closing bracket
    tput setaf 4
    echo -n "]"
    #return cursor to saved position
    tput rc
}
# Set prompt via function above
PROMPT_COMMAND=prompt_command
#}}}
# PS1(primary prompt string)
#{{{
lc='\[\e[1;'
ps1StartCyan=${lc}36m
ps1EndNormal=${lc}0m
export PS1="${ps1StartCyan}\]\h \$ ${ps1EndNormal}\]"
#}}}
# OS Type
#{{{
case "${OSTYPE}" in
    darwin*)
        alias l='ls -aGh'
        alias ls='ls -aGh'
        alias sl='ls -aGh'
        alias ll='ls -aGhl'
        alias vi='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias vim='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias top='htop'
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
        alias LINGR='open -a LimeChat;nohup ruby $HOME/.vim/bundle/lingr-irc/lig.rb > /dev/null 2>&1 &'
        alias WIRE='/usr/local/bin/wireshark'
        alias WIRESHARK='/usr/local/bin/wireshark'
        export LSCOLORS=DxgxcxdxcxCxfxBxFxhxfx
        export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
        ;;
    linux*)
        alias l='ls -ahX --color=auto'
        alias ls='ls -ahX --color=auto'
        alias sl='ls -ahX --color=auto'
        alias ll='ls -ahXl --color=auto'
        alias vi='vim'
        # export LS_COLORS
        #{{{
        export LS_COLORS='rs=0:di=01;33:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01;35:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.tbz=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:'
        #}}}
        ;;
esac
#}}}
