#!/bin/sh
#--------------------------------
# Bash 256 color check
#
# @author soramugi-San
# @url    http://qiita.com/soramugi/items/ab82f30a5906851472cc
#--------------------------------
echo '
256色
前: 38;05;色番号
背: 48;05;色番号'
count=0
max=15
for index in {0..255} ; do
    printf "\x1b[38;05;${index}m ${index}\t"
    if [ $count -lt $max ]; then
        count=$((count+1))
    else
        echo ''
        count=0
    fi
done
echo ''
