#! /bin/bash

# define input
if [ $# -lt 1 ]
    then
    echo "Need one input: mass point"
    exit 1
fi

MASS=$1
echo "Merging M=${MASS}"
LVJ8DIR="LVJ_cards_8TeV"
LVJ13DIR="LVJ_cards_13TeV"
JJ13DIR="JJ_cards_13TeV"
LEPTVH13DIR="cards_VH_leptons_13TeV"
JJ8DIR="JJ_cards_8TeV"
LLJ8DIR="LLJ_cards_8TeV"
TTJZH8DIR="cards_ZH_8TeV"
LVJWH8DIR="cards_WH_8TeV"
JJVH8DIR="cards_VH_8TeV"
LLLV8DIR="cards_WZ_allLept_8TeV"
LOWMASSLVJ13DIR="LVJlowmass_cards_13TeV"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/

### lllv WprimeWZ 8 TeV only
LABEL="lllv8"
LLLV8CARD="card_WprimeWZfix_M${MASS}.txt"
COMBLLLV8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 600 ] && [ $MASS -le 2000 ]
then
python adapt_xsec_lllvWZ_8TeV.py ${MASS}
sed -e 's|lumi|lumi_8TeV|g' -e 's|PU|CMS_pu|g' -e 's|ElTrig|CMS_xzz_trigger_e|g' -e 's|MuTrig|CMS_xzz_trigger_m|g' -e 's|ElEnScale|CMS_scale_e|g' -e 's|MuPtScale|CMS_scale_m|g' -e 's|MuPtRes|CMS_res_m|g' -e 's|ElIDIso|CMS_eff_e|g' -e 's|MuIDIso|CMS_eff_m|g' < ${LLLV8DIR}/${LLLV8CARD} &> $OUTDIR/${COMBLLLV8CARD}
fi

### qqtautau VprimeVH 8 TeV only
LABEL="ttjvh8"
TTJVH8CARD="datacard_${MASS}_interpolate_VHadapt.txt"
COMBTTJVH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
then
python adapt_xsec_ttjVH_8TeV.py ${MASS}
sed -e 's|lumi|lumi_8TeV|g' -e 's|PUReweighting|CMS_pu|g' -e 's|VTag|CMS_eff_vtag_tau21_sf|g' -e 's|EleScale|CMS_scale_e|g' -e 's|EleResol|CMS_res_e|g' -e 's|MuoScale|CMS_scale_m|g' -e 's|MuoResol|CMS_res_m|g' -e 's|EleID|CMS_eff_e|g' -e 's|MuoID|CMS_eff_m|g' -e 's|JES|CMS_scale_j|g' -e 's|JER|CMS_res_j|g' -e 's|BTagSyst|CMS_eff_b|g' < ${TTJZH8DIR}/${TTJVH8CARD} &> $OUTDIR/${COMBTTJVH8CARD}
fi

### JJ VprimeVH 8 TeV only
LABEL="jjvh8"
JJVH8CARD="CMS_jj_HVqq_${MASS}_8TeV_CMS_jj_HVCombined_adapt.txt"
COMBJJVH8CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ] && [ $MASS -le 2600 ]
then
python adapt_xsec_jjVH_8TeV.py ${MASS}
sed -e 's|datacards/../workspaces/||g' -e 's|datacards/../HbbVqqHwwworkspaces/||g' -e 's|CMS_eff_tau21_sf|CMS_eff_vtag_tau21_sf|g' -e 's|CMS_Btagging|CMS_doubleBtagging|g' < ${JJVH8DIR}/${JJVH8CARD} &> $OUTDIR/${COMBJJVH8CARD}
cp ${JJVH8DIR}/CMS_jj_*${MASS}*.root ${OUTDIR}/
cp ${JJVH8DIR}/CMS_jj_bkg_8TeV.root ${OUTDIR}/
fi    

### LVJ WprimeWH 8 TeV only
LABEL="lvjwh8"
LVJWH8BASE="whlvj_MWp_${MASS}_bb"
LVJWH8ELEBASE="cards_el/${LVJWH8BASE}_el"
LVJWH8MUBASE="cards_mu/${LVJWH8BASE}_mu"
LVJWH8CARDS="${LABEL}_mv1JLP=${LVJWH8MUBASE}_ALLP_unbin.txt ${LABEL}_ev1JLP=${LVJWH8ELEBASE}_ALLP_unbin.txt"
COMBLVJWH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    cd ${LVJWH8DIR}/
    combineCards.py $LVJWH8CARDS &> tmp_XWH_card.txt
    sed -e 's|cards_mu/||g' -e 's|cards_el/||g' -e 's|CMS_xwh_prunedmass|CMS_jet_mass|g' -e 's|CMS_xwh_btag_eff|CMS_doubleBtagging|g' -e 's|CMS_xwh_btagger|CMS_eff_b|g' -e 's|CMS_xwh_trigger_e|CMS_trigger_e|g' -e 's|CMS_xwh_trigger_m|CMS_trigger_m|g' -e 's|CMS_xwh_XS_STop|CMS_XS_STop|g' -e 's|CMS_xwh_XS_VV|CMS_XS_VV|g' < tmp_XWH_card.txt  > ${COMBLVJWH8CARD}
    cd -
    cp ${LVJWH8DIR}/${COMBLVJWH8CARD} ${OUTDIR}/${COMBLVJWH8CARD}
    cp ${LVJWH8DIR}/cards_el/${LVJWH8BASE}_*workspace.root  ${OUTDIR}/
    cp ${LVJWH8DIR}/cards_mu/${LVJWH8BASE}_*workspace.root  ${OUTDIR}/
    python comb_lvjwh8.py ${MASS}
fi

### LVJ Vprime 8 TeV only
LABEL="lvjwv8"
LVJWV8CARD="comb_xww.${MASS}.txt"
COMBLVJWV8CARD="comb_${LABEL}.${MASS}.txt"
WW8BASE="wwlvj_BulkG_WW_inclusive_c0p2_M${MASS}"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    python adapt_xsec_lvjWV_8TeV.py ${MASS}
    sed -e 's|CMS_xww_XS_VV|CMS_XS_VV|g' -e 's|CMS_xww_btag_eff|CMS_eff_b|g' -e 's|CMS_xww_trigger_e|CMS_trigger_e|g' -e 's|CMS_xww_trigger_m|CMS_trigger_m|g' -e 's|CMS_xww_XS_STop|CMS_XS_STop|g' < ${LVJ8DIR}/${COMBLVJWV8CARD} &> $OUTDIR/${COMBLVJWV8CARD}
    #cp ${LVJ8DIR}/${COMBLVJWV8CARD} ${OUTDIR}/
    cp ${LVJ8DIR}/${WW8BASE}_*workspace.root ${OUTDIR}/
fi

### LVJ VprimeWV/WH 13 TeV only
LABEL="lvjwvh13"
LVJWVH13CARD="wwlvj_Vprimefix_WV_VH_lvjj_M${MASS}_combo_ALLP_unbin.txt"
COMBLVJWVH13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 900 ]
    then
    python adapt_xsec_lvjWV_VH_13TeV.py ${MASS}
    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|CMS_xww_btag_eff_13TeV|CMS_eff_b_13TeV|g' -e 's|CMS_xww_trigger_e_13TeV|CMS_trigger_e_13TeV|g' -e 's|CMS_xww_trigger_m_13TeV|CMS_trigger_m_13TeV|g' -e 's|CMS_xww_XS_STop_13TeV|CMS_XS_STop_13TeV|g' -e 's|CMS_xww_XS_VV_13TeV|CMS_XS_VV_13TeV|g' < ${LVJ13DIR}/${LVJWVH13CARD} &> $OUTDIR/${COMBLVJWVH13CARD}
    cp ${LVJ13DIR}/cards_mu_HPW/wwlvj_mu_HPW_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_mu_HPZ/wwlvj_mu_HPZ_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_el_HPW/wwlvj_el_HPW_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_el_HPZ/wwlvj_el_HPZ_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_*/wwlvj_Zprime_WW_lvjj_M${MASS}_*_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_*/wwlvj_Wprime_WZ_lvjj_M${MASS}_*_workspace.root ${OUTDIR}/
else
    python adapt_xsec_lvjWWlowmass_13TeV.py ${MASS}
    LOWMASSLVJ13CARDS="wwlvj_VprimeFix${MASS}_em_HP_unbin.txt"
    sed -e 's|CMS_xww_btag_eff_13TeV|CMS_eff_b_13TeV|g' -e 's|CMS_xww_trigger_e_13TeV|CMS_trigger_e_13TeV|g' -e 's|CMS_xww_trigger_m_13TeV|CMS_trigger_m_13TeV|g' -e 's|CMS_xww_XS_STop_13TeV|CMS_XS_STop_13TeV|g' -e 's|CMS_xww_XS_VV_13TeV|CMS_XS_VV_13TeV|g' < ${LOWMASSLVJ13DIR}/${LOWMASSLVJ13CARDS} &> ${OUTDIR}/${COMBLVJWVH13CARD}
    cp ${LOWMASSLVJ13DIR}/${LOWMASSLVJ13CARDS} ${OUTDIR}/${COMBLVJWV13CARD}
    cp ${LOWMASSLVJ13DIR}/wwlvj_Zprime${MASS}_*_workspace.root ${OUTDIR}/
    cp ${LOWMASSLVJ13DIR}/wwlvj_Wprime${MASS}_*_workspace.root ${OUTDIR}/
fi

#if [ $MASS -ge 800 ]
#    then
#    python adapt_xsec_lvjWV_VH_13TeV.py ${MASS}
#    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HPZ/||g'  -e 's|cards_mu_LPW/||g' -e 's|cards_mu_LPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|cards_el_LPW/||g' -e 's|cards_el_LPZ/||g' < ${LVJ13DIR}/${LVJWVH13CARD} &> $OUTDIR/${COMBLVJWVH13CARD}
#    cp ${LVJ13DIR}/cards_*/*_M${MASS}_*.root ${OUTDIR}/
#fi

### JJ VprimeWV/VH 8 TeV only
LABEL="jjwvvh8"
JJWVVH8CARD="CMS_jj_Vprimefix_WV_VH_${MASS}_8TeV_CMS_jj_VV.txt"
COMBJJWVVH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 1000 ] && [ $MASS -lt 3000 ]
    then
    python adapt_xsec_jjWV_VH_8TeV.py ${MASS}
    sed -e 's|datacards/../workspaces/||g' -e 's|CMS_jj_bkg_8TeV|CMS_jj_bkg_WZ_8TeV|g' < ${JJ8DIR}/datacards/${JJWVVH8CARD} &> $OUTDIR/${COMBJJWVVH8CARD}
    cp ${JJ8DIR}/workspaces/CMS_jj_WZ*${MASS}*.root ${OUTDIR}/
    cp ${JJ8DIR}/workspaces/CMS_jj_bkg_8TeV.root ${OUTDIR}/CMS_jj_bkg_WZ_8TeV.root
fi

### JJ VprimeWV/VH 13 TeV only
LABEL="jjwvvh13"
JJWVVH13CARD="CMS_jj_Vprimefix_WV_VH_${MASS}_13TeV.txt"
COMBJJWVVH13CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
    python adapt_xsec_jjWV_VH_13TeV.py ${MASS}
    sed -e 's|datacards_withPDFuncertainties/../workspaces/||g' -e 's|datacards_backup/../workspaces/||g' -e 's|datacards/../workspaces/||g' -e 's|../workspaces/||g' < ${JJ13DIR}/${JJWVVH13CARD} &> $OUTDIR/${COMBJJWVVH13CARD}
    cp ${JJ13DIR}/CMS_jj_ZprimeWW_*${MASS}*.root ${OUTDIR}/.
    cp ${JJ13DIR}/CMS_jj_WZ_*${MASS}*.root ${OUTDIR}/.
    cp ${JJ13DIR}/CMS_jj_bkg_13TeV.root ${OUTDIR}/.
fi

### LVJ,LLJ,NNJ VprimeVH 13 TeV only NEW!!
LABEL="leptvh13"
#LVJWH13CARD="${LEPTVH13DIR}/datacards/XWh_M${MASS}.txt"
#LLJZH13CARD="${LEPTVH13DIR}/datacards/XZh_M${MASS}.txt"
LEPTVH13CARD="XVh_M${MASS}.txt"
COMBLEPTVH13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ]
    then
    #combineCards.py $LVJWH13CARD $LLJZH13CARD &> ${LEPTVH13DIR}/datacards/XVh_M${MASS}.txt
    #python adapt_xsec_leptVH_13TeV.py ${MASS}
    sed -e 's|workspaces/||g' -e 's|QCD_scale |CMS_XS_qq_scale |g' -e 's|CMS_scale_pu_13TeV|CMS_pu_13TeV|g' -e 's|pdf_xsec|CMS_XS_qq_PDF|g' -e 's|CMS_xsec_VV|CMS_XS_VV_13TeV|g' < ${LEPTVH13DIR}/datacards/${LEPTVH13CARD} &> $OUTDIR/${COMBLEPTVH13CARD}
    cp ${LEPTVH13DIR}/workspaces/XZh*.root ${LEPTVH13DIR}/workspaces/XWh*.root ${OUTDIR}/
fi

### LLJ Vprime (WZ/ZH) 8 TeV only
LABEL="lljwzh8"
LLJWZH8CARD="comb_xzz.${MASS}.txt"
COMBLLJWZH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 600 ] && [ $MASS -le 2500 ]
    then
    python adapt_xsec_lljWZ_VH_8TeV.py ${MASS}
    cp ${LLJ8DIR}/${MASS}/${COMBLLJWZH8CARD} ${OUTDIR}/
    cp ${LLJ8DIR}/${MASS}/*HP.input*.root  ${OUTDIR}/
fi

###put things together
cd $OUTDIR/

# 13 TeV LVJ+JJ
COMBJJLVJHVT13="comb_JJLVJHVT13.${MASS}.txt" #triplet
# 13 TeV LVJ+JJ+LLBB+NNBB+LVBB
COMBALLHVT13="comb_ALLHVT13.${MASS}.txt" #triplet
# 8 TeV LLLV+LLJ+LVJ+JJ (WV)
COMBALLWVHVT8="comb_ALLWVHVT8.${MASS}.txt" #triplet
#8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
COMBALLWVHVT138="comb_ALLWVHVT138.${MASS}.txt" #triplet
#8 TeV VH only
COMBALLHVHVT8="comb_ALLHVHVT8.${MASS}.txt" #triplet
#8+13 TeV VH only
COMBALLHVHVT138="comb_ALLHVHVT138.${MASS}.txt" #triplet
#8 TeV VH+WV
COMBALLHVT8="comb_ALLHVT8.${MASS}.txt" #triplet
#8 + 13 TeV VH+WV
COMBALLHVT138="comb_ALLHVT138.${MASS}.txt" #triplet

if [ $MASS -lt 800 ] #600-700
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWVH13CARD &> $COMBJJLVJHVT13

    # 13 TeV LVJ+JJ+LLBB+NNBB+LVBB
    combineCards.py $COMBLVJWVH13CARD &> $COMBALLHVT13
            
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLJWZH8CARD $COMBLLLV8CARD &> $COMBALLWVHVT8

    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLJWZH8CARD $COMBLLLV8CARD $COMBLVJWVH13CARD &> $COMBALLWVHVT138

    #8 TeV VH+WV
    combineCards.py $COMBLLJWZH8CARD $COMBLLLV8CARD &> $COMBALLHVT8

    #8 + 13 TeV VH+WV
    combineCards.py $COMBLLJWZH8CARD $COMBLLLV8CARD $COMBLVJWVH13CARD &> $COMBALLHVT138
                
elif [ $MASS -lt 1000 ] #800-900
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWVH13CARD &> $COMBJJLVJHVT13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT13
        
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBLLLV8CARD &> $COMBALLWVHVT8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBLLLV8CARD $COMBLVJWVH13CARD &> $COMBALLWVHVT138
    
    #8 TeV VH only
    combineCards.py $COMBTTJVH8CARD $COMBLVJWH8CARD &> $COMBALLHVHVT8

    #8+13 TeV VH only
    combineCards.py $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBLEPTVH13CARD &> $COMBALLHVHVT138
        
    #8 TeV VH+WV
    combineCards.py $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBLLLV8CARD $COMBTTJVH8CARD $COMBLVJWH8CARD &> $COMBALLHVT8
      
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBLLLV8CARD $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBLVJWVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT138
      
elif [ $MASS -lt 1200 ] #1000-1100
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWVH13CARD &> $COMBJJLVJHVT13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLLV8CARD $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD &> $COMBALLWVHVT8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLLV8CARD $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBLVJWVH13CARD &> $COMBALLWVHVT138
    
    #8 TeV VH only
    combineCards.py $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD &> $COMBALLHVHVT8

    #8+13 TeV VH only
    combineCards.py $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD $COMBLEPTVH13CARD &> $COMBALLHVHVT138
    
    #8 TeV VH+WV
    combineCards.py $COMBLLLV8CARD $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD &> $COMBALLHVT8

    #8 + 13 TeV VH+WV  
    combineCards.py $COMBLLLV8CARD $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD $COMBLVJWVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT138    

elif [ $MASS -le 2000 ] #1200-2000
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBJJLVJHVT13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLLV8CARD $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD &> $COMBALLWVHVT8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLLV8CARD $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBALLWVHVT138

    #8 TeV VH only
    combineCards.py $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD &> $COMBALLHVHVT8

    #8+13 TeV VH only
    combineCards.py $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD $COMBLEPTVH13CARD &> $COMBALLHVHVT138
    
    #8 TeV VH+WV
    combineCards.py $COMBLLLV8CARD $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD &> $COMBALLHVT8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLLLV8CARD $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT138 
                 
elif [ $MASS -le 2500 ] #2100-2500
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBJJLVJHVT13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD &> $COMBALLWVHVT8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBALLWVHVT138

    #8 TeV VH only
    combineCards.py $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD &> $COMBALLHVHVT8

    #8+13 TeV VH only
    combineCards.py $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD $COMBLEPTVH13CARD &> $COMBALLHVHVT138
    
    #8 TeV VH+WV
    combineCards.py $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD &> $COMBALLHVT8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWV8CARD $COMBLLJWZH8CARD $COMBJJWVVH8CARD $COMBTTJVH8CARD $COMBLVJWH8CARD $COMBJJVH8CARD $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT138 
                 
elif [ $MASS -le 2600 ] #2600
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBJJLVJHVT13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWVVH8CARD &> $COMBALLWVHVT8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWVVH8CARD $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBALLWVHVT138

    #8 TeV VH only
    combineCards.py $COMBJJVH8CARD &> $COMBALLHVHVT8

    #8+13 TeV VH only
    combineCards.py $COMBJJVH8CARD $COMBLEPTVH13CARD &> $COMBALLHVHVT138
    
    #8 TeV VH+WV
    combineCards.py $COMBJJWVVH8CARD $COMBJJVH8CARD &> $COMBALLHVT8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBJJWVVH8CARD $COMBJJVH8CARD $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT138
                         
elif [ $MASS -lt 3000 ] #2700-2900
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBJJLVJHVT13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWVVH8CARD &> $COMBALLWVHVT8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWVVH8CARD $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBALLWVHVT138

    #8+13 TeV VH only
    combineCards.py $COMBLEPTVH13CARD &> $COMBALLHVHVT138
    
    #8 TeV VH+WV
    combineCards.py $COMBJJWVVH8CARD &> $COMBALLHVT8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBJJWVVH8CARD $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT138
    
elif [ $MASS -le 4000 ] #3000-4000
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBJJLVJHVT13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT13
        
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD &> $COMBALLWVHVT138

    #8+13 TeV VH only
    combineCards.py $COMBLEPTVH13CARD &> $COMBALLHVHVT138
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWVH13CARD $COMBJJWVVH13CARD $COMBLEPTVH13CARD &> $COMBALLHVT138
     
fi  
