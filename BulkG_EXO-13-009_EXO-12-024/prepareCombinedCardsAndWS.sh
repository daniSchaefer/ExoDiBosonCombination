#! /bin/bash

# define input
if [ $# -lt 1 ]
    then
    echo "Need one input: mass point"
    exit 1
fi

MASS=$1
echo "Merging M=${MASS}"
ZZDIR="ZZ_cards/${MASS}"
WWDIR="WW_cards"
JJDIR="JJ_cards"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/


### ZZ only
LABEL="xzz"
EXOZZLPCARDS="${LABEL}_ee1JLP=${LABEL}_ee1JLP.${MASS}.txt ${LABEL}_mm1JLP=${LABEL}_mm1JLP.${MASS}.txt"
EXOZZHPCARDS="${LABEL}_ee1JHP=${LABEL}_ee1JHP.${MASS}.txt ${LABEL}_mm1JHP=${LABEL}_mm1JHP.${MASS}.txt"
EXOZZCARDS="$EXOZZHPCARDS $EXOZZLPCARDS"
COMBZZCARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -le 2500 ]
then
echo "Moving to "${ZZDIR}/
cd ${ZZDIR}/
pwd
combineCards.py $EXOZZCARDS &> ${COMBZZCARD}
cd -
cp ${ZZDIR}/${COMBZZCARD} ${OUTDIR}/${COMBZZCARD}
cp ${ZZDIR}/${LABEL}_*input*.root  ${OUTDIR}/
fi

### JJ only
LABEL="xjj"
JJCARDORIG="CMS_jj_Bulk_${MASS}_8TeV_CMS_jj_VV.txt" ##Andreas gives us cards with WW and ZZ already merged
COMBJJCARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ]
then
###sed -e '/CMS_sig_p/ s|0|0.0|g' -e '/CMS_sig_p/ s|1|1.0|g' < CMS_jj_Bulk_1200_8TeV_CMS_jj_VV.txt
sed -e 's|datacards/../workspaces/||g' < ${JJDIR}/datacards/${JJCARDORIG} &> $OUTDIR/${COMBJJCARD}
###    sed -e 's|datacards/../workspaces/||g' -e '/CMS_sig_p/ s|0|0.0|' -e '/CMS_sig_p1/ s|1|1.0|2' -e '/CMS_sig_p2/ s|1|1.0|' < ${JJDIR}/datacards/${JJCARDORIG} &> $OUTDIR/${COMBJJCARD}
#    cp ${JJDIR}/datacards/${JJCARDORIG}  $OUTDIR/${COMBJJCARD}
    cp ${JJDIR}/workspaces/CMS_jj_Bulk*${MASS}*.root ${OUTDIR}/
    cp ${JJDIR}/workspaces/CMS_jj_bkg_8TeV.root ${OUTDIR}/
fi

### WW only
LABEL="xww"
WWBASE="wwlvj_BulkG_WW_inclusive_c0p2_M${MASS}"
WWELEBASE="${WWBASE}_el_10_00"
WWMUBASE="${WWBASE}_mu_10_00"
EXOWWLPCARDS="${LABEL}_ev1JLP=${WWELEBASE}_LP_unbin.txt ${LABEL}_mv1JLP=${WWMUBASE}_LP_unbin.txt"
EXOWWHPCARDS="${LABEL}_ev1JHP=${WWELEBASE}_HP_unbin.txt ${LABEL}_mv1JHP=${WWMUBASE}_HP_unbin.txt"
EXOWWCARDS="$EXOWWHPCARDS $EXOWWLPCARDS"
COMBWWCARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    cd ${WWDIR}/
    combineCards.py $EXOWWCARDS &> tmp_XWW_card.txt
    sed -e 's|1.072/0.891|1.080/0.920|g'  -e 's|1.303/1.277|0.70/1.30|g' < tmp_XWW_card.txt  > ${COMBWWCARD}
    cd -
    cp ${WWDIR}/${COMBWWCARD} ${OUTDIR}/${COMBWWCARD}
    cp ${WWDIR}/${WWBASE}_*workspace.root  ${OUTDIR}/
fi

###put things together
cd $OUTDIR/

COMB3CHANCARD="comb_ALL.${MASS}.txt"
COMBSEMILEPCARD="comb_SEMILEPT.${MASS}.txt"

if [ $MASS -lt 800 ]
    then
    combineCards.py $COMBZZCARD &>  $COMB3CHANCARD
    combineCards.py $COMBZZCARD &>  $COMBSEMILEPCARD
elif [ $MASS -lt 1000 ]
    then
    combineCards.py $COMBWWCARD $COMBZZCARD &>  $COMB3CHANCARD
    combineCards.py $COMBWWCARD $COMBZZCARD &>  $COMBSEMILEPCARD
elif [ $MASS -gt 2500 ]
    then
    combineCards.py $COMBJJCARD &>  $COMB3CHANCARD
else 
    combineCards.py $COMBJJCARD $COMBWWCARD $COMBZZCARD &>  $COMB3CHANCARD
    combineCards.py $COMBWWCARD $COMBZZCARD &>  $COMBSEMILEPCARD
fi
