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
LVJWH13DIR="cards_VH_leptons_13TeV"
LOWMASSLVJ13DIR="LVJlowmass_cards_13TeV"
JJ8DIR="JJ_cards_8TeV"
LLJ8DIR="LLJ_cards_8TeV"
TTJZH8DIR="cards_ZH_8TeV"
LVJWH8DIR="cards_WH_8TeV"
JJVH8DIR="cards_VH_8TeV"
LLLV8DIR="cards_WZ_allLept_8TeV"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/

### lllv WprimeWZ 8 TeV only
LABEL="lllv8"
LLLV8CARD="card_WprimeWZfix_M${MASS}.txt"
COMBLLLV8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 600 ] && [ $MASS -ne 750 ] && [ $MASS -le 2000 ]
then
python adapt_xsec_lllvWZ_8TeV.py ${MASS}
sed -e 's|lumi|lumi_8TeV|g' -e 's|PU|CMS_pu|g' -e 's|ElTrig|CMS_xzz_trigger_e|g' -e 's|MuTrig|CMS_xzz_trigger_m|g' -e 's|ElEnScale|CMS_scale_e|g' -e 's|MuPtScale|CMS_scale_m|g' -e 's|MuPtRes|CMS_res_m|g' -e 's|ElIDIso|CMS_eff_e|g' -e 's|MuIDIso|CMS_eff_m|g' < ${LLLV8DIR}/${LLLV8CARD} &> $OUTDIR/${COMBLLLV8CARD}
fi

### qqtautau WprimeWH 8 TeV only
LABEL="ttjwh8"
TTJWH8CARD="datacard_${MASS}_interpolate_WHadapt.txt"
COMBTTJWH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
then
python adapt_xsec_ttjWH_8TeV.py ${MASS}
sed -e 's|lumi|lumi_8TeV|g' -e 's|PUReweighting|CMS_pu|g' -e 's|VTag|CMS_eff_vtag_tau21_sf|g' -e 's|EleScale|CMS_scale_e|g' -e 's|EleResol|CMS_res_e|g' -e 's|MuoScale|CMS_scale_m|g' -e 's|MuoResol|CMS_res_m|g' -e 's|EleID|CMS_eff_e|g' -e 's|MuoID|CMS_eff_m|g' -e 's|JES|CMS_scale_j|g' -e 's|JER|CMS_res_j|g' -e 's|BTagSyst|CMS_eff_b|g' < ${TTJZH8DIR}/${TTJWH8CARD} &> $OUTDIR/${COMBTTJWH8CARD}
fi

### JJ WprimeWH 8 TeV only
LABEL="jjwh8"
JJWH8CARD="CMS_jj_HWqq_${MASS}_8TeV_CMS_jj_HWOnly_adapt.txt"
COMBJJWH8CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ] && [ $MASS -le 2600 ]
then
python adapt_xsec_jjWH_8TeV.py ${MASS}
sed -e 's|datacards/../workspaces/||g' -e 's|datacards/../HbbVqqHwwworkspaces/||g' -e 's|CMS_eff_tau21_sf|CMS_eff_vtag_tau21_sf|g' -e 's|CMS_Btagging|CMS_doubleBtagging|g' < ${JJVH8DIR}/${JJWH8CARD} &> $OUTDIR/${COMBJJWH8CARD}
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
COMBFIXLVJWH8CARD="combFix_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    cd ${LVJWH8DIR}/
    combineCards.py $LVJWH8CARDS &> ${COMBLVJWH8CARD}
    cd -
    python adapt_xsec_lvjWH_8TeV.py ${MASS}
    sed -e 's|cards_mu/||g'  -e 's|cards_el/||g'   -e 's|CMS_xwh_prunedmass|CMS_jet_mass|g' -e 's|CMS_xwh_btag_eff|CMS_doubleBtagging|g' -e 's|CMS_xwh_btagger|CMS_eff_b|g' -e 's|CMS_xwh_trigger_e|CMS_trigger_e|g' -e 's|CMS_xwh_trigger_m|CMS_trigger_m|g' -e 's|CMS_xwh_XS_STop|CMS_XS_STop|g' -e 's|CMS_xwh_XS_VV|CMS_XS_VV|g' < ${LVJWH8DIR}/${COMBFIXLVJWH8CARD} > ${OUTDIR}/${COMBLVJWH8CARD}
    #cp ${LVJWH8DIR}/${COMBLVJWH8CARD} ${OUTDIR}/${COMBLVJWH8CARD}
    cp ${LVJWH8DIR}/cards_el/${LVJWH8BASE}_*workspace.root  ${OUTDIR}/
    cp ${LVJWH8DIR}/cards_mu/${LVJWH8BASE}_*workspace.root  ${OUTDIR}/
    #python comb_lvjwh8.py ${MASS}
fi

### LVJ Wprime 8 TeV only
LABEL="lvjwz8"
LVJWZ8CARD="comb_xww.${MASS}.txt"
COMBLVJWZ8CARD="comb_${LABEL}.${MASS}.txt"
WW8BASE="wwlvj_BulkG_WW_inclusive_c0p2_M${MASS}"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    python adapt_xsec_lvjWZ_8TeV.py ${MASS}
    sed -e 's|CMS_xww_XS_VV|CMS_XS_VV|g' -e 's|CMS_xww_btag_eff|CMS_eff_b|g' -e 's|CMS_xww_trigger_e|CMS_trigger_e|g' -e 's|CMS_xww_trigger_m|CMS_trigger_m|g' -e 's|CMS_xww_XS_STop|CMS_XS_STop|g' < ${LVJ8DIR}/${COMBLVJWZ8CARD} &> $OUTDIR/${COMBLVJWZ8CARD}   
    #cp ${LVJ8DIR}/${COMBLVJWZ8CARD} ${OUTDIR}/
    cp ${LVJ8DIR}/${WW8BASE}_*workspace.root ${OUTDIR}/
fi

### LVJ WprimeWZ/WH 13 TeV only
LABEL="lvjwzh13"
LVJWZH13CARD="wwlvj_Wprimefix_WZ_WH_lvjj_M${MASS}_combo_ALLP_unbin.txt"
COMBLVJWZH13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ]
    then
    python adapt_xsec_lvjWZ_WH_13TeV.py ${MASS}
    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|CMS_xww_btag_eff_13TeV|CMS_eff_b_13TeV|g' -e 's|CMS_xww_trigger_e_13TeV|CMS_trigger_e_13TeV|g' -e 's|CMS_xww_trigger_m_13TeV|CMS_trigger_m_13TeV|g' -e 's|CMS_xww_XS_STop_13TeV|CMS_XS_STop_13TeV|g' -e 's|CMS_xww_XS_VV_13TeV|CMS_XS_VV_13TeV|g' < ${LVJ13DIR}/${LVJWZH13CARD} &> $OUTDIR/${COMBLVJWZH13CARD}
    cp ${LVJ13DIR}/cards_mu_HPW/wwlvj_mu_HPW_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_mu_HPZ/wwlvj_mu_HPZ_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_el_HPW/wwlvj_el_HPW_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_el_HPZ/wwlvj_el_HPZ_workspace.root ${OUTDIR}/
    cp ${LVJ13DIR}/cards_*_*/wwlvj_Wprime_WZ_lvjj_M${MASS}_*_workspace.root ${OUTDIR}/
else
    python adapt_xsec_lvjWWlowmass_13TeV.py ${MASS}
    LOWMASSLVJ13CARDS="wwlvj_WprimeFix${MASS}_em_HP_unbin.txt"
    sed -e 's|CMS_xww_btag_eff_13TeV|CMS_eff_b_13TeV|g' -e 's|CMS_xww_trigger_e_13TeV|CMS_trigger_e_13TeV|g' -e 's|CMS_xww_trigger_m_13TeV|CMS_trigger_m_13TeV|g' -e 's|CMS_xww_XS_STop_13TeV|CMS_XS_STop_13TeV|g' -e 's|CMS_xww_XS_VV_13TeV|CMS_XS_VV_13TeV|g' < ${LOWMASSLVJ13DIR}/${LOWMASSLVJ13CARDS} &> $OUTDIR/${COMBLVJWZH13CARD}
    #cp ${LOWMASSLVJ13DIR}/${LOWMASSLVJ13CARDS} ${OUTDIR}/${COMBLVJWZH13CARD}
    cp ${LOWMASSLVJ13DIR}/wwlvj_Wprime${MASS}_*_workspace.root ${OUTDIR}/
fi

### JJ WprimeWZ/WH 8 TeV only
LABEL="jjwzwh8"
JJWZWH8CARD="CMS_jj_Wprimefix_WZ_WH_${MASS}_8TeV_CMS_jj_VV.txt"
COMBJJWZWH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 1000 ] && [ $MASS -lt 3000 ]
    then
    python adapt_xsec_jjWZ_WH_8TeV.py ${MASS}
    sed -e 's|datacards/../workspaces/||g' -e 's|CMS_jj_bkg_8TeV|CMS_jj_bkg_WZ_8TeV|g' < ${JJ8DIR}/datacards/${JJWZWH8CARD} &> $OUTDIR/${COMBJJWZWH8CARD}
    cp ${JJ8DIR}/workspaces/CMS_jj_WZ*${MASS}*.root ${OUTDIR}/
    cp ${JJ8DIR}/workspaces/CMS_jj_bkg_8TeV.root ${OUTDIR}/CMS_jj_bkg_WZ_8TeV.root
fi

### JJ WprimeWZ/WH 13 TeV only
LABEL="jjwzwh13"
JJWZWH13CARD="CMS_jj_Wprimefix_WZ_WH_${MASS}_13TeV_CMS_jj_VV.txt"
COMBJJWZWH13CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
    python adapt_xsec_jjWZ_WH_13TeV.py ${MASS}
    sed -e 's|datacards_withPDFuncertainties/../workspaces/||g' -e 's|datacards_backup/../workspaces/||g' -e 's|datacards/../workspaces/||g' -e 's|../workspaces/||g' < ${JJ13DIR}/${JJWZWH13CARD} &> $OUTDIR/${COMBJJWZWH13CARD}
    cp ${JJ13DIR}/CMS_jj_WZ_*${MASS}*.root ${OUTDIR}/.
    cp ${JJ13DIR}/CMS_jj_bkg_13TeV.root ${OUTDIR}/.
fi

### LVJ WprimeWH 13 TeV only NEW!!
LABEL="lvjwh13"
LVJWH13CARD="XWhFix_M${MASS}.txt"
COMBLVJWH13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ]
    then
    python adapt_xsec_lvjWH_13TeV.py ${MASS}
    sed -e 's|workspaces/||g' -e 's|QCD_scale |CMS_XS_qq_scale |g' -e 's|CMS_scale_pu_13TeV|CMS_pu_13TeV|g' -e 's|pdf_xsec|CMS_XS_qq_PDF|g' -e 's|CMS_xsec_VV|CMS_XS_VV_13TeV|g' < ${LVJWH13DIR}/datacards/${LVJWH13CARD} &> $OUTDIR/${COMBLVJWH13CARD}
    #sed -e 's|workspaces/||g' < ${LVJWH13DIR}/datacards/${LVJWH13CARD} &> $OUTDIR/${COMBLVJWH13CARD}
    cp ${LVJWH13DIR}/workspaces/XWh*.root ${OUTDIR}/
fi

### LLJ WprimeWZ 8 TeV only
LABEL="lljwz8"
LLJWZ8CARD="comb_xzz.${MASS}.txt"
COMBLLJWZ8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 600 ] && [ $MASS -ne 750 ] && [ $MASS -le 2500 ]
    then
    python adapt_xsec_lljWZ_8TeV.py ${MASS}
    cp ${LLJ8DIR}/${MASS}/${COMBLLJWZ8CARD} ${OUTDIR}/
    cp ${LLJ8DIR}/${MASS}/*HP.input*.root  ${OUTDIR}/
fi

###put things together
cd $OUTDIR/

# 13 TeV LVJ+JJ
COMBJJLVJWPRIME13="comb_JJLVJWPRIME13.${MASS}.txt" #charged singlet
# 13 TeV LVJ+JJ+LVbb
COMBALLWPRIME13="comb_ALLWPRIME13.${MASS}.txt" #charged singlet
# 8 TeV LLLV+LLJ+LVJ+JJ (WV)
COMBALLWVWPRIME8="comb_ALLWVWPRIME8.${MASS}.txt" #charged singlet
#8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
COMBALLWVWPRIME138="comb_ALLWVWPRIME138.${MASS}.txt" #charged singlet
#8 TeV VH only
COMBALLHVWPRIME8="comb_ALLHVWPRIME8.${MASS}.txt" #charged singlet
#8+13 TeV VH only
COMBALLHVWPRIME138="comb_ALLHVWPRIME138.${MASS}.txt" #charged singlet
#8 TeV VH+WV
COMBALLWPRIME8="comb_ALLWPRIME8.${MASS}.txt" #charged singlet
#8 + 13 TeV VH+WV
COMBALLWPRIME138="comb_ALLWPRIME138.${MASS}.txt" #charged singlet

if [ $MASS -lt 750 ] #600-700
    then
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLJWZ8CARD $COMBLLLV8CARD &> $COMBALLWVWPRIME8

    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLJWZ8CARD $COMBLLLV8CARD $COMBLVJWZH13CARD &> $COMBALLWVWPRIME138

    #8 TeV VH+WV
    combineCards.py $COMBLLJWZ8CARD $COMBLLLV8CARD &> $COMBALLWPRIME8

    #8 + 13 TeV VH+WV
    combineCards.py $COMBLLJWZ8CARD $COMBLLLV8CARD $COMBLVJWZH13CARD &> $COMBALLWPRIME138

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD &> $COMBALLWPRIME13
            
elif [ $MASS -lt 800 ] #750
    then

    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWZH13CARD &> $COMBALLWVWPRIME138

    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWZH13CARD &> $COMBALLWPRIME138

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD &> $COMBALLWPRIME13
                      
elif [ $MASS -lt 1000 ] #800-900
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME13
        
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBLLLV8CARD &> $COMBALLWVWPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBLLLV8CARD $COMBLVJWZH13CARD &> $COMBALLWVWPRIME138
    
    #8 TeV VH only
    combineCards.py $COMBTTJWH8CARD $COMBLVJWH8CARD &> $COMBALLHVWPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBLVJWH13CARD &> $COMBALLHVWPRIME138
        
    #8 TeV VH+WV
    combineCards.py $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBLLLV8CARD $COMBTTJWH8CARD $COMBLVJWH8CARD &> $COMBALLWPRIME8
      
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBLLLV8CARD $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBLVJWZH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME138
      
elif [ $MASS -lt 1200 ] #1000-1100
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLLV8CARD $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD &> $COMBALLWVWPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLLV8CARD $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBLVJWZH13CARD &> $COMBALLWVWPRIME138
    
    #8 TeV VH only
    combineCards.py $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD &> $COMBALLHVWPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD $COMBLVJWH13CARD &> $COMBALLHVWPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBLLLV8CARD $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD &> $COMBALLWPRIME8

    #8 + 13 TeV VH+WV  
    combineCards.py $COMBLLLV8CARD $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD $COMBLVJWZH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME138

elif [ $MASS -le 2000 ] #1200-2000
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLLV8CARD $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD &> $COMBALLWVWPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLLV8CARD $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBALLWVWPRIME138

    #8 TeV VH only
    combineCards.py $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD &> $COMBALLHVWPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD $COMBLVJWH13CARD &> $COMBALLHVWPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBLLLV8CARD $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD &> $COMBALLWPRIME8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLLLV8CARD $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME138 
                 
elif [ $MASS -le 2500 ] #2100-2500
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD &> $COMBALLWVWPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBALLWVWPRIME138

    #8 TeV VH only
    combineCards.py $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD &> $COMBALLHVWPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD $COMBLVJWH13CARD &> $COMBALLHVWPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD &> $COMBALLWPRIME8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWZ8CARD $COMBLLJWZ8CARD $COMBJJWZWH8CARD $COMBTTJWH8CARD $COMBLVJWH8CARD $COMBJJWH8CARD $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME138 
                 
elif [ $MASS -le 2600 ] #2600
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWZWH8CARD &> $COMBALLWVWPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWZWH8CARD $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBALLWVWPRIME138

    #8 TeV VH only
    combineCards.py $COMBJJWH8CARD &> $COMBALLHVWPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBJJWH8CARD $COMBLVJWH13CARD &> $COMBALLHVWPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBJJWZWH8CARD $COMBJJWH8CARD &> $COMBALLWPRIME8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBJJWZWH8CARD $COMBJJWH8CARD $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME138
                         
elif [ $MASS -lt 3000 ] #2700-2900
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWZWH8CARD &> $COMBALLWVWPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWZWH8CARD $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBALLWVWPRIME138

    #8 TeV VH+WV
    combineCards.py $COMBJJWZWH8CARD &> $COMBALLWPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBLVJWH13CARD &> $COMBALLHVWPRIME138
        
    #8 + 13 TeV VH+WV
    combineCards.py $COMBJJWZWH8CARD $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME138
     
elif [ $MASS -le 4000 ] #3000-4000
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBJJLVJWPRIME13

    # 13 TeV LVJ+JJ+LVbb
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME13
        
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD &> $COMBALLWVWPRIME138

    #8+13 TeV VH only
    combineCards.py $COMBLVJWH13CARD &> $COMBALLHVWPRIME138
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWZH13CARD $COMBJJWZWH13CARD $COMBLVJWH13CARD &> $COMBALLWPRIME138
     
fi  
