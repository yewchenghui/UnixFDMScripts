#!/bin/bash

### PURPOSE ###
#
# 1. To retrieve the population data based on the
# file index, townFileIndex.
#
# 2. Accepts multiple town names as arguments.
#

### FUNCTIONS ###

function checkArguments() {
    # Checks if at least one town name is entered.
    # Returns error message if no arguments

    if [ $# -lt 1 ]
    then
        echo "No argument entered. Minimum 1 town name."
        exit 2
    fi
}

### MAIN ###

checkArguments $*

# For town in all arguments
for town in "$@"
do
    townCount=$(grep -iw $town townFileIndex | wc -l)
    townDir=$(grep -iw $town townFileIndex | cut -d ":" -f 2)

	# if town not found
    if [ $townCount -eq 0 ]
        then
        echo "$town"
        echo "Cannot find this town ($town) in the current records."
    else
        echo "$town"
        for dir in $townDir
        do
            townPop=$(cat $dir | tail -n1)
            townDate=$(cat $dir | head -n1)
            echo "$townDate:$townPop"
        done
    fi
done
