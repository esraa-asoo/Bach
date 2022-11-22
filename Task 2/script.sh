#!/usr/bin/env bash

source ./library.sh

while [ ! -f ~/bouns.txt ]
do 
sleep 2
echo "File is not found..."
done
echo "File exist..."
