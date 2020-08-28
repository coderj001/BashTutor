#!/bin/bash

# The script delete user

# Run as root
if [[ ${UID} -ne 0 ]]; then
   echo "Please run as sudo or root" >&2
   exit 1
fi

# Get the user
USER=$1

userdel ${USER}

# Check if delete or not
if [[ ${?} -ne 0  ]]; then
   echo "User ${USER} has not been deleted." >&2
   exit 1
fi

echo "${USER} is deleted."
exit 0
