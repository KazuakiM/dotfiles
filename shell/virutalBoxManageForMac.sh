#!/bin/sh
#--------------------------------
# Virtual Box management shell
#
# @author kazuakiM
#--------------------------------
# Application Variable
helpMessage="\n\n\t\tVirtual Box management shell help\n"

# Application Argument
if [ $# -eq 1 ]; then
    serverName=$1;
else
    echo "${helpMessage}Param1(required): Server name\n"
    exit 1
fi

# Server status check & start
VBoxManage list vms | grep '"'${serverName}'"' >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "\nServer name '${serverName}' is not exists."
    exit 1
fi
VBoxManage list runningvms | grep '"'${serverName}'"' >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "\nServer name '${serverName}' is running."
    exit 0
fi
serverStatus=`VBoxManage showvminfo ${serverName} | grep State | awk -F " " '{print $2}'`
case ${serverStatus} in
    'powered') # powered is 'powered off'
        VBoxManage startvm ${serverName} --type=headless;
        echo "Server name '${serverName}' is started";;
    *)
        echo "Exception:Server name '${serverName}', Server status '${serverStatus}'";;
esac

# Finish
exit 0
