# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
#{{{
if [ -d $HOME/.anyenv ]; then
    export PATH=$HOME/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
fi
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
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
alias grep='grep --color=auto'
#}}}
# OS Type
#{{{
case "${OSTYPE}" in
    darwin*)
        alias l='ls -Ga'
        alias ls='ls -Ga'
        alias sl='ls -Ga'
        alias ll='ls -Gla'
        alias vi='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias vim='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        alias FF='open -a firefox'
        alias GG='open -a firefox'
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
        alias VB='open -a virtualbox'
        alias BV='open -a virtualbox'
        alias VM='open -a virtualbox'
        alias MV='open -a virtualbox'
        export LSCOLORS=DxgxcxdxcxCxfxBxFxhxfx
        ;;
    linux*)
        alias l='ls --color=auto'
        alias ls='ls -a --color=auto'
        alias sl='ls -a --color=auto'
        alias ll='ls -a -l --color=auto'
        alias vi='vim'
        # export LS_COLORS
        #{{{
        export LS_COLORS='rs=0:di=01;33:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01;35:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.tbz=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:'
        #}}}
        ;;
esac
#}}}
