#!/bin/bash

### PURPOSE ###
#
# 1. Display information related to the population for
# the respective years.
#
# Syntax: statPopnYear <Year> <average/minimum/maximum
#         /all>
#
#

### FUNCTIONS ###

function checkArg() {
    # Returns error if not 2 arguments
    if [ $# -ne 2 ]
        then
        echo "Incorrect number of parameters."
        echo "statPopnYear <Year> <average/minimum/maximum/all>"
        exit 2

    # Returns error if not within Year range
    elif [ ! -e $1 ]
        then
        echo "Year not found in list."
        exit 2

    # Returns error if not the exact 2nd argument
    elif [[ $2 != "average" ]] && [[ $2 != "maximum" ]] && [[ $2 != "minimum" ]] && [[ $2 != "all" ]]
        then
        echo "Incorrect second parameter."
		echo "<average/minimum/maximum/all>"
        exit 2
    fi
}

function displayStats() {
    # Show statistics for avg, max, min
    case $2 in
    average)
        echo "The average population for the year $1 was $avg.";;
    maximum)
        echo "The maximum population for the year $1 was $max.";;
    minimum)
        echo "The minimum population for the year $1 was $min.";;
    all)
        echo "Average is $avg."
        echo "Maximum is $max."
        echo "Minimum is $min.";;
    esac
}

function calculateAverage() {
    # Calculate Average
    avg=$(echo "scale=0; $total/$count" | bc)
}

### MAIN ###
total=0
count=0
max=0
min=0

checkArg $*

# Search for folders based on Year
for file in $(find ./$1 -type f | grep "^./2")
do
    population=$(tail -n 1 $file)

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
