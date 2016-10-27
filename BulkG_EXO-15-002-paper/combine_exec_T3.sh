#! /bin/bash

mass=$1
label=$2
myrand=$3
datacard=$4
algo=$5
hint="ProfileLikelihood"

#if algo="Asymptotic"  ###-t $ntoys
maxBoundary=5
minBoundary=0.005

#change range of scan specifically for BulkGRun12->VV with c=0.1
if [ $mass -gt 2000 ]
    then
    maxBoundary=10000
    minBoundary=1
    echo "High mass $mass > 2000: boundary of combine is $minBoundary - $maxBoundary "
elif [ $mass -gt 1500 ]
    then
    maxBoundary=3000
    minBoundary=0.3
    echo "High mass $mass 1500-2000: boundary of combine is $minBoundary - $maxBoundary "
elif [ $mass -gt 1000 ]
    then
    maxBoundary=500
    minBoundary=0.1
    echo "Medium mass $mass 1000 - 1500: boundary of combine is $minBoundary - $maxBoundary "
else
    maxBoundary=1000
    minBoundary=0.1
    echo "Low mass $mass <1000: boundary of combine is $minBoundary - $maxBoundary "
fi
 
echo "==== Asymptotic CLs limits ====="
echo combine -M $algo -n ${label} -m $mass  -s $myrand -d ${datacard}.txt --rMax $maxBoundary --rMin $minBoundary -H $hint #--run blind #
combine -M $algo -n ${label} -m $mass  -s $myrand -d ${datacard}.txt --rMax $maxBoundary --rMin $minBoundary -H $hint #--run blind #

## Maximum likelihood fit for debugging with plots
#combine -M MaxLikelihoodFit -n ${label} -m $mass  -s $myrand -d ${datacard}.txt --rMax $maxBoundary --rMin $minBoundary --plots --out ${WORKDIR}/$OUTDIR/

echo "Calculating the significances."

## calc exp signif
echo "==== Expected Significance ====="
combine -M ProfileLikelihood -n ${label}ExpSignif -m $mass  -s $myrand --signif --pvalue --expectSignal=1 -t -1 --toysFreq -d ${datacard}.txt

## calc obs signif
echo "==== Observed Significance ====="
combine -M ProfileLikelihood -n ${label}ObsSignif -m $mass  --signif --pvalue -d ${datacard}.txt 

#echo "List of files in $( pwd ):"
#echo "Moving files into ${WORKDIR}/$OUTDIR/"
#mv $TMPDIR/combine_${myrand}/higgsCombine${label}*.root  ${WORKDIR}/$OUTDIR/

