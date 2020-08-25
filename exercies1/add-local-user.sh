#!/bin/bash

# Goal: The goal of this exercise is to create a shell script that adds users to the same Linux system as the script is executed on.

# Privileges check
if [[ "${UID}" -ne 0 ]]; then
    echo "Please run with sudo or as root"
    exit 1
fi

# Read input
read -p "Enter Your Username: " USER_NAME

while [[ "${#USER_NAME}" -ge 8 ]]; do
    read -p "Username must be less than 8 characters: " USER_NAME
done

read -p "Enter Your Full Name: " COMMENT

read -sp "Enter Your Temporay Password: " PASSWORD

# Create the account
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]; then
    echo "Account could not be created."
    exit 1
fi

# Set Password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]; then
    echo "The password could not ne set."
    exit 1
fi

# Force password change on first login
passwd -e ${USER_NAME}

# Display
echo
echo "username: "
echo "$USER_NAME"
echo "password: "
echo "$PASSWORD"
echo "hostname : "
echo "$HOSTNAME"

exit 0
