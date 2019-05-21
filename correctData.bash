#!/bin/bash

### PURPOSE ###
#
# 1. Replace the dates within the damaged files with
# the dates as per the directory path.
#

### MAIN ###

# Finding files that start with ./2
for file in $(find -type f | grep "^./2")
do
    year=$(head -n 1 $file | cut -d "-" -f 1)
    month=$(head -n 1 $file | cut -d "-" -f 2)
    day=$(head -n 1 $file | cut -d "-" -f 3)
    directory=$(echo ${file} | cut -d "/" -f 2-4 | tr "/" "-")

    # Replaces data if both dates are not the same
    if [ "$directory" != "$year-$month-$day" ]
        then
        sed -i "s/$year-$month-$day/$directory/g" $file
    fi
done
echo -e "\e[7mcorrectData script completed. \e[0m"