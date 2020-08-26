#!/bin/bash

# This script demostrates I/O redirections.
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN to a program
read LINE < ${FILE}
echo "LINE Varible contain(s): $LINE"

# Redirect STDOUT to a file, overwriting it
head -n3 /etc/passwd > ${FILE}
echo
echo "FILE contain(s): $FILE"
cat $FILE

# Redirect STDOUT to a file, appading to the file
for i in {1..100};do
    echo "${RANDOM}${RANDOM}${RANDOM}" >> ${FILE}
    echo "${RANDOM}${RANDOM}${RANDOM}" >> ${FILE}
    echo "${RANDOM}${RANDOM}${RANDOM}" >> ${FILE}
done
