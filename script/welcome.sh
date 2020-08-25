#!/bin/bash

greeting="Welcome"
user=$(whoami)
today=$(date +%A)

echo "$greeting ... $user !! How is your day($today)"
echo "Your Base Version $BASH_VERSION"
