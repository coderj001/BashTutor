#!/bin/bash

read -p "Enter Username to create: " USER_NAME
read -p "Enter the name of the person who this account for: " COMMENT
read -sp "Enter the password: " PASSWD

useradd -c "${COMMENT}" -m ${USER_NAME}
echo ${PASSWD} | passwd --stdin ${USER_NAME}

passwd -e ${USER_NAME}
