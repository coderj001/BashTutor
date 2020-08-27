#!/bin/bash

# This script generates random password for user.
# This user can set the password length with -l and add special character with -s.
# Verbose mode can be enable with -v

# set default password length
LENGTH=32

function usage() {
   echo """
   Usage : ${0} [-vs] [-l LENGTH]
   Generate a random password.
        -l LENGTH   Specify the password length.
        -s          Append a special character(s) to the password.
        -v          Incress verbosity.
        -h          To get help.
   """
}

function log() {
    local MESSAGE=$@
    if [[ $VERBOSE = 'true' ]]; then
       echo "${MESSAGE}"
    fi
}

while getopts vl:sh OPTION
do
    case ${OPTION} in
        v)
            VERBOSE=true
            log "Verbose mode on."
            ;;
        l)
            LENGTH="${OPTARG}"
            ;;
        s)
            USE_SPEACEL_CHARACTER='true'
            ;;
        h)
            usage
            exit 1
            ;;
        ?)
            echo "Invalid Option. Use: ${0} -h" >&2
            exit 1
            ;;
    esac
done

log "Generating a password"

PASSWORD=$( date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH} )

# Append special character if requested.
if [[ "${USE_SPEACEL_CHARACTER}" = 'true' ]]; then
   log 'Selelecting random special character.'
   SPECIAL_CHARACTER=$( echo "!@#$%^&*()--+=[]{}" | fold -w1 | shuf | head -c1)
   PASSWORD=${PASSWORD}${SPECIAL_CHARACTER}
fi

if [[ $? -ne 0 ]]; then
   log 'Password can not be generated.'
   exit 1
fi

log 'Done'
log 'Here is the password.'

echo "Password: ${PASSWORD}"
