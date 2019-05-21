#!/bin/bash

### PURPOSE ###
#
# 1. To extract the files needed for project phase 1
# and 2.
#

if [ $1 -eq 1 ]
    then
    tar -xf /var/tmp/fts.tar
    echo -e "\e[7mPhase 1 files extracted.\e[0m"
elif [ $1 -eq 2 ]
    then
    rm -r 20* ff*
    echo -e "\e[7mPhase 2 Step 1 deletion completed.\e[0m"
    tar -xf /var/tmp/damagedData.tar
    echo -e "\e[7mPhase 2 Step 2 files extracted.\e[0m"
elif [ $1 -eq 3 ]
    then
    rm -r 20* ff*
    echo -e "\e[7mReset directory.\e[0m"
else
    echo "Choose between 1 or 2. Invalid argument."
fi