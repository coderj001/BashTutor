#!/bin/bash

read -p "Enter: " num

factorial=1
counter=$num

while [[ $counter -gt 0 ]]; do
    factorial=$(( $factorial*$counter ))
    counter=$(( $counter -1 ))
done

echo "Factorial: ${factorial}"
