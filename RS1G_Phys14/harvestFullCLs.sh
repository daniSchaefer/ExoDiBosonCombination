#!/bin/bash

rm observedLimit.txt
rm expectedLimit.txt
rm limitM2.txt
rm limitM1.txt
rm limitP1.txt
rm limitP2.txt

for i in `cat masses.txt`; do
    FOLDER=comb_$i
    grep '95%' $FOLDER/limitOb*txt | awk '{print $4}' >> observedLimit.txt
    grep '95%' $FOLDER/limitM2*txt | awk '{print $4}' >> limitM2.txt
    grep '95%' $FOLDER/limitM1*txt | awk '{print $4}' >> limitM1.txt
    grep '95%' $FOLDER/limitE0*txt | awk '{print $4}' >> expectedLimit.txt
    grep '95%' $FOLDER/limitP1*txt | awk '{print $4}' >> limitP1.txt
    grep '95%' $FOLDER/limitP2*txt | awk '{print $4}' >> limitP2.txt
done

root -b makeFullCLsTree.C
