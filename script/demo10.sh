#!/bin/bash

# Learn how to use function in bash

function log() {
    # This fun send message to syslog
    local MESSAGE="$@"
    if [[ ${VERBOSE} = true ]]; then
        echo "${MESSAGE}"
    fi
    logger -t $0 "$MESSAGE"
}

function back_up(){
    # This function create a backup of file. Returns non-zero status on error.
    local FILE=${1}
    # Make sure the file exits
    if [[ -f "${FILE}" ]];then
        local BACK_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        logger "Backing up $FILE to $BACK_FILE"
        cp -p ${FILE} ${BACK_FILE}
        if [[ ${?} -ne 0 ]]; then
            echo "Backup File can't be created"
        fi
    else
        # If file dosn't exits
        return 1
    fi
}
readonly VERBOSE=true
log 'Log message 1'
log 'Log message 2'
back_up '/etc/passwd'
