#!/bin/sh
#--------------------------------
# variable{{{
maxLoop=100
sumTotalTime=0
vimrcPath=$HOME/.vimrc
#}}}
# main {{{
for index in `seq 1 $maxLoop`
do
    /Applications/MacVim.app/Contents/MacOS/Vim --cmd "profile start /tmp/profile.txt" --cmd "profile file $vimrcPath" +q
    rowTotalTime=`cat /tmp/profile.txt |grep Total|awk '{print $3}'`
    sumTotalTime=`echo "scale=6;$sumTotalTime+$rowTotalTime"|bc`
done

echo "scale=6;$sumTotalTime/$maxLoop"|bc
#}}}
# finish {{{
exit 0
#}}}
