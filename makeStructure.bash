#!/bin/bash

### PURPOSE ###
# 1. To create directories based on date within month,
# month within year based the dates in Line 1 of each
# file.
#
# 2. To move the files into their respective directory.
#

### FUNCTIONS ###

function makeDirYear() {
    # Checks if year directory already exist
    # If directory does not exist -> create directory
    # If exist, no action

    if [ $(find -type d -name $year | wc -l) -eq 0 ]
        then echo "Made $year directory"
        mkdir $year
    fi
}

function makeDirMonth() {
    # Checks if month directory exist within the year d
    # If directory does not exist -> create directory
    # If exist, no action

    if [ $(find ./$year -maxdepth 1 -type d -name $month | wc -l) -eq 0 ]
        then echo "Made $month directory"
        mkdir $year/$month
    fi
}

 function makeDirDay() {
    # Check if day directory exist within the month d
    # If directory does not exist -> create directory
    # If exist, no action

    if [[ $(find ./$year/$month -type d -name $day) = "./$year/$month" || $(find ./$year/$month -maxdepth 1 -t    ype d -name $day | wc -l) -eq 0 ]]
        then echo "Made $day directory"
        mkdir $year/$month/$day
    fi
}

### MAIN ###

# Looking for the files in the working directory.
for file in $(find -maxdepth 1 -type f | grep "ff_" | cut -d "/" -f 2)
do
    year=$(head -n 1 $file | cut -d "-" -f 1)
    month=$(head -n 1 $file | cut -d "-" -f 2)
    day=$(head -n 1 $file | cut -d "-" -f 3)

    # Checks for the Year, Month and Day.
    makeDirYear $year
    makeDirMonth $month
    makeDirDay $day

    # Move files to the folders.
    mv $file $year/$month/$day/$file
    echo "Moved file to ./$year/$month/$day"
done
echo -e "\e[7mmakeStructure task completed. \e[0m"