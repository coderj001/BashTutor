#!/bin/bash

# FD - File Descriptor
# 0 - STDIN
# 1 - STDOUT
# 2 - STDERROR

if [[ ${UID} -ne 0 ]];then
    echo "Script has limitation as you are not root."
    echo "Preffer: sudo ${0} [FILE NAME]"
fi

if [[ $# -lt 1 ]];then
    echo "Please provie file name: $0 [FILE NAME]"
    exit 1
fi

VAR=$(find / -type f -name $1 2>/dev/null)

if [[ $VAR == "" ]];then
    echo "File not found."
    exit 1
else
    echo $VAR
fi
