#!/bin/bash

# Read From File

# while IFS= read -r LINE; do
#     echo "$LINE" | sed 's/:/ /g'
# done < "$1"


while IFS=: read -r user pass uid gid gecos home shell; do
    echo "$user $shell"
done < "$1"
