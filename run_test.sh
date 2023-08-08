#!/bin/bash

# Removing the result.txt file if it exists to start fresh
[ -e result.txt ] && rm result.txt

# Running the python script with inputs from 1 to 100
for i in {1..100}
do
   python3 cuckoo_hash.py $i
done
