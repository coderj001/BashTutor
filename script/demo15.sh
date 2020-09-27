#!/bin/bash

# For debugger

# Debugging on
set -x
for i in {1..10};do
    echo $i
done
# Debugging off
set +x

for i in {a..z};do
    echo $i
done
