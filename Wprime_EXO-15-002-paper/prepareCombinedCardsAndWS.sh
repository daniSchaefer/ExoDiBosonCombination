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

### LVJ WprimeWZ 13 TeV only
LABEL="lvjwz13"
LVJWZ13CARD="wwlvj_Wprimefix_WZ_lvjj_M${MASS}_combo_ALLP_unbin.txt"
COMBLVJWZ13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ]
    then
    python adapt_xsec_lvjWZ_13TeV.py ${MASS}
    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HPZ/||g'  -e 's|cards_mu_LPW/||g' -e 's|cards_mu_LPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|cards_el_LPW/||g' -e 's|cards_el_LPZ/||g' < ${LVJ13DIR}/${LVJWZ13CARD} &> $OUTDIR/${COMBLVJWZ13CARD}
    cp ${LVJ13DIR}/cards_mu_HPW/wwlvj_mu_HPW_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_mu_HPZ/wwlvj_mu_HPZ_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_el_HPW/wwlvj_el_HPW_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_el_HPZ/wwlvj_el_HPZ_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_*_*/wwlvj_Wprime_WZ_lvjj_M${MASS}_*_workspace.root ${OUTDIR}/
else
    python adapt_xsec_lvjWWlowmass_13TeV.py ${MASS}
    LOWMASSLVJ13CARDS="wwlvj_WprimeFix${MASS}_em_HP_unbin.txt"
    cp ${LOWMASSLVJ13DIR}/${LOWMASSLVJ13CARDS} ${OUTDIR}/${COMBLVJWZ13CARD}
    cp ${LOWMASSLVJ13DIR}/wwlvj_Wprime${MASS}_*_workspace.root ${OUTDIR}/
fi

### JJ WprimeWZ 13 TeV only
LABEL="jjwz13"
JJWZ13CARD="CMS_jj_Wprimefix_WZ_${MASS}_13TeV_CMS_jj_VV.txt"
COMBJJWZ13CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
    python adapt_xsec_jjWZ_13TeV.py ${MASS}
    sed -e 's|datacards_withPDFuncertainties/../workspaces/||g' -e 's|datacards_backup/../workspaces/||g' -e 's|datacards/../workspaces/||g' -e 's|../workspaces/||g' < ${JJ13DIR}/${JJWZ13CARD} &> $OUTDIR/${COMBJJWZ13CARD}
    cp ${JJ13DIR}/CMS_jj_WZ_*${MASS}*.root ${OUTDIR}/.
    cp ${JJ13DIR}/CMS_jj_bkg_13TeV.root ${OUTDIR}/.
fi

###put things together
cd $OUTDIR/

# 13 TeV LVJ+JJ
COMBJJLVJWPRIME13="comb_JJLVJWPRIME13.${MASS}.txt" #charged singlet

if [ $MASS -lt 1200 ] #800-1100
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZ13CARD &> $COMBJJLVJWPRIME13
      
elif [ $MASS -le 4000 ] #1200-4000
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZ13CARD $COMBJJWZ13CARD &> $COMBJJLVJWPRIME13
fi  
