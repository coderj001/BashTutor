#!/bin/bash

# echo "Parameter: $1"
# echo "Parameter: $2"
# echo "Parameter: $3"
# echo


while [[ "${#}" -gt 0 ]]; do
    echo "Number of Parameter(s): $#"
    for i in $*;do
        echo "Parameter: $i"
    done
    shift
done
