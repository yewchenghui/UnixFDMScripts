#!/bin/bash

### PURPOSE ###
#
# 1. To produce a file list of files with date entries
# not matching the directory path.
#

### FUNCTIONS ###

### MAIN ###

# Check for files in folders that start with ./2
for file in $(find -type f | grep "^./2")
do
    year=$(head -n 1 $file | cut -d "-" -f 1)
    month=$(head -n 1 $file | cut -d "-" -f 2)
    day=$(head -n 1 $file | cut -d "-" -f 3)
    directory=$(echo ${file} | cut -d "/" -f 2-4 | tr "/" "-")

    # if directory path date is not the same as the
    # date entry within the file -> print out
    if [ "$directory" != "$year-$month-$day" ]
        then
        echo "${file}"
    fi
done
echo -e "\e[7mcheckData completed. \e[0m"
