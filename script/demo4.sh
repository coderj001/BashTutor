#!/bin/bash

PASSWORD=${RANDOM}
echo "${PASSWORD}"


PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"


PASSWORD=$( date +%s )
echo "${PASSWORD}"


PASSWORD=$( date +%s%N )
echo "${PASSWORD}"


PASSWORD=$( date +%s%N | sha256sum | head -c18 )
echo "${PASSWORD}"


PASSWORD=$( date +%s%N${RANDOM}${RANDOM}${RANDOM} | sha256sum | head -c32 )
echo "${PASSWORD}"


SPECIAL_CHARACTER=$( echo "!@#$%^&*()_-+={}[]\|" | fold -w1 | shuf | head -c1)
PASSWORD=$( date +%s%N${RANDOM}${RANDOM}${RANDOM}${SPECIAL_CHARACTER} | sha256sum | head -c64 )
echo "${PASSWORD}"
