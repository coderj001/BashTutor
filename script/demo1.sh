#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the root user or not.

echo "Your system uid ${UID}"

# USER_NAME=$(id -un)
USER_NAME=`id -un`

echo "Your system username ${USER_NAME}"

if [[ "${UID}" -eq 0 ]]
then
    echo "Root User"
else
    echo "Non Root User"
fi
