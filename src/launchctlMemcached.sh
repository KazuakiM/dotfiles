#!/bin/sh
#--------------------------------
# launchctlMemcached.sh
#
# @author kazuakiM
#--------------------------------
# Application Variable {{{
helpMessage="\n\n\t\tLaunch memcached shell help\nParam1(required): start,stop,status\n"
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
        ;;
    'stop')
        launchctl unload $BREW_PREFIX/opt/memcached/homebrew.mxcl.memcached.plist
        ;;
    'status')
        ps aux|grep opt/memcached|grep -v grep
        ;;
    *)
        echo ${helpMessage}
        ;;
esac

# Finish
exit 0
