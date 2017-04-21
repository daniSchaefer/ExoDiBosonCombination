#! /bin/bash

# define input
if [ $# -lt 1 ]
    then
    echo "Need one input: mass point"
    exit 1
fi

MASS=$1
echo "Merging M=${MASS}"
LVJ13DIR="LVJ_cards_13TeV"
JJ13DIR="JJ_cards_13TeV"
LOWMASSLVJ13DIR="LVJlowmass_cards_13TeV"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/

### LVJ VprimeWV 13 TeV only
LABEL="lvjwv13"
LVJWV13CARD="wwlvj_Vprime_WV_lvjj_M${MASS}_combo_ALLP_unbin.txt"
COMBLVJWV13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 900 ]
    then
    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HPZ/||g'  -e 's|cards_mu_LPW/||g' -e 's|cards_mu_LPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|cards_el_LPW/||g' -e 's|cards_el_LPZ/||g' < ${LVJ13DIR}/${LVJWV13CARD} &> $OUTDIR/${COMBLVJWV13CARD}
    cp ${LVJ13DIR}/cards_mu_HPW/wwlvj_mu_HPW_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_mu_HPZ/wwlvj_mu_HPZ_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_el_HPW/wwlvj_el_HPW_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_el_HPZ/wwlvj_el_HPZ_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_*/wwlvj_Zprime_WW_lvjj_M${MASS}_*_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_*/wwlvj_Wprime_WZ_lvjj_M${MASS}_*_workspace.root ${OUTDIR}/
else
    python adapt_xsec_lvjWWlowmass_13TeV.py ${MASS}
    LOWMASSLVJ13CARDS="wwlvj_VprimeFix${MASS}_em_HP_unbin.txt"
    cp ${LOWMASSLVJ13DIR}/${LOWMASSLVJ13CARDS} ${OUTDIR}/${COMBLVJWV13CARD}
    cp ${LOWMASSLVJ13DIR}/wwlvj_Zprime${MASS}_*_workspace.root ${OUTDIR}/
    cp ${LOWMASSLVJ13DIR}/wwlvj_Wprime${MASS}_*_workspace.root ${OUTDIR}/
fi


### JJ VprimeWV 13 TeV only
LABEL="jjwv13"
JJWV13CARD="CMS_jj_Vprime_WV_${MASS}_13TeV.txt"
COMBJJWV13CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
    python adapt_xsec_jjWV_13TeV.py ${MASS}
    sed -e 's|datacards_withPDFuncertainties/../workspaces/||g' -e 's|datacards_backup/../workspaces/||g' -e 's|datacards/../workspaces/||g' -e 's|../workspaces/||g' < ${JJ13DIR}/${JJWV13CARD} &> $OUTDIR/${COMBJJWV13CARD}
    cp ${JJ13DIR}/CMS_jj_ZprimeWW_*${MASS}*.root ${OUTDIR}/.
    cp ${JJ13DIR}/CMS_jj_WZ_*${MASS}*.root ${OUTDIR}/.
    cp ${JJ13DIR}/CMS_jj_bkg_13TeV.root ${OUTDIR}/.
fi

###put things together
cd $OUTDIR/

# 13 TeV LVJ+JJ
COMBJJLVJHVT13="comb_JJLVJHVT13.${MASS}.txt" #triplet

if [ $MASS -lt 1200 ] #600-1100
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWV13CARD &> $COMBJJLVJHVT13
      
elif [ $MASS -le 4000 ] #1200-4000
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWV13CARD $COMBJJWV13CARD &> $COMBJJLVJHVT13
fi  
