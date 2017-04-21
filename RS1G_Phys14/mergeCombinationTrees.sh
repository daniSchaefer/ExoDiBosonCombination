#! /bin/bash

###the order:
#  ./mergeCombinationTrees.sh <MASS>
#  ./mergeHarvestedCombinationTrees.sh
# compile and run harvestMCMC.C passing the name of the grand total output file

MASS=0

if [ $# -gt 0 ]
then
    MASS=$1
else
    echo "Required one input, the mass point"
    exit 1
fi

ONED=1

if [ $# -eq 2 ]
then
    WIDTH=$2
    ONED=0
fi


if [ $ONED -eq 1 ]
    then
    BASED=comb_${MASS}
else
    BASED=comb_${MASS}_${WIDTH}
fi

LABEL="ALL813"
DIR="output_${LABEL}_Asymptotic_comb_${LABEL}.${MASS}"
LISTFILES_EXP=""
LISTFILES_OBS=""
LISTFILES_ASYMPT=""
LISTFILES_EXPSIGNIF=""
LISTFILES_OBSSIGNIF=""
STEMEXP="higgsCombine${LABEL}.exp.MarkovChainMC.mH${MASS}."
STEMOBS="higgsCombine${LABEL}.obs.MarkovChainMC.mH${MASS}."
STEMASYMPT="higgsCombine${LABEL}.Asymptotic.mH${MASS}."
STEMEXPSIGNIF="higgsCombine${LABEL}ExpSignif.ProfileLikelihood.mH${MASS}."
STEMOBSSIGNIF="higgsCombine${LABEL}ObsSignif.ProfileLikelihood.mH${MASS}."

# for file in $( /bin/ls "${BASED}/${DIR}/${STEMEXP}"[0-9]*root  )
#   do
#  # echo $file
#   LISTFILES_EXP=${LISTFILES_EXP}" $file "
# done

# for file in $( /bin/ls "${BASED}/${DIR}/${STEMOBS}"[0-9]*root  )
#   do
#  # echo $file
#   LISTFILES_OBS=${LISTFILES_OBS}" $file "
# done

for file in $( /bin/ls "${BASED}/${DIR}/${STEMASYMPT}"[0-9]*root  )
  do
 # echo $file
  LISTFILES_ASYMPT=${LISTFILES_ASYMPT}" $file "
done

for file in $( /bin/ls "${BASED}/${DIR}/${STEMEXPSIGNIF}"[0-9]*root  )
  do
 # echo $file
  LISTFILES_EXPSIGNIF=${LISTFILES_EXPSIGNIF}" $file "
done


for file in $( /bin/ls "${BASED}/${DIR}/${STEMOBSSIGNIF}"root  )
  do
 # echo $file
  LISTFILES_OBSSIGNIF=${LISTFILES_OBSSIGNIF}" $file "
done


if [ $ONED -eq 1 ]
    then
    FMOD=""
else
    FMOD=${WIDTH}"."
fi


echo "Merging: $LISTFILES"
#hadd ${MASS}/$DIR/${STEMEXP}"TOTAL.root" $LISTFILES_EXP
#hadd ${MASS}/$DIR/${STEMOBS}"TOTAL.root" $LISTFILES_OBS
hadd -f ${BASED}/$DIR/${STEMASYMPT}${FMOD}"TOTAL.root" $LISTFILES_ASYMPT
hadd -f ${BASED}/$DIR/${STEMEXPSIGNIF}${FMOD}"TOTAL.root" $LISTFILES_EXPSIGNIF
hadd -f ${BASED}/$DIR/${STEMOBSSIGNIF}${FMOD}"TOTAL.root" $LISTFILES_OBSSIGNIF

if [ ! -d harvestedTrees/ ]
    then
    mkdir harvestedTrees/
fi

cp ${BASED}/$DIR/*"TOTAL.root" harvestedTrees/

