#!/bin/bash

folder=comb_${1}

comeback=$PWD
cd $folder
echo -n "Folder $folder:  "
crab -status | grep "Wrapper Exit Code : 0 "
cd $comeback
