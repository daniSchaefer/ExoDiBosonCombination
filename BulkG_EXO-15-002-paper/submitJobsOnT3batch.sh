#!/bin/bash

JOBLOGFILES="myout.txt myerr.txt"
OUTFILES="higgsCombine${2}.Asymptotic.mH${1}.${3}.root higgsCombine${2}ExpSignif.ProfileLikelihood.mH${1}.${3}.root higgsCombine${2}ObsSignif.ProfileLikelihood.mH${1}.root"
DBG=2
SEUSERSUBDIR=""
SEOUTFILES=""
HN_NAME=`whoami`
USER_SRM_HOME="srm://t3se01.psi.ch:8443/srm/managerv2?SFN=/pnfs/psi.ch/cms/trivcat/store/user"
TOPWORKDIR=/scratch/`whoami`
JOBDIR="combine_${1}_${2}"
CMSSW_DIR="/shome/jngadiub/EXOVVAnalysisRunII/CMSSW_7_1_5"
BASEDIR=$6
LOGDIRNAME=${BASEDIR}/comb_${1}/logs
OUTDIR=$7

############ BATCH QUEUE DIRECTIVES ##############################
# Lines beginning with #$ are used to set options for the SGE
# queueing system (same as specifying these options to the qsub
# command

# Job name (defines name seen in monitoring by qstat and the
#     job script's stderr/stdout names)
#$ -N comb_job

### Specify the queue on which to run
#$ -q all.q

# Change to the current working directory from which the job got
# submitted (will also result in the job report stdout/stderr being
# written to this directory)
#$ -cwd

# here you could change location of the job report stdout/stderr files
#  if you did not want them in the submission directory
#$ -o ./
#$ -e ./
#################################################################

##### MONITORING/DEBUG INFORMATION ###############################
DATE_START=`date +%s`
echo "Job started at " `date`
cat <<EOF
################################################################
## QUEUEING SYSTEM SETTINGS:
HOME=$HOME
USER=$USER
JOB_ID=$JOB_ID
JOB_NAME=$JOB_NAME
HOSTNAME=$HOSTNAME
TASK_ID=$TASK_ID
QUEUE=$QUEUE

EOF

echo "################################################################"

if test 0"$DBG" -gt 0; then
   echo "######## Environment Variables ##########"
   env
   echo "################################################################"
fi


##### SET UP WORKDIR AND ENVIRONMENT ######################################
STARTDIR=`pwd`
WORKDIR=$TOPWORKDIR/$JOBDIR
RESULTDIR=$STARTDIR/$JOBDIR

if test -e "$WORKDIR"; then
   echo "ERROR: WORKDIR ($WORKDIR) already exists! Aborting..." >&2
   exit 1
fi
mkdir -p $WORKDIR
if test ! -d "$WORKDIR"; then
   echo "ERROR: Failed to create workdir ($WORKDIR)! Aborting..." >&2
   exit 1
fi

cd $WORKDIR
cat <<EOF
################################################################
## JOB SETTINGS:
STARTDIR=$STARTDIR
WORKDIR=$WORKDIR
RESULTDIR=$RESULTDIR
SERESULTDIR=$SERESULTDIR
EOF

###########################################################################
## YOUR FUNCTIONALITY CODE GOES HERE
# set up CMS environment
source $VO_CMS_SW_DIR/cmsset_default.sh

# Here we produce some output for the files that are copied back to
#  our shared home
scramv1 list > myout.txt 2>myerr.txt

lcg-ls -b -D lv2 -l srm://t3se01.psi.ch:8443/srm/managerv2?SFN=/pnfs/psi.ch/cms/ >> myout.txt 2>>myerr.txt

# create a dummy file for copying back to the SE
dd if=/dev/urandom of=mybigfile count=100 &>/dev/null

cd $CMSSW_DIR/src
eval `scramv1 runtime -sh`
if test $? -ne 0; then
   echo "ERROR: Failed to source scram environment" >&2
   exit 1
fi

cd $WORKDIR

echo ${BASEDIR}/combine_exec_T3.sh ${BASEDIR}/combine_exec_T3.sh ${1} ${2} ${3} ${4} ${5}
${BASEDIR}/combine_exec_T3.sh ${1} ${2} ${3} ${4} ${5}>> myout.txt 2>>myerr.txt

#### RETRIEVAL OF OUTPUT FILES AND CLEANING UP ############################
cd $WORKDIR
if test 0"$DBG" -gt 0; then
    echo "########################################################"
    echo "############# Working directory contents ###############"
    echo "pwd: " `pwd`
    ls -Rl
    echo "########################################################"
    echo "YOUR OUTPUT WILL BE MOVED TO $RESULTDIR"
    echo "########################################################"
fi

if test x"$JOBLOGFILES" != x; then
   mkdir -p $RESULTDIR
   if test ! -e "$RESULTDIR"; then
          echo "ERROR: Failed to create $RESULTDIR ...Aborting..." >&2
          exit 1
   fi
   for n in $JOBLOGFILES; do
       if test ! -e $WORKDIR/$n; then
          echo "WARNING: Cannot find output file $WORKDIR/$n. Ignoring it" >&2
       else
          cp -a $WORKDIR/$n $RESULTDIR/$n
          if test $? -ne 0; then
             echo "ERROR: Failed to copy $WORKDIR/$n to $RESULTDIR/$n" >&2
          fi
   fi
   done
fi

if test x"$OUTFILES" != x; then
   if test 0"$DBG" -ge 2; then
      srmdebug="-v"
   fi
   for n in $OUTFILES; do
       if test ! -e $WORKDIR/$n; then
          echo "WARNING: Cannot find output file $WORKDIR/$n. Ignoring it" >&2
       else
	  cp -a $WORKDIR/$n $OUTDIR/$n
          if test $? -ne 0; then
             echo "ERROR: Failed to copy $WORKDIR/$n to $OUTDIR/$n" >&2
          fi
   fi
   done
fi

echo "Cleaning up $WORKDIR"
rm -rf $WORKDIR

rm -rf $LOGDIRNAME/$JOBDIR
mv $STARTDIR/$JOBDIR $LOGDIRNAME/.

###########################################################################
DATE_END=`date +%s`
RUNTIME=$((DATE_END-DATE_START))
echo "################################################################"
echo "Job finished at " `date`
echo "Wallclock running time: $RUNTIME s"

cd ${BASEDIR}
mv comb_job.o$JOB_ID comb_job.e$JOB_ID $LOGDIRNAME/.
exit 0
