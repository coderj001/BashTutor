#!/bin/bash

echo "Your script name: ${0}"

echo "You used '$(dirname ${0})' as path to the '$(basename ${0})' script."

NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."

if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]; then
    echo "Usage: ${0} USER_NAME [USER_NAME]..."
    exit 1
fi
