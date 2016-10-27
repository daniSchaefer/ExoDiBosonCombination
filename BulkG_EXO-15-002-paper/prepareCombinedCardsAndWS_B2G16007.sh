#! /bin/bash

# define input
if [ $# -lt 1 ]
    then
    echo "Need one input: mass point"
    exit 1
fi

MASS=$1
echo "Merging M=${MASS}"
WW13DIR="WW_cards_13TeV"
LOWMASSWW13DIR="WWlowmass_cards_13TeV/"
JJ13DIR="JJ_cards_13TeV"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/

### JJ 13TeV only
LABEL="xjj13ww"
JJ13CARDORIG="CMS_jj_BulkWWfix_${MASS}_13TeV_CMS_jj_VV.txt"
COMBJJWW13CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
    python adapt_xsec_JJ_BulkWW_13TeV.py ${MASS}
sed -e 's|datacards_withPDFuncertainties/../workspaces/||g' -e 's|datacards_backup/../workspaces/||g' -e 's|datacards/../workspaces/||g' -e 's|../workspaces/||g' < ${JJ13DIR}/${JJ13CARDORIG} &> $OUTDIR/${COMBJJWW13CARD}
    cp ${JJ13DIR}/CMS_jj_Bulk*${MASS}*.root ${OUTDIR}/
    cp ${JJ13DIR}/CMS_jj_bkg_13TeV.root ${OUTDIR}/
fi

### JJ 13TeV only
LABEL="xjj13zz"
JJ13CARDORIG="CMS_jj_BulkZZfix_${MASS}_13TeV_CMS_jj_VV.txt"
COMBJJZZ13CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
    python adapt_xsec_JJ_BulkZZ_13TeV.py ${MASS}
sed -e 's|datacards_withPDFuncertainties/../workspaces/||g' -e 's|datacards_backup/../workspaces/||g' -e 's|datacards/../workspaces/||g' -e 's|../workspaces/||g' < ${JJ13DIR}/${JJ13CARDORIG} &> $OUTDIR/${COMBJJZZ13CARD}
    cp ${JJ13DIR}/CMS_jj_Bulk*${MASS}*.root ${OUTDIR}/
    cp ${JJ13DIR}/CMS_jj_bkg_13TeV.root ${OUTDIR}/
fi

### combine 13 TeV JJ WW+ZZ
if [ $MASS -ge 1200 ]
then
    python comb_xjj13.py ${MASS}
fi    
COMBJJ13CARD="comb_xjj13.${MASS}.txt"

### WW 13 TeV only
LABEL="xww13"
EXOWW13CARDS="wwlvj_BulkGfix_WW_lvjj_M${MASS}_combo_ALLP_unbin.txt"
COMBWW13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -gt 800 ]
    then
    python adapt_xsec_WW_13TeV.py ${MASS}
    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HP/||g' -e 's|cards_mu_LP/||g' -e 's|cards_el_HP/||g' -e 's|cards_el_LP/||g' -e 's|cards_mu_HPZ/||g'  -e 's|cards_mu_LPW/||g' -e 's|cards_mu_LPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|cards_el_LPW/||g' -e 's|cards_el_LPZ/||g' < ${WW13DIR}/${EXOWW13CARDS} &> $OUTDIR/${COMBWW13CARD}
    cp ${WW13DIR}/cards_mu_HPW/wwlvj_mu_HPW_workspace.root ${OUTDIR}/
    cp ${WW13DIR}/cards_mu_HPZ/wwlvj_mu_HPZ_workspace.root ${OUTDIR}/
    cp ${WW13DIR}/cards_el_HPW/wwlvj_el_HPW_workspace.root ${OUTDIR}/
    cp ${WW13DIR}/cards_el_HPZ/wwlvj_el_HPZ_workspace.root ${OUTDIR}/
    cp ${WW13DIR}/cards_*_HP*/wwlvj_BulkG_WW_lvjj_M${MASS}_*_workspace.root ${OUTDIR}/
else
    python adapt_xsec_WWlowmass_13TeV.py ${MASS}
    LOWMASSWW13CARDS="wwlvj_BulkGravitonFix${MASS}_em_HP_unbin.txt"
    cp ${LOWMASSWW13DIR}/${LOWMASSWW13CARDS} ${OUTDIR}/${COMBWW13CARD}
    cp ${LOWMASSWW13DIR}/wwlvj_BulkGraviton${MASS}_*_workspace.root ${OUTDIR}/
fi

###put things together
cd $OUTDIR/

#13 TeV BulkG
COMBALL13CARD="comb_ALL13.${MASS}.txt"
       
if [ $MASS -lt 1200 ] #600-1100
    then

    #13 TeV BulkG
    combineCards.py $COMBWW13CARD &> $COMBALL13CARD
        
elif [ $MASS -le 4000 ] #1200-4000
    then

    #13 TeV BulkG
    combineCards.py $COMBWW13CARD $COMBJJ13CARD &> $COMBALL13CARD
fi
