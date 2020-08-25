#!/bin/bash

read -p "Enter: " num

factorial=1

for (( i=1;i<=num;i++ ));do
    factorial=$(( $factorial*$i ))
done

echo "Factorial: $factorial"
