#!/bin/bash

# Make sure the script is being executed with superuser privileges.

# If the user doesn't supply at least one argument, then give them help.

# The first parameter is the user name.

# The rest of the parameters are for the account comments.

# Generate a password.

# Create the user with the password.

# Check to see if the useradd command succeeded.

# Set the password.

# Check to see if the passwd command succeeded.

# Force password change on first login.

# Display the username, password, and the host where the user was created.

# Check Privileges check
if [[ ${UID} -ne 0 ]];then
    echo "Please run with sudo or as root"
    exit 1
fi

#Get Args
if [[ $# -le 0 ]];then
    echo "Usage: ${0} USER_NAME [USER_NAME]..."
    exit 1
fi

echo "Creating account(s).."
for x in $@;do
    PASSWORD=$( date +%s%N${RANDOM}${RANDOM} | sha1sum | head -c32 )
    useradd -m ${x}
    if [[ ${?} -ne 0 ]];then
        echo "Account could not be created."
        exit 1
    fi
    echo $PASSWORD | passwd --stdin $x
    if [[ ${?} -ne 0 ]];then
        echo "Password could not be set."
        exit 1
    fi
    passwd -e $x
    echo "$x : $PASSWORD"
done
