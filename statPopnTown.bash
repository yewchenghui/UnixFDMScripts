#!/bin/bash

### PURPOSE ###
#
# 1. Displays the average, minimum and maximum data
# for the population for all years in a town.
#
# 2. Accepts multiple arguments.
#

### FUNCTIONS ###

function checkArg() {
    #Error if not 1 argument
    if [ $# -lt 1 ]
        then
        echo "No argument entered. Minimum 1 town name."
        echo "statPopnTown <town_name>"
        exit 2
    fi
}

function displayStats() {
    # Show statistics for avg, max, min
    echo "The average population is $avg."
    echo "The maximum population is $max."
    echo "The minimum population is $min."
}

function calculateAverage() {
    # Calculate Average
    avg=$(echo "scale=0; $total/$count" | bc)
}

function fileIndexExist() {
    # Create File Index if not exist
    if [ ! -e townFileIndex ]
    then
        for file in $(find -type f | grep "^./2")
        do
            townname=$(head -n3 $file | tail -n1)
            echo "$townname:${file}" >> townFileIndex
        done

    # Sort the list according to the Town name.
    sort -fo townFileIndex townFileIndex
    fi
}

### MAIN ###

checkArg $*
fileIndexExist $*

# For town in all arguments
for town in "$@"
do
    total=0
    count=0
    max=0
    min=0
    townCount=$(grep -iw $town townFileIndex | wc -l)
    townDir=$(grep -iw $town townFileIndex | cut -d ":" -f 2)
    if [ $townCount -eq 0 ]
		then
        echo "$town"
        echo "Cannot find this town in the curent records"
    else
        echo "$town"
        for dir in $townDir
        do
            population=$(cat $dir | tail -n1)
            total=$(($total+$population))
            count=$(($count+1))
            # Max Condition
            if [ $max -lt $population ]
                then
                max=$population
            fi
            # Min Condition
            if [ $count -eq 1 ]
                then
                min=$population
            elif [ $min -gt $population ]
                then
                min=$population
            fi
        done
        calculateAverage $*
        displayStats $*
    fi
done
