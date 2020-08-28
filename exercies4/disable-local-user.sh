#!/bin/bash

# Display the usage and exit.

# Make sure the script is being executed with superuser privileges.

# Parse the options.

# Remove the options while leaving the remaining arguments.

# If the user doesn't supply at least one argument, give them help.

# Loop through all the usernames supplied as arguments.

# Make sure the UID of the account is at least 1000.

# Create an archive if requested to do so.

# Make sure the ARCHIVE\_DIR directory exists.

# Archive the user's home directory and move it into the ARCHIVE\_DIR

# Delete the user.

# Check to see if the userdel command succeeded.

# We don't want to tell the user that an account was deleted when it hasn't been.

# Check to see if the chage command succeeded.

# We don't want to tell the user that an account was disabled when it hasn't been.d


# Check for root privileges
if [[ ${UID} -ne 0 ]]; then
   echo "Please run as sudo or root" >&2
   exit 1
fi

readonly ARCHIVE_DIR="/archive"

# Helper
function helper() {
   echo """
   Usage : ${0} [-dra] [USERNAME] ...
   Disable a local linux user account.
        -d          Delete user account instead of disabling them.
        -r          Remove home directory associated with the account.
        -a          Archive user home directory.
        -h          To get help.
   """
}

# Usage
function usage() {
   echo """
   Invalid Option(s) : ${0} -h [For help]
   """ >&2
   exit 1
}
# Parse the options
while getopts darh OPTION
do
    case ${OPTION} in
        d) DELETE_USER="true" ;;
        r) REMOVE_OPTION='-r' ;;
        a) ARCHIVE="true" ;;
        h) helper ;;
        ?) usage ;;
    esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# If the user don't supply at least one argument, help
if [[ $# -lt 1 ]]; then
   usage
fi

for USERNAME in $@;do
    echo "Processing user: ${USERNAME}"
    USERID=$(id -u ${USERNAME})
    if [[ $USERID -lt 1000 ]]; then
        echo "Refusing to remove the ${USERNAME} with account with UID $USERID." >&2
        exit 1
    fi

    # Archive
    if [[ "${ARCHIVE}" = "true"  ]]; then
        if [[ ! -d ${ARCHIVE_DIR} ]]; then
            echo "Creating $ARCHIVE_DIR directory"
            mkdir -p ${ARCHIVE_DIR}
            if [[ $? -ne 0 ]]; then
                echo "The ${ARCHIVE_DIR} could not be created." >&2
                exit 1
            fi
        fi
    fi
    # Sure ARCHIVE_DIR exist
    HOME_DIR="/home/${USERNAME}"
    ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
    if [[ -d $HOME_DIR ]]; then
        echo "archiving $HOME_DIR to $ARCHIVE_FILE"
        tar -zcf $ARCHIVE_FILE $HOME_DIR &> /dev/null
        if [[ ${?} -ne 0 ]]; then
            echo "Could not be created $ARCHIVE_FILE" >&2
            exit 1
        fi
    else
        echo "$HOME_DIR does not exits or is not a directory." >&2
        exit 1
    fi

    # Delete user
    if [[ "$DELETE_USER" = "true" ]]; then
        userdel ${REMOVE_OPTION} ${USERNAME}
        if [[ $? -ne 0 ]]; then
            echo "Conld not delete $USERNAME" >&2
            exit 1
        fi
        if [[ $REMOVE_OPTION = "-r" ]]; then
            echo "The Account and Directory $USERNAME deleted."
        else
            echo "The Account $USERNAME deleted."
        fi
    else
        chage -E 0 ${USERNAME}
        if [[ $? -ne 0 ]]; then
            echo "The account $USERNAME was NOT disabled." >&2
            exit 1
        fi
        echo "The Account $USERNAME disabled."
    fi
done

exit 0
