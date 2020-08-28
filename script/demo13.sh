#!/bin/bash

IP_ADDRESS=$(ss -t | awk '{print $5}' | cut -d ':' -f1)
PORT=$(ss -t | awk '{print $5}' | cut -d ':' -f2)

echo "${PORT}:::${IP_ADDRESS}"
