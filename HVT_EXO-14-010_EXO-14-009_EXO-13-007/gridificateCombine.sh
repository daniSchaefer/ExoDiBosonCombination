#! /bin/bash

if [ $# -lt 1 ]
then
    echo "Usage: ./gridificateCombine.sh <mass>"
    exit 1
fi

mass=$1

########## CHANGES GO HERE ##########
card="comb_ALL.$mass.txt"
binarycard="binaryDatacardALL.root"
channel="ALL"
subdir="comb_${mass}"
# To change number of toys and iterations, change run_fullCLs_TF.py
######### END CHANGES ##########

### Information
echo
echo
echo "====================================================="
echo "Mass is $mass,   card is $card,   channel is $channel"

# create the crab.cfg file
rm crab.cfg
echo '[CRAB]' > crab.cfg
echo 'jobtype = cmssw' >> crab.cfg
echo 'scheduler = remoteGlidein' >> crab.cfg
echo '' >> crab.cfg
echo '[CMSSW]' >> crab.cfg
echo 'datasetpath=none' >> crab.cfg
echo 'pset=pset.py' >> crab.cfg
echo 'events_per_job = 5000' >> crab.cfg

### IMPORTANT - this should be 56*N, where N is a factor such that
### there are N jobs for each signal strength step.
### This factor is the same as mitFactor in run_fullCLs_TF.py  
echo 'number_of_jobs = 448' >> crab.cfg

echo 'output_file = output.root' >> crab.cfg
echo '' >> crab.cfg
echo '[USER]' >> crab.cfg
echo 'return_data = 1' >> crab.cfg
echo 'additional_input_files='${binarycard}',combine,*root,run_fullCLs_TF.py' >> crab.cfg
echo 'script_exe=run_fullCLs_TF.sh' >> crab.cfg
echo '[GRID]' >> crab.cfg
#echo 'se_black_list=baylor.edu,kbfi.ee,ufl.edu' >> crab.cfg

# copy the relevant files inside the mass subdirs
echo "Copying files inside subdir $subdir"
cp $CMSSW_BASE/bin/$SCRAM_ARCH/combine crab.cfg run_fullCLs_TF.py pset.py ${subdir}

# go inside the subdir and quickly run combine (asymptotic) 
# to get a handle of what the limit should be. In this way
# we avoid the big array of limits

#set ad hoc boundaries for Asymptotic, otherwise it crashes 
maxBoundary=5
minBoundary=0.005

#change range of scan specifically for BulkG->ZZ with c=0.5
if [ $mass -gt 2000 ]
    then
    maxBoundary=500
    minBoundary=0.05
    echo "High mass $mass > 2000: boundary of combine is $minBoundary - $maxBoundary "
elif [ $mass -gt 1500 ]
    then
    maxBoundary=100
    minBoundary=0.01
    echo "High mass $mass 1500-2000: boundary of combine is $minBoundary - $maxBoundary "
elif [ $mass -gt 1000 ]
    then
    maxBoundary=50
    minBoundary=0.005
    echo "Medium mass $mass 1000 - 1500: boundary of combine is $minBoundary - $maxBoundary "
else
    maxBoundary=10
    minBoundary=0.001
    echo "Low mass $mass <1000: boundary of combine is $minBoundary - $maxBoundary "
fi

cd ${subdir}

# Run the text2workspace locally to save time!
echo "Doing text2workspace.py --binary -m ${mass} -D data_obs ${card} -o ${binarycard}"
text2workspace.py --binary -m ${mass} -D data_obs ${card} -o ${binarycard}

echo "Running asymptotic limit to get a hint of where the limit should lie"
#combine ${card} -M Asymptotic -m $mass --rMin $minBoundary --rMax $maxBoundary
ASYMPTOTICLIMIT=`combine ${binarycard} -M Asymptotic -m $mass --rMin $minBoundary --rMax $maxBoundary 2> /dev/null | grep 'Observed Limit' | awk '{print $5}'`

if [ $? != 0 ]
    then
    echo "Something went wrong when running the asymptotic limit... Exiting"
    exit 100
fi

echo $ASYMPTOTICLIMIT
ASYMPTBAD=$( echo "$ASYMPTOTICLIMIT <= 0" | bc ) #use bc for floating point comparison

if [[ $ASYMPTBAD == 1 ]]
    then #it shouldn't be. Something went wrong
    echo "Error in calculation of Asymptotic limit. Observed limit was $ASYMPTOTICLIMIT ( -> ASYMPTBAD=${ASYMPTBAD}). Exiting."
    exit 101
else
    echo "Observed limit is valid: $ASYMPTOTICLIMIT"
fi

cd -

echo "Preparing executable script for CRAB"
sed "s/sedMP/${mass}/g" run_fullCLs_TF.sh |\
sed "s/sedasympt/${ASYMPTOTICLIMIT}/g" |\
sed "s/sedcard/${binarycard}/g"|\
sed "s/sedchannel/${channel}/g">\
$subdir/run_fullCLs_TF.sh

# go in the mass subdir, create and submit the job
echo "Submitting CRAB jobs"
cd ${subdir}
crab -create
crab -submit
cd -
