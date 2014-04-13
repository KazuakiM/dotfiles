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
serverStatus=`VBoxManage showvminfo ${serverName} | grep State | awk -F " " '{print $2}'`
case ${serverStatus} in
    'running')
        echo "\nServer name '${serverName}' is running."
        echo "Request next:\n\t1:non action\n\t2:pause VirtualBox"
        read runningNext
        case ${runningNext} in
            2)
                VBoxManage controlvm ${serverName} pause
                echo "\nServer name '${serverName}' is pause";;
            *)
                exit 0;;
        esac;;
    'paused')
        VBoxManage controlvm ${serverName} resume
        echo "\nServer name '${serverName}' is resume";;
    'powered') # powered is 'powered off'
        VBoxManage startvm ${serverName} --type=headless
        echo "\nServer name '${serverName}' is started";;
    *)
        echo "\nException:Server name '${serverName}', Server status '${serverStatus}'";;
esac

# Finish
exit 0
