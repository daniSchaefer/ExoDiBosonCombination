#! /bin/bash

# define input
if [ $# -lt 1 ]
    then
    echo "Need one input: mass point"
    exit 1
fi

MASS=$1
echo "Merging M=${MASS}"
ZZ8DIR="ZZ_cards/${MASS}"
ZZ13DIR="ZZ_cards_13TeV_1fb"
WW8DIR="WW_cards"
WW13DIR="WW_cards_13TeV_1fb"
WW13DIR3fb="WW_cards_13TeV_3fb"
WW13DIR10fb="WW_cards_13TeV_10fb"
JJ8DIR="JJ_8TeV"
JJ13DIR="JJ_13TeV_1fb"
JJ13DIR3fb="JJ_13TeV_3fb"
JJ13DIR10fb="JJ_13TeV_10fb"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/


### ZZ8 only
LABEL="xzz"
EXOZZ8LPCARDS="${LABEL}_ee1JLP=${LABEL}_ee1JLP.${MASS}.txt ${LABEL}_mm1JLP=${LABEL}_mm1JLP.${MASS}.txt"
EXOZZ8HPCARDS="${LABEL}_ee1JHP=${LABEL}_ee1JHP.${MASS}.txt ${LABEL}_mm1JHP=${LABEL}_mm1JHP.${MASS}.txt"
EXOZZ8CARDS="$EXOZZ8HPCARDS $EXOZZ8LPCARDS"
COMBZZ8CARD="comb_${LABEL}.${MASS}.txt"
COMBRS1ZZ8CARD="comb_${LABEL}_rs1.${MASS}.txt"

if [ $MASS -le 2500 ]
then
echo "Moving to "${ZZ8DIR}/
cd ${ZZ8DIR}/
pwd
combineCards.py $EXOZZ8CARDS &> ${COMBZZ8CARD}
cd -
python adapt_xsec_ZZ.py ${MASS}
cp ${ZZ8DIR}/${COMBRS1ZZ8CARD} ${OUTDIR}/${COMBZZ8CARD}
cp ${ZZ8DIR}/${LABEL}_*input*.root  ${OUTDIR}/
fi

### ZZ13 only
LABEL="xzz13"
COMBZZ13CARD="comb_${LABEL}.${MASS}.txt"
COMBRS1ZZ13CARD="comb_${LABEL}_rs1.${MASS}.txt"

if [ $MASS -eq 1000 ] || [ $MASS -eq 2000 ] || [ $MASS -eq 3000 ] || [ $MASS -eq 4000 ]
then
echo "Moving to "${ZZ8DIR}/
python adapt_xsec_ZZ_13TeV.py ${MASS}
sed -e 's|workSpaces/||g' < ${ZZ13DIR}/${COMBRS1ZZ13CARD} &> $OUTDIR/${COMBZZ13CARD}
cp ${ZZ13DIR}/*_13TeV.root  ${OUTDIR}/
fi

### JJ 8TeV only
LABEL="xjj8"
JJ8CARDORIG="CMS_jj_RS1_${MASS}_8TeV_CMS_jj_VV.txt" ##Andreas gives us cards with WW and ZZ8 already merged
COMBJJ8CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1050 ] && [ $MASS -le 2900 ]
then
###sed -e '/CMS_sig_p/ s|0|0.0|g' -e '/CMS_sig_p/ s|1|1.0|g' < CMS_jj_Bulk_1200_8TeV_CMS_jj_VV.txt
sed -e 's|datacards/../workspaces/||g' < ${JJ8DIR}/${JJ8CARDORIG} &> $OUTDIR/${COMBJJ8CARD}
###    sed -e 's|datacards/../workspaces/||g' -e '/CMS_sig_p/ s|0|0.0|' -e '/CMS_sig_p1/ s|1|1.0|2' -e '/CMS_sig_p2/ s|1|1.0|' < ${JJDIR}/datacards/${JJCARDORIG} &> $OUTDIR/${COMBJJCARD}
#    cp ${JJDIR}/datacards/${JJCARDORIG}  $OUTDIR/${COMBJJCARD}
    cp ${JJ8DIR}/CMS_jj_RS1*${MASS}*.root ${OUTDIR}/
    cp ${JJ8DIR}/CMS_jj_bkg_8TeV.root ${OUTDIR}/
fi

### JJ 13TeV only
LABEL="xjj13"
JJ13CARDORIG="CMS_jj_RS1_${MASS}_13TeV_CMS_jj_VVHP.txt" ##Andreas gives us cards with WW and ZZ8 already merged
COMBJJ13CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
###sed -e '/CMS_sig_p/ s|0|0.0|g' -e '/CMS_sig_p/ s|1|1.0|g' < CMS_jj_Bulk_1200_8TeV_CMS_jj_VV.txt
sed -e 's|../workspaces/||g' < ${JJ13DIR}/${JJ13CARDORIG} &> $OUTDIR/${COMBJJ13CARD}
###    sed -e 's|datacards/../workspaces/||g' -e '/CMS_sig_p/ s|0|0.0|' -e '/CMS_sig_p1/ s|1|1.0|2' -e '/CMS_sig_p2/ s|1|1.0|' < ${JJDIR}/datacards/${JJCARDORIG} &> $OUTDIR/${COMBJJCARD}
#    cp ${JJDIR}/datacards/${JJCARDORIG}  $OUTDIR/${COMBJJCARD}
    cp ${JJ13DIR}/CMS_jj_RS1*${MASS}*.root ${OUTDIR}/
    cp ${JJ13DIR}/CMS_jj_bkg_13TeV.root ${OUTDIR}/
fi

### JJ 13TeV only 3fb
LABEL="xjj133fb"
JJ133fbCARDORIG="CMS_jj_RS1_${MASS}_13TeV_CMS_jj_VVHP.txt" ##Andreas gives us cards with WW and ZZ8 already merged
COMBJJ133fbCARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
###sed -e '/CMS_sig_p/ s|0|0.0|g' -e '/CMS_sig_p/ s|1|1.0|g' < CMS_jj_Bulk_1200_8TeV_CMS_jj_VV.txt
sed -e 's|../workspaces/||g' -e 's|CMS_jj_RS1WW_${MASS}_13TeV.root|CMS_jj_RS1WW_${MASS}_13TeV3fb.root|g' -e 's|CMS_jj_bkg_13TeV.root|CMS_jj_bkg_13TeV3fb.root|g' < ${JJ13DIR3fb}/${JJ133fbCARDORIG} &> $OUTDIR/${COMBJJ133fbCARD}
###    sed -e 's|datacards/../workspaces/||g' -e '/CMS_sig_p/ s|0|0.0|' -e '/CMS_sig_p1/ s|1|1.0|2' -e '/CMS_sig_p2/ s|1|1.0|' < ${JJDIR}/datacards/${JJCARDORIG} &> $OUTDIR/${COMBJJCARD}
#    cp ${JJDIR}/datacards/${JJCARDORIG}  $OUTDIR/${COMBJJCARD}
    cp ${JJ13DIR3fb}/CMS_jj_RS1WW_${MASS}_13TeV.root ${OUTDIR}/CMS_jj_RS1WW_${MASS}_13TeV3fb.root
    cp ${JJ13DIR3fb}/CMS_jj_bkg_13TeV.root ${OUTDIR}/CMS_jj_bkg_13TeV3fb.root
fi

### JJ 13TeV only 10fb
LABEL="xjj1310fb"
JJ1310fbCARDORIG="CMS_jj_RS1_${MASS}_13TeV_CMS_jj_VVHP.txt" ##Andreas gives us cards with WW and ZZ8 already merged
COMBJJ1310fbCARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
###sed -e '/CMS_sig_p/ s|0|0.0|g' -e '/CMS_sig_p/ s|1|1.0|g' < CMS_jj_Bulk_1200_8TeV_CMS_jj_VV.txt
sed -e 's|../workspaces/||g' -e 's|CMS_jj_RS1WW_${MASS}_13TeV.root|CMS_jj_RS1WW_${MASS}_13TeV10fb.root|g' -e 's|CMS_jj_bkg_13TeV.root|CMS_jj_bkg_13TeV10fb.root|g' < ${JJ13DIR10fb}/${JJ1310fbCARDORIG} &> $OUTDIR/${COMBJJ1310fbCARD}
###    sed -e 's|datacards/../workspaces/||g' -e '/CMS_sig_p/ s|0|0.0|' -e '/CMS_sig_p1/ s|1|1.0|2' -e '/CMS_sig_p2/ s|1|1.0|' < ${JJDIR}/datacards/${JJCARDORIG} &> $OUTDIR/${COMBJJCARD}
#    cp ${JJDIR}/datacards/${JJCARDORIG}  $OUTDIR/${COMBJJCARD}
    cp ${JJ13DIR10fb}/CMS_jj_RS1WW_${MASS}_13TeV.root ${OUTDIR}/CMS_jj_RS1WW_${MASS}_13TeV10fb.root
    cp ${JJ13DIR10fb}/CMS_jj_bkg_13TeV.root ${OUTDIR}/CMS_jj_bkg_13TeV10fb.root
fi

### WW only
LABEL="xww"
WW8BASE="wwlvj_BulkG_WW_inclusive_c0p2_M${MASS}"
WW8ELEBASE="${WW8BASE}_el_10_00"
WW8MUBASE="${WW8BASE}_mu_10_00"
EXOWW8LPCARDS="${LABEL}_ev1JLP=${WW8ELEBASE}_LP_unbin.txt ${LABEL}_mv1JLP=${WW8MUBASE}_LP_unbin.txt"
EXOWW8HPCARDS="${LABEL}_ev1JHP=${WW8ELEBASE}_HP_unbin.txt ${LABEL}_mv1JHP=${WW8MUBASE}_HP_unbin.txt"
EXOWW8CARDS="$EXOWW8HPCARDS $EXOWW8LPCARDS"
COMBWW8CARD="comb_${LABEL}.${MASS}.txt"
COMBRS1WW8CARD="comb_${LABEL}_rs1.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    cd ${WW8DIR}/
    combineCards.py $EXOWW8CARDS &> tmp_XWW8_card.txt
    sed -e 's|1.072/0.891|1.080/0.920|g'  -e 's|1.303/1.277|0.70/1.30|g' < tmp_XWW8_card.txt  > ${COMBWW8CARD}
    cd -
    python adapt_xsec_WW.py ${MASS}
    cp ${WW8DIR}/${COMBRS1WW8CARD} ${OUTDIR}/${COMBWW8CARD}
    cp ${WW8DIR}/${WW8BASE}_*workspace.root  ${OUTDIR}/
fi

### WW 13 TeV only
LABEL="xww13"
WW13BASE="wwlvj_RS1G_WW_lvjj_M${MASS}"
WW13ELEBASE="${WW13BASE}_el"
WW13MUBASE="${WW13BASE}_mu"
#EXOWW13LPCARDS="${LABEL}_ev1JLP=${WW13ELEBASE}_LP_unbin.txt ${LABEL}_mv1JLP=${WW13MUBASE}_LP_unbin.txt"
EXOWW13HPCARDS="${LABEL}_ev1JHP=${WW13ELEBASE}_HP_unbin.txt ${LABEL}_mv1JHP=${WW13MUBASE}_HP_unbin.txt"
EXOWW13CARDS="$EXOWW13HPCARDS" # $EXOWW13LPCARDS
COMBWW13CARD="comb_${LABEL}.${MASS}.txt"
COMBRS1WW13CARD="comb_${LABEL}_rs1.${MASS}.txt"

if [ $MASS -eq 1000 ] || [ $MASS -eq 2000 ] || [ $MASS -eq 3000 ] || [ $MASS -eq 4000 ]
    then
    cd ${WW13DIR}/
    combineCards.py $EXOWW13CARDS &> tmp_XWW13_card.txt
    sed -e 's|1.072/0.891|1.080/0.920|g'  -e 's|1.303/1.277|0.70/1.30|g' < tmp_XWW13_card.txt  > ${COMBWW13CARD}
    cd -
    python adapt_xsec_WW_13TeV.py ${MASS}
    cp ${WW13DIR}/${COMBRS1WW13CARD} ${OUTDIR}/${COMBWW13CARD}
    cp ${WW13DIR}/${WW13BASE}_*workspace.root  ${OUTDIR}/
fi

### WW 13 TeV only 3fb
LABEL="xww133fb"
WW133fbBASE="wwlvj_RS1G_WW_lvjj_M${MASS}"
WW133fbELEBASE="${WW133fbBASE}_el"
WW133fbMUBASE="${WW133fbBASE}_mu"
#EXOWW133fbLPCARDS="${LABEL}_ev1JLP=${WW133fbELEBASE}_LP_unbin.txt ${LABEL}_mv1JLP=${WW133fbMUBASE}_LP_unbin.txt"
EXOWW133fbHPCARDS="${LABEL}_ev1JHP=${WW133fbELEBASE}_HP_unbin.txt ${LABEL}_mv1JHP=${WW133fbMUBASE}_HP_unbin.txt"
EXOWW133fbCARDS="$EXOWW133fbHPCARDS" # $EXOWW133fbLPCARDS
COMBWW133fbCARD="comb_${LABEL}.${MASS}.txt"
COMBRS1WW133fbCARD="comb_${LABEL}_rs1.${MASS}.txt"

if [ $MASS -eq 1000 ] || [ $MASS -eq 2000 ] || [ $MASS -eq 3000 ] || [ $MASS -eq 4000 ]
    then
    cd ${WW13DIR3fb}/
    combineCards.py $EXOWW133fbCARDS &> tmp_XWW133fb_card.txt
    sed -e 's|1.072/0.891|1.080/0.920|g'  -e 's|1.303/1.277|0.70/1.30|g'  -e 's|workspace.root|workspace3fb.root|g' < tmp_XWW133fb_card.txt  > ${COMBWW133fbCARD}
    cd -
    python adapt_xsec_WW_13TeV.py ${MASS}
    cp ${WW13DIR3fb}/${COMBRS1WW133fbCARD} ${OUTDIR}/${COMBWW133fbCARD}
    cp ${WW13DIR3fb}/${WW133fbBASE}_el_HP_workspace.root  ${OUTDIR}/${WW133fbBASE}_el_HP_workspace3fb.root
    cp ${WW13DIR3fb}/${WW133fbBASE}_mu_HP_workspace.root  ${OUTDIR}/${WW133fbBASE}_mu_HP_workspace3fb.root
fi

### WW 13 TeV only 10fb
LABEL="xww1310fb"
WW1310fbBASE="wwlvj_RS1G_WW_lvjj_M${MASS}"
WW1310fbELEBASE="${WW1310fbBASE}_el"
WW1310fbMUBASE="${WW1310fbBASE}_mu"
#EXOWW1310fbLPCARDS="${LABEL}_ev1JLP=${WW1310fbELEBASE}_LP_unbin.txt ${LABEL}_mv1JLP=${WW1310fbMUBASE}_LP_unbin.txt"
EXOWW1310fbHPCARDS="${LABEL}_ev1JHP=${WW1310fbELEBASE}_HP_unbin.txt ${LABEL}_mv1JHP=${WW1310fbMUBASE}_HP_unbin.txt"
EXOWW1310fbCARDS="$EXOWW1310fbHPCARDS" # $EXOWW1310fbLPCARDS
COMBWW1310fbCARD="comb_${LABEL}.${MASS}.txt"
COMBRS1WW1310fbCARD="comb_${LABEL}_rs1.${MASS}.txt"

if [ $MASS -eq 1000 ] || [ $MASS -eq 2000 ] || [ $MASS -eq 3000 ] || [ $MASS -eq 4000 ]
    then
    cd ${WW13DIR10fb}/
    combineCards.py $EXOWW1310fbCARDS &> tmp_XWW1310fb_card.txt
    sed -e 's|1.072/0.891|1.080/0.920|g'  -e 's|1.303/1.277|0.70/1.30|g'  -e 's|workspace.root|workspace10fb.root|g' < tmp_XWW1310fb_card.txt  > ${COMBWW1310fbCARD}
    cd -
    python adapt_xsec_WW_13TeV.py ${MASS}
    cp ${WW13DIR10fb}/${COMBRS1WW1310fbCARD} ${OUTDIR}/${COMBWW1310fbCARD}
    cp ${WW13DIR10fb}/${WW1310fbBASE}_el_HP_workspace.root  ${OUTDIR}/${WW1310fbBASE}_el_HP_workspace10fb.root
    cp ${WW13DIR10fb}/${WW1310fbBASE}_mu_HP_workspace.root  ${OUTDIR}/${WW1310fbBASE}_mu_HP_workspace10fb.root
fi

###put things together
cd $OUTDIR/

COMBALLCARD="comb_ALL.${MASS}.txt"
COMBSEMILEPCARD="comb_SEMILEPT.${MASS}.txt"
COMBSEMILEP813CARD="comb_SEMILEPT813.${MASS}.txt"
COMBJJ813CARD="comb_JJ813.${MASS}.txt"
COMBWW813CARD="comb_WW813.${MASS}.txt"
COMBZZ813CARD="comb_ZZ813.${MASS}.txt"
COMBALL13CARD="comb_ALL13.${MASS}.txt"
COMBALL813CARD="comb_ALL813.${MASS}.txt"
COMBJJ8133fbCARD="comb_JJ8133fb.${MASS}.txt"
COMBWW8133fbCARD="comb_WW8133fb.${MASS}.txt"
COMBALL133fbCARD="comb_ALL133fb.${MASS}.txt"
COMBALL8133fbCARD="comb_ALL8133fb.${MASS}.txt"
COMBJJ81310fbCARD="comb_JJ81310fb.${MASS}.txt"
COMBWW81310fbCARD="comb_WW81310fb.${MASS}.txt"
COMBALL1310fbCARD="comb_ALL1310fb.${MASS}.txt"
COMBALL81310fbCARD="comb_ALL81310fb.${MASS}.txt"

if [ $MASS -lt 800 ]
    then

    combineCards.py $COMBZZ8CARD &>  $COMBZZ813CARD
    combineCards.py $COMBZZ8CARD &>  $COMBSEMILEPCARD
    combineCards.py $COMBZZ8CARD &>  $COMBALLCARD
    combineCards.py $COMBZZ8CARD &>  $COMBALL813CARD
    combineCards.py $COMBZZ8CARD &>  $COMBALL8133fbCARD
    combineCards.py $COMBZZ8CARD &>  $COMBALL81310fbCARD
elif [ $MASS -lt 1050 ]
    then

    combineCards.py $COMBZZ8CARD $COMBZZ13CARD &>  $COMBZZ813CARD
    combineCards.py $COMBWW8CARD $COMBWW13CARD &>  $COMBWW813CARD
    combineCards.py $COMBWW8CARD $COMBWW133fbCARD &>  $COMBWW8133fbCARD
    combineCards.py $COMBWW8CARD $COMBWW1310fbCARD &>  $COMBWW81310fbCARD
    combineCards.py $COMBWW8CARD $COMBZZ8CARD &>  $COMBSEMILEPCARD
    combineCards.py $COMBWW8CARD $COMBWW13CARD $COMBZZ8CARD &>  $COMBSEMILEP813CARD
    combineCards.py $COMBWW8CARD $COMBZZ8CARD &>  $COMBALLCARD
    combineCards.py $COMBZZ13CARD $COMBWW13CARD &>  $COMBALL13CARD
    combineCards.py $COMBWW8CARD $COMBWW13CARD $COMBZZ13CARD $COMBZZ8CARD &>  $COMBALL813CARD
    combineCards.py $COMBWW133fbCARD &>  $COMBALL133fbCARD
    combineCards.py $COMBWW8CARD $COMBWW133fbCARD $COMBZZ8CARD &>  $COMBALL8133fbCARD
    combineCards.py $COMBWW1310fbCARD &>  $COMBALL1310fbCARD
    combineCards.py $COMBWW8CARD $COMBWW1310fbCARD $COMBZZ8CARD &>  $COMBALL81310fbCARD
elif [ $MASS -lt 1200 ]
    then
    combineCards.py $COMBJJ8CARD &>  $COMBJJ813CARD
    combineCards.py $COMBZZ8CARD $COMBZZ13CARD &>  $COMBZZ813CARD
    combineCards.py $COMBWW8CARD $COMBWW13CARD &>  $COMBWW813CARD
    combineCards.py $COMBJJ8CARD &>  $COMBJJ8133fbCARD
    combineCards.py $COMBWW8CARD $COMBWW133fbCARD &>  $COMBWW8133fbCARD
    combineCards.py $COMBJJ8CARD &>  $COMBJJ81310fbCARD
    combineCards.py $COMBWW8CARD $COMBWW1310fbCARD &>  $COMBWW81310fbCARD
    combineCards.py $COMBWW8CARD $COMBZZ8CARD &>  $COMBSEMILEPCARD
    combineCards.py $COMBWW8CARD $COMBWW13CARD $COMBZZ8CARD &>  $COMBSEMILEP813CARD
    combineCards.py $COMBJJ8CARD $COMBWW8CARD $COMBZZ8CARD &>  $COMBALLCARD
    combineCards.py $COMBZZ13CARD $COMBWW13CARD &>  $COMBALL13CARD
    combineCards.py $COMBJJ8CARD $COMBWW8CARD $COMBWW13CARD $COMBZZ13CARD $COMBZZ8CARD &>  $COMBALL813CARD
    combineCards.py $COMBWW133fbCARD &>  $COMBALL133fbCARD
    combineCards.py $COMBJJ8CARD $COMBWW8CARD $COMBWW133fbCARD $COMBZZ8CARD &>  $COMBALL8133fbCARD
    combineCards.py $COMBWW1310fbCARD &>  $COMBALL1310fbCARD
    combineCards.py $COMBJJ8CARD $COMBWW8CARD $COMBWW1310fbCARD $COMBZZ8CARD &>  $COMBALL81310fbCARD
elif [ $MASS -gt 2900 ]
    then
    combineCards.py $COMBJJ13CARD &>  $COMBJJ813CARD
    combineCards.py $COMBZZ13CARD &>  $COMBZZ813CARD
    combineCards.py $COMBWW13CARD &>  $COMBWW813CARD
    combineCards.py $COMBJJ133fbCARD &>  $COMBJJ8133fbCARD
    combineCards.py $COMBWW133fbCARD &>  $COMBWW8133fbCARD
    combineCards.py $COMBJJ1310fbCARD &>  $COMBJJ81310fbCARD
    combineCards.py $COMBWW1310fbCARD &>  $COMBWW81310fbCARD

    combineCards.py $COMBWW13CARD &>  $COMBSEMILEP813CARD

    combineCards.py $COMBJJ13CARD $COMBZZ13CARD $COMBWW13CARD &>  $COMBALL13CARD
    combineCards.py $COMBJJ13CARD $COMBZZ13CARD $COMBWW13CARD &>  $COMBALL813CARD
    combineCards.py $COMBJJ133fbCARD $COMBWW133fbCARD &>  $COMBALL133fbCARD
    combineCards.py $COMBJJ133fbCARD $COMBWW133fbCARD &>  $COMBALL8133fbCARD
    combineCards.py $COMBJJ1310fbCARD $COMBWW1310fbCARD &>  $COMBALL1310fbCARD
    combineCards.py $COMBJJ1310fbCARD $COMBWW1310fbCARD &>  $COMBALL81310fbCARD
elif [ $MASS -gt 2500 ]
    then
    combineCards.py $COMBJJ8CARD $COMBJJ13CARD &>  $COMBJJ813CARD
    combineCards.py $COMBZZ13CARD &>  $COMBZZ813CARD
    combineCards.py $COMBWW13CARD &>  $COMBWW813CARD
    combineCards.py $COMBJJ8CARD $COMBJJ133fbCARD &>  $COMBJJ8133fbCARD
    combineCards.py $COMBWW133fbCARD &>  $COMBWW8133fbCARD
    combineCards.py $COMBJJ8CARD $COMBJJ1310fbCARD &>  $COMBJJ81310fbCARD
    combineCards.py $COMBWW1310fbCARD &>  $COMBWW81310fbCARD

    combineCards.py $COMBWW13CARD &>  $COMBSEMILEP813CARD
    combineCards.py $COMBJJ8CARD &>  $COMBALLCARD
    combineCards.py $COMBJJ13CARD $COMBZZ13CARD $COMBWW13CARD &>  $COMBALL13CARD
    combineCards.py $COMBJJ8CARD $COMBJJ13CARD $COMBZZ13CARD $COMBWW13CARD &>  $COMBALL813CARD
    combineCards.py $COMBJJ133fbCARD $COMBWW133fbCARD &>  $COMBALL133fbCARD
    combineCards.py $COMBJJ8CARD $COMBJJ133fbCARD $COMBWW133fbCARD &>  $COMBALL8133fbCARD
    combineCards.py $COMBJJ1310fbCARD $COMBWW1310fbCARD &>  $COMBALL1310fbCARD
    combineCards.py $COMBJJ8CARD $COMBJJ1310fbCARD $COMBWW1310fbCARD &>  $COMBALL81310fbCARD
else 
    combineCards.py $COMBJJ8CARD $COMBJJ13CARD &>  $COMBJJ813CARD
    combineCards.py $COMBZZ8CARD $COMBZZ13CARD &>  $COMBZZ813CARD
    combineCards.py $COMBWW8CARD $COMBWW13CARD &>  $COMBWW813CARD
    combineCards.py $COMBJJ8CARD $COMBJJ133fbCARD &>  $COMBJJ8133fbCARD
    combineCards.py $COMBWW8CARD $COMBWW133fbCARD &>  $COMBWW8133fbCARD
    combineCards.py $COMBJJ8CARD $COMBJJ1310fbCARD &>  $COMBJJ81310fbCARD
    combineCards.py $COMBWW8CARD $COMBWW1310fbCARD &>  $COMBWW81310fbCARD
    combineCards.py $COMBWW8CARD $COMBZZ8CARD &>  $COMBSEMILEPCARD
    combineCards.py $COMBWW8CARD $COMBWW13CARD $COMBZZ8CARD &>  $COMBSEMILEP813CARD
    combineCards.py $COMBJJ8CARD $COMBWW8CARD $COMBZZ8CARD &>  $COMBALLCARD
    combineCards.py $COMBJJ13CARD $COMBZZ13CARD $COMBWW13CARD &>  $COMBALL13CARD
    combineCards.py $COMBJJ8CARD $COMBJJ13CARD $COMBWW8CARD $COMBZZ13CARD $COMBWW13CARD $COMBZZ8CARD &>  $COMBALL813CARD
    combineCards.py $COMBJJ133fbCARD $COMBWW133fbCARD &>  $COMBALL133fbCARD
    combineCards.py $COMBJJ8CARD $COMBJJ133fbCARD $COMBWW8CARD $COMBWW133fbCARD $COMBZZ8CARD &>  $COMBALL8133fbCARD
    combineCards.py $COMBJJ1310fbCARD $COMBWW1310fbCARD &>  $COMBALL1310fbCARD
    combineCards.py $COMBJJ8CARD $COMBJJ1310fbCARD $COMBWW8CARD $COMBWW1310fbCARD $COMBZZ8CARD &>  $COMBALL81310fbCARD
fi
