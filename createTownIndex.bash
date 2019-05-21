#!/bin/bash

### PURPOSE ###
# 1. To create a file index called townFileIndex.
# Creates the townFileIndex line by line, followed
# by sorting the file at the end.
#

### MAIN ###

# Search for files in folders start with ./2
for file in $(find -type f | grep "^./2")
do
    town=$(head -n3 $file | tail -n1)
    echo "$town:${file}" >> townFileIndex
done

# Sort the list according to the Town name.
sort -fo townFileIndex townFileIndex
echo -e "\e[7m townFileIndex completed. \e[0m"