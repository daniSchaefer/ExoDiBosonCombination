#!/bin/bash

if [ $# -lt 2 ]
then
    echo "Usage: ./parallelizeCombine_T3.sh <mass> <label>"
    exit 1
fi

RUN_LOCALLY=0 #if 1 -> do not submit, run locally

MASS=$1
LABEL=$2
ALGO="Asymptotic"
QUEUE=short.q
DATACARD="comb_${LABEL}.${MASS}"

BASEDIR=$( pwd )
LOGDIRNAME=${BASEDIR}/comb_${MASS}/logs
OUTDIR=${BASEDIR}/comb_${MASS}/output_${LABEL}_${ALGO}_${DATACARD}

mkdir -p ${LOGDIRNAME}
mkdir -p ${OUTDIR}

chmod 744 combine_exec_T3.sh

DATACARD="${BASEDIR}/comb_${MASS}/comb_${LABEL}.${MASS}"
MYRAND=$RANDOM #random number generator (short integer: [0-32767])
LOGFILE="${LOGDIRNAME}/log_local_${MASS}_${MYRAND}_${LABEL}.out"
LOGFULL=${OUTDIR}/comb_${MASS}/$LOGFILE

if [ $RUN_LOCALLY -eq 1 ]
then
    ${BASEDIR}/combine_exec_T3.sh ${MASS} ${LABEL} ${MYRAND} ${DATACARD} ${ALGO} #>> ${LOGFILE}
    #mv higgsCombine* ${OUTDIR}/.
    #rm roostats-*
    exit 1
fi    

OUTFILES="higgsCombine${LABEL}.Asymptotic.mH${MASS}.${MYRAND}.root higgsCombine${LABEL}ExpSignif.ProfileLikelihood.mH${MASS}.${MYRAND}.root higgsCombine${LABEL}ObsSignif.ProfileLikelihood.mH${MASS}.root"
echo qsub -q ${QUEUE} submitJobsOnT3batch.sh ${MASS} ${LABEL} ${MYRAND} ${DATACARD} ${ALGO} ${BASEDIR} ${OUTDIR}
qsub -q ${QUEUE} submitJobsOnT3batch.sh ${MASS} ${LABEL} ${MYRAND} ${DATACARD} ${ALGO} ${BASEDIR} ${OUTDIR}
