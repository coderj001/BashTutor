#!/bin/bash

SERVER_FILE="servers"

if [[ ! -e "${SERVER_FILE}" ]]
then
  echo "Cannot open ${SERVER_FILE}." >&2
  exit 1
fi
for SERVER in $(cat servers );
do
  ssh ${SERVER} hostname;
  ssh ${SERVER} uptime;
  ssh ${SERVER} 'ps -ef';
done >> log
