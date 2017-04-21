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
ZZ13DIR="ZZ_cards_13TeV"
WW8DIR="WW_cards"
WW13DIR="WW_cards_13TeV"
LOWMASSWW13DIR="WWlowmass_cards_13TeV/"
JJ8DIR="JJ_cards"
JJ13DIR="JJ_cards_13TeV"
TTJZH8DIR="cards_ZH_8TeV"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/


### ZZ8 only
LABEL="xzz"
EXOZZ8LPCARDS="${LABEL}_ee1JLP=${LABEL}_ee1JLP.${MASS}.txt ${LABEL}_mm1JLP=${LABEL}_mm1JLP.${MASS}.txt"
EXOZZ8HPCARDS="${LABEL}_ee1JHP=${LABEL}_ee1JHP.${MASS}.txt ${LABEL}_mm1JHP=${LABEL}_mm1JHP.${MASS}.txt"
EXOZZ8CARDS="$EXOZZ8HPCARDS $EXOZZ8LPCARDS"
COMBZZ8CARD="comb_${LABEL}.${MASS}.txt"
COMBFIXZZ8CARD="comb_${LABEL}_bulkfix.${MASS}.txt"

if [ $MASS -le 2500 ]
then
echo "Moving to "${ZZ8DIR}/
cd ${ZZ8DIR}/
pwd
combineCards.py $EXOZZ8CARDS &> ${COMBZZ8CARD}
cd -
python adapt_xsec_ZZ.py ${MASS}
cp ${ZZ8DIR}/${COMBFIXZZ8CARD} ${OUTDIR}/${COMBZZ8CARD}
cp ${ZZ8DIR}/${LABEL}_*input*.root  ${OUTDIR}/
fi

### ZH8 only
LABEL="xzh"
TTJZH8CARD="datacard_${MASS}_interpolate_BulkGadapt.txt"
COMBTTJZH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
then
python adapt_xsec_ttjZH_8TeV.py ${MASS}
sed -e 's|lumi|lumi_8TeV|g' -e 's|PUReweighting|CMS_pu|g' -e 's|VTag|CMS_eff_tau21_sf|g' -e 's|EleScale|CMS_scale_e|g' -e 's|EleResol|CMS_res_e|g' -e 's|MuoScale|CMS_scale_m|g' -e 's|MuoResol|CMS_res_m|g' -e 's|EleID|CMS_eff_e|g' -e 's|MuoID|CMS_eff_m|g' -e 's|JES|CMS_scale_j|g' -e 's|JER|CMS_res_j|g' -e 's|BTagSyst|CMS_btagger|g' < ${TTJZH8DIR}/${TTJZH8CARD} &> $OUTDIR/${COMBTTJZH8CARD}
fi

### JJ 8TeV only
LABEL="xjj8"
JJ8CARDORIG="CMS_jj_Bulkfix_${MASS}_8TeV_CMS_jj_VV.txt" ##Andreas gives us cards with WW and ZZ8 already merged
COMBJJ8CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ] && [ $MASS -le 2900 ]
then
python adapt_xsec_JJ.py ${MASS}
sed -e 's|datacards/../workspaces/||g' < ${JJ8DIR}/datacards/${JJ8CARDORIG} &> $OUTDIR/${COMBJJ8CARD}
    cp ${JJ8DIR}/workspaces/CMS_jj_Bulk*${MASS}*.root ${OUTDIR}/
    cp ${JJ8DIR}/workspaces/CMS_jj_bkg_8TeV.root ${OUTDIR}/
fi

### JJ 8TeV only
LABEL="xjj8ww"
JJ8CARDORIG="CMS_jj_BulkWWfix_${MASS}_8TeV_CMS_jj_VV.txt" ##Andreas gives us cards with WW and ZZ8 already merged
COMBJJWW8CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ] && [ $MASS -le 2900 ]
then
python adapt_xsec_JJ_BulkWW.py ${MASS}
sed -e 's|datacards/../workspaces/||g' < ${JJ8DIR}/datacards/${JJ8CARDORIG} &> $OUTDIR/${COMBJJWW8CARD}
    cp ${JJ8DIR}/workspaces/CMS_jj_Bulk*${MASS}*.root ${OUTDIR}/
    cp ${JJ8DIR}/workspaces/CMS_jj_bkg_8TeV.root ${OUTDIR}/
fi

### JJ 8TeV only
LABEL="xjj8zz"
JJ8CARDORIG="CMS_jj_BulkZZfix_${MASS}_8TeV_CMS_jj_VV.txt" ##Andreas gives us cards with WW and ZZ8 already merged
COMBJJZZ8CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ] && [ $MASS -le 2900 ]
then
python adapt_xsec_JJ_BulkZZ.py ${MASS}
sed -e 's|datacards/../workspaces/||g' < ${JJ8DIR}/datacards/${JJ8CARDORIG} &> $OUTDIR/${COMBJJZZ8CARD}
    cp ${JJ8DIR}/workspaces/CMS_jj_Bulk*${MASS}*.root ${OUTDIR}/
    cp ${JJ8DIR}/workspaces/CMS_jj_bkg_8TeV.root ${OUTDIR}/
fi

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

### WW only
LABEL="xww"
WW8BASE="wwlvj_BulkG_WW_inclusive_c0p2_M${MASS}"
WW8ELEBASE="${WW8BASE}_el_10_00"
WW8MUBASE="${WW8BASE}_mu_10_00"
EXOWW8LPCARDS="${LABEL}_ev1JLP=${WW8ELEBASE}_LP_unbin.txt ${LABEL}_mv1JLP=${WW8MUBASE}_LP_unbin.txt"
EXOWW8HPCARDS="${LABEL}_ev1JHP=${WW8ELEBASE}_HP_unbin.txt ${LABEL}_mv1JHP=${WW8MUBASE}_HP_unbin.txt"
EXOWW8CARDS="$EXOWW8HPCARDS $EXOWW8LPCARDS"
COMBWW8CARD="comb_${LABEL}.${MASS}.txt"
COMBFIXWW8CARD="comb_${LABEL}_bulkfix.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    cd ${WW8DIR}/
    combineCards.py $EXOWW8CARDS &> tmp_XWW8_card.txt
    sed -e 's|1.072/0.891|1.080/0.920|g'  -e 's|1.303/1.277|0.70/1.30|g' -e 's|CMS_xww_XS_VV|CMS_XS_VV|g' -e 's|CMS_xww_btag_eff|CMS_eff_b|g' -e 's|CMS_xww_trigger_e|CMS_trigger_e|g' -e 's|CMS_xww_trigger_m|CMS_trigger_m|g' -e 's|CMS_xww_XS_STop|CMS_XS_STop|g' < tmp_XWW8_card.txt  > ${COMBWW8CARD}
    cd -
    python adapt_xsec_WW.py ${MASS}
    cp ${WW8DIR}/${COMBFIXWW8CARD} ${OUTDIR}/${COMBWW8CARD}
    cp ${WW8DIR}/${WW8BASE}_*workspace.root  ${OUTDIR}/
fi

### WW 13 TeV only
LABEL="xww13"
EXOWW13CARDS="wwlvj_BulkGfix_WW_lvjj_M${MASS}_combo_ALLP_unbin.txt"
COMBWW13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -gt 800 ]
    then
    python adapt_xsec_WW_13TeV.py ${MASS}
    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|CMS_xww_btag_eff_13TeV|CMS_eff_b_13TeV|g' -e 's|CMS_xww_trigger_e_13TeV|CMS_trigger_e_13TeV|g' -e 's|CMS_xww_trigger_m_13TeV|CMS_trigger_m_13TeV|g' -e 's|CMS_xww_XS_STop_13TeV|CMS_XS_STop_13TeV|g' -e 's|CMS_xww_XS_VV_13TeV|CMS_XS_VV_13TeV|g' < ${WW13DIR}/${EXOWW13CARDS} &> $OUTDIR/${COMBWW13CARD}
    cp ${WW13DIR}/cards_mu_HPW/wwlvj_mu_HPW_workspace.root ${OUTDIR}/
    cp ${WW13DIR}/cards_mu_HPZ/wwlvj_mu_HPZ_workspace.root ${OUTDIR}/
    cp ${WW13DIR}/cards_el_HPW/wwlvj_el_HPW_workspace.root ${OUTDIR}/
    cp ${WW13DIR}/cards_el_HPZ/wwlvj_el_HPZ_workspace.root ${OUTDIR}/
    cp ${WW13DIR}/cards_*_HP*/wwlvj_BulkG_WW_lvjj_M${MASS}_*_workspace.root ${OUTDIR}/
else
    python adapt_xsec_WWlowmass_13TeV.py ${MASS}
    LOWMASSWW13CARDS="wwlvj_BulkGravitonFix${MASS}_em_HP_unbin.txt"
    sed -e 's|CMS_xww_btag_eff_13TeV|CMS_eff_b_13TeV|g' -e 's|CMS_xww_trigger_e_13TeV|CMS_trigger_e_13TeV|g' -e 's|CMS_xww_trigger_m_13TeV|CMS_trigger_m_13TeV|g' -e 's|CMS_xww_XS_STop_13TeV|CMS_XS_STop_13TeV|g' -e 's|CMS_xww_XS_VV_13TeV|CMS_XS_VV_13TeV|g' < ${LOWMASSWW13DIR}/${LOWMASSWW13CARDS} &> $OUTDIR/${COMBWW13CARD}
    #cp ${LOWMASSWW13DIR}/${LOWMASSWW13CARDS} ${OUTDIR}/${COMBWW13CARD}
    cp ${LOWMASSWW13DIR}/wwlvj_BulkGraviton${MASS}_*_workspace.root ${OUTDIR}/
fi

#if [ $MASS -ge 800 ]
#    then
#    python adapt_xsec_WW_13TeV.py ${MASS}
#    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HP/||g' -e 's|cards_mu_LP/||g' -e 's|cards_el_HP/||g' -e 's|cards_el_LP/||g' -e 's|cards_mu_HPZ/||g'  -e 's|cards_mu_LPW/||g' -e 's|cards_mu_LPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|cards_el_LPW/||g' -e 's|cards_el_LPZ/||g' < ${WW13DIR}/${EXOWW13CARDS} &> $OUTDIR/${COMBWW13CARD}
#    cp ${WW13DIR}/cards_*/*.root ${OUTDIR}/
#fi

###put things together
cd $OUTDIR/

#8 TeV BulkG
COMBALL8CARD="comb_ALL8.${MASS}.txt"
#13 TeV BulkG
COMBALL13CARD="comb_ALL13.${MASS}.txt"
#8+13 TeV BulkG
COMBALL813CARD="comb_ALL813.${MASS}.txt"
COMBJJ13CARD="comb_xjj13.${MASS}.txt"

if [ $MASS -lt 800 ] #600-700
    then
    
    #8 TeV BulkG
    combineCards.py $COMBZZ8CARD &> $COMBALL8CARD

    #13 TeV BulkG
    combineCards.py $COMBWW13CARD &> $COMBALL13CARD
    
    #8+13 TeV BulkG
    combineCards.py $COMBZZ8CARD $COMBWW13CARD &> $COMBALL813CARD
        
elif [ $MASS -lt 1000 ] #800-900
    then

    #8TeV BulkG
    combineCards.py $COMBZZ8CARD $COMBWW8CARD &> $COMBALL8CARD

    #13 TeV BulkG
    combineCards.py $COMBWW13CARD &> $COMBALL13CARD
    
    #8+13 TeV BulkG
    combineCards.py $COMBZZ8CARD $COMBWW8CARD $COMBWW13CARD &> $COMBALL813CARD
        
elif [ $MASS -lt 1200 ] #1000-1100
    then

    #8TeV BulkG
    combineCards.py $COMBZZ8CARD $COMBWW8CARD $COMBJJ8CARD &> $COMBALL8CARD

    #13 TeV BulkG
    combineCards.py $COMBWW13CARD &> $COMBALL13CARD
    
    #8+13 TeV BulkG
    combineCards.py $COMBZZ8CARD $COMBWW8CARD $COMBJJ8CARD $COMBWW13CARD &> $COMBALL813CARD
            
elif [ $MASS -le 2500 ] #1200-2500
    then

    #8TeV BulkG
    combineCards.py $COMBZZ8CARD $COMBWW8CARD $COMBJJ8CARD &> $COMBALL8CARD

    #13 TeV BulkG
    combineCards.py $COMBWW13CARD $COMBJJ13CARD &> $COMBALL13CARD
    
    #8+13 TeV BulkG
    combineCards.py $COMBZZ8CARD $COMBWW8CARD $COMBJJ8CARD $COMBWW13CARD $COMBJJ13CARD &> $COMBALL813CARD
        
elif [ $MASS -le 2900 ] #2600-2900
    then

    #8TeV BulkG
    combineCards.py $COMBJJ8CARD &> $COMBALL8CARD

    #13 TeV BulkG
    combineCards.py $COMBWW13CARD $COMBJJ13CARD &> $COMBALL13CARD
    
    #8+13 TeV BulkG
    combineCards.py $COMBJJ8CARD $COMBWW13CARD $COMBJJ13CARD &> $COMBALL813CARD
        
else #3000-4000

    #13 TeV BulkG
    combineCards.py $COMBWW13CARD $COMBJJ13CARD &> $COMBALL13CARD
    
    #8+13 TeV BulkG
    combineCards.py $COMBWW13CARD $COMBJJ13CARD &> $COMBALL813CARD
    
fi
