#!/bin/sh
#--------------------------------
# launchctl.sh
#
# @author kazuakiM
#--------------------------------
# Application Variable {{{
helpMessage="\n\n\t\tLaunch Memcached/Redis shell help\nParam1(required): start,stop,status\n"
#}}}
# Application Argument {{{
if [ $# -eq 1 ]; then
    action=$1;
else
    echo ${helpMessage}
    exit 1
fi
#}}}
case ${action} in
    'start')
        launchctl load $BREW_PREFIX/opt/memcached/homebrew.mxcl.memcached.plist
        launchctl load $BREW_PREFIX/opt/redis/homebrew.mxcl.redis.plist
        ;;
    'stop')
        launchctl unload $BREW_PREFIX/opt/memcached/homebrew.mxcl.memcached.plist
        launchctl unload $BREW_PREFIX/opt/redis/homebrew.mxcl.redis.plist
        ;;
    'status')
        ps aux|grep opt/memcached|grep -v grep
        ps aux|grep opt/redis|grep redis|grep -v grep
        ;;
    *)
        echo ${helpMessage}
        ;;
esac

# Finish
exit 0
