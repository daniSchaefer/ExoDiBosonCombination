#! /bin/bash

mass=$1
label=$2
myrand=$3
datacard=$4
algo=$5
hint="ProfileLikelihood"

maxBoundary=5
minBoundary=0.005

if [ $mass -gt 2000 ]
    then
    maxBoundary=100
    minBoundary=0.1
    echo "High mass $mass > 2000: boundary of combine is $minBoundary - $maxBoundary "
elif [ $mass -gt 1500 ]
    then
    maxBoundary=300
    minBoundary=0.03
    echo "High mass $mass 1500-2000: boundary of combine is $minBoundary - $maxBoundary "
elif [ $mass -gt 1100 ]
    then
    maxBoundary=100
    minBoundary=0.01
    if [[ $mass == 1200 && ($label == "ttjvh8" || $label == "ttjwh8" || $label == "ttjzh8") ]]
       then
       maxBoundary=2
       minBoundary=0.1 
    fi  
    echo "Medium mass $mass 1000 - 1500: boundary of combine is $minBoundary - $maxBoundary "
elif [ $mass -gt 800 ]
    then
    maxBoundary=100
    minBoundary=0.01
    if [ $label == "lllv8" ]
       then
       maxBoundary=1
       minBoundary=0.001 
    fi   
    if [[ $label == "ttjvh8" || $label == "ttjwh8" || $label == "ttjzh8" ]]
       then
       maxBoundary=2
       minBoundary=0.1 
    fi  
    echo "Low mass $mass <1000: boundary of combine is $minBoundary - $maxBoundary "
else
    maxBoundary=100
    minBoundary=0.01
    if [ $label == "lllv8" ]
       then
       maxBoundary=1
       minBoundary=0.001 
    fi   
    echo "Low mass $mass <1000: boundary of combine is $minBoundary - $maxBoundary "
fi

#alternative for zhttqq analysis
#if [ $mass -gt 2000 ]
#    then
#    maxBoundary=100
#    minBoundary=0.1
#    echo "High mass $mass > 2000: boundary of combine is $minBoundary - $maxBoundary "
#elif [ $mass -gt 1500 ]
#    then
#    maxBoundary=300
#    minBoundary=0.03
#    echo "High mass $mass 1500-2000: boundary of combine is $minBoundary - $maxBoundary "
#elif [ $mass -gt 1200 ]
#    then
#    maxBoundary=100
#    minBoundary=0.01
#    echo "Medium mass $mass 1200-1500: boundary of combine is $minBoundary - $maxBoundary "
#elif [ $mass -gt 800 ]
#    then
#    maxBoundary=2
#    minBoundary=0.1
#    echo "Low mass $mass 900 - 1200: boundary of combine is $minBoundary - $maxBoundary "
#else
#    maxBoundary=100
#    minBoundary=0.01
#    echo "Low mass $mass <1000: boundary of combine is $minBoundary - $maxBoundary "
#fi
  
#echo "==== Asymptotic CLs limits ====="
echo combine -M $algo -n ${label} -m $mass  -s $myrand -d ${datacard}.txt --rMax $maxBoundary --rMin $minBoundary -H $hint #--run blind #
combine -M $algo -n ${label} -m $mass  -s $myrand -d ${datacard}.txt --rMax $maxBoundary --rMin $minBoundary -H $hint #--run blind #

echo "Calculating the significances."

## calc exp signif
echo "==== Expected Significance ====="
combine -M ProfileLikelihood -n ${label}ExpSignif -m $mass  -s $myrand --signif --pvalue --expectSignal=1 -t -1 --toysFreq -d ${datacard}.txt

## calc obs signif
echo "==== Observed Significance ====="
combine -M ProfileLikelihood -n ${label}ObsSignif -m $mass  --signif --pvalue -d ${datacard}.txt 
