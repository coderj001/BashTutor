#!/bin/bash

# This script demostrates the case statement.

# if [[ "${1}" = 'start' ]]; then
#    echo "Starting.."
# elif [[ "${1}" = 'stop' ]]; then
#    echo "Stopping..."
# elif [[ "${1}" = 'status' ]]; then
#    echo "Status: "
# else
#    echo "Supply a valid options" >&2
#    exit 1
# fi

# case "${1}" in
#     start|--start)
#    echo "Starting.."
#     ;;
#     stop|--stop)
#    echo "Stopping..."
#     ;;
#     status|state|--status|--state)
#    echo "Status: "
#     ;;
#     *)
#    echo "Supply a valid options"
#    exit 1
#     ;;
# esac



case "${1}" in
    start|--start) echo "Starting.." ;;
    stop|--stop) echo "Stopping..." ;;
    status|state|--status|--state) echo "Status: " ;;
    *)
   echo "Supply a valid options"
   exit 1
    ;;
esac
