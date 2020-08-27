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

readonly VERBOSE=true
log 'Hello!'
log 'Your name'
log 'Super su'
