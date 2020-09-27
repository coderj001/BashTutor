#!/bin/bash

# Read File as Array

declare -a passarray

mapfile passarray < "$1"

echo ${passwd[@]}
