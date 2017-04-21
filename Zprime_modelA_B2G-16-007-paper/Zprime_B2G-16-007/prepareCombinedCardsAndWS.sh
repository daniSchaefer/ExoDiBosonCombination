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
LLJZH13DIR="cards_VH_leptons_13TeV"
JJ8DIR="JJ_cards_8TeV"
LLJ8DIR="LLJ_cards_8TeV"
TTJZH8DIR="cards_ZH_8TeV"
LVJWH8DIR="cards_WH_8TeV"
JJVH8DIR="cards_VH_8TeV"
LLLV8DIR="cards_WZ_allLept_8TeV"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/

### qqtautau ZprimeZH 8 TeV only
LABEL="ttjzh8"
TTJZH8CARD="datacard_${MASS}_interpolate_ZHadapt.txt"
COMBTTJZH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
then
python adapt_xsec_ttjZH_8TeV.py ${MASS}
sed -e 's|lumi|lumi_8TeV|g' -e 's|PUReweighting|CMS_pu|g' -e 's|VTag|CMS_eff_vtag_tau21_sf|g' -e 's|EleScale|CMS_scale_e|g' -e 's|EleResol|CMS_res_e|g' -e 's|MuoScale|CMS_scale_m|g' -e 's|MuoResol|CMS_res_m|g' -e 's|EleID|CMS_eff_e|g' -e 's|MuoID|CMS_eff_m|g' -e 's|JES|CMS_scale_j|g' -e 's|JER|CMS_res_j|g' -e 's|BTagSyst|CMS_xww_btag_eff|g' < ${TTJZH8DIR}/${TTJZH8CARD} &> $OUTDIR/${COMBTTJZH8CARD}
fi

### JJ ZprimeZH 8 TeV only
LABEL="jjzh8"
JJZH8CARD="CMS_jj_HZqq_${MASS}_8TeV_CMS_jj_HZOnly_adapt.txt"
COMBJJZH8CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ] && [ $MASS -le 2600 ]
then
python adapt_xsec_jjZH_8TeV.py ${MASS}
sed -e 's|datacards/../workspaces/||g' -e 's|datacards/../HbbVqqHwwworkspaces/||g' -e 's|CMS_eff_tau21_sf|CMS_eff_vtag_tau21_sf|g' -e 's|CMS_Btagging|CMS_doubleBtagging|g' < ${JJVH8DIR}/${JJZH8CARD} &> $OUTDIR/${COMBJJZH8CARD}
cp ${JJVH8DIR}/CMS_jj_*${MASS}*.root ${OUTDIR}/
cp ${JJVH8DIR}/CMS_jj_bkg_8TeV.root ${OUTDIR}/
fi

### LVJ Zprime 8 TeV only
LABEL="lvjww8"
LVJWW8CARD="comb_xww.${MASS}.txt"
COMBLVJWW8CARD="comb_${LABEL}.${MASS}.txt"
WW8BASE="wwlvj_BulkG_WW_inclusive_c0p2_M${MASS}"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    python adapt_xsec_lvjWW_8TeV.py ${MASS}
    cp ${LVJ8DIR}/${COMBLVJWW8CARD} ${OUTDIR}/
    cp ${LVJ8DIR}/${WW8BASE}_*workspace.root ${OUTDIR}/
fi

### LVJ Zprime 13 TeV only
LABEL="lvjww13"
LVJWW13CARD="wwlvj_Zprimefix_WW_lvjj_M${MASS}_combo_ALLP_unbin.txt"
COMBLVJWW13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ]
    then
    python adapt_xsec_lvjWW_13TeV.py ${MASS}
    sed -e 's|cards_mu_HPW/||g' -e 's|cards_mu_HPZ/||g'  -e 's|cards_mu_LPW/||g' -e 's|cards_mu_LPZ/||g' -e 's|cards_el_HPW/||g' -e 's|cards_el_HPZ/||g' -e 's|cards_el_LPW/||g' -e 's|cards_el_LPZ/||g' < ${LVJ13DIR}/${LVJWW13CARD} &> $OUTDIR/${COMBLVJWW13CARD}
    cp ${LVJ13DIR}/cards_*/*_M${MASS}_*.root ${OUTDIR}/
fi

### JJ ZprimeWW/ZH 8 TeV only
LABEL="jjwwzh8"
JJWWZH8CARD="CMS_jj_Zprimefix_WW_ZH_${MASS}_8TeV_CMS_jj_VV.txt"
COMBJJWWZH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 1000 ] && [ $MASS -lt 3000 ]
    then
    python adapt_xsec_jjWW_ZH_8TeV.py ${MASS}
    sed -e 's|datacards/../workspaces/||g' -e 's|CMS_jj_bkg_8TeV|CMS_jj_bkg_WZ_8TeV|g' < ${JJ8DIR}/datacards/${JJWWZH8CARD} &> $OUTDIR/${COMBJJWWZH8CARD}
    cp ${JJ8DIR}/workspaces/CMS_jj_WZ*${MASS}*.root ${OUTDIR}/
    cp ${JJ8DIR}/workspaces/CMS_jj_bkg_8TeV.root ${OUTDIR}/CMS_jj_bkg_WZ_8TeV.root
fi

### JJ ZprimeWW/ZH 13 TeV only
LABEL="jjwwzh13"
JJWWZH13CARD="CMS_jj_Zprimefix_WW_ZH_${MASS}_13TeV_CMS_jj_VVnew.txt"
COMBJJWWZH13CARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1200 ]
then
    python adapt_xsec_jjWW_ZH_13TeV.py ${MASS}
    sed -e 's|datacards_withPDFuncertainties/../workspaces/||g' -e 's|datacards_backup/../workspaces/||g' -e 's|datacards/../workspaces/||g' -e 's|../workspaces/||g' < ${JJ13DIR}/${JJWWZH13CARD} &> $OUTDIR/${COMBJJWWZH13CARD}
    cp ${JJ13DIR}/CMS_jj_ZprimeWW_*${MASS}*.root ${OUTDIR}/.
    cp ${JJ13DIR}/CMS_jj_bkg_13TeV.root ${OUTDIR}/.
fi

### LLJ,NNJ ZprimeZH 13 TeV only NEW!!
LABEL="lljnnjzh13"
LLJZH13CARD="XZhFix_M${MASS}.txt"
COMBLLJZH13CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 3000 ]
    then
    python adapt_xsec_llj_nnj_ZH_13TeV.py ${MASS}
    sed -e 's|workspaces/||g' < ${LLJZH13DIR}/datacards/${LLJZH13CARD} &> $OUTDIR/${COMBLLJZH13CARD}
    cp ${LLJZH13DIR}/workspaces/XZh*.root ${OUTDIR}/
fi


### LLJ Zprime (ZH) 8 TeV only
LABEL="lljzh8"
LLJZH8CARD="comb_xzz.${MASS}.txt"
COMBLLJZH8CARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -ge 600 ] && [ $MASS -le 2500 ]
    then
    python adapt_xsec_lljZH_8TeV.py ${MASS}
    cp ${LLJ8DIR}/${MASS}/${COMBLLJZH8CARD} ${OUTDIR}/
    cp ${LLJ8DIR}/${MASS}/*HP.input*.root  ${OUTDIR}/
fi

###put things together
cd $OUTDIR/

# 13 TeV LVJ+JJ
COMBJJLVJZPRIME13="comb_JJLVJZPRIME13.${MASS}.txt" #neutral singlet
# 13 TeV LVJ+JJ+LLBB+NNBB
COMBALLZPRIME13="comb_ALLZPRIME13.${MASS}.txt" #neutral singlet
# 8 TeV LLLV+LLJ+LVJ+JJ (WV)
COMBALLWVZPRIME8="comb_ALLWVZPRIME8.${MASS}.txt" #neutral singlet
#8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
COMBALLWVZPRIME138="comb_ALLWVZPRIME138.${MASS}.txt" #neutral singlet
#8 TeV VH only
COMBALLHVZPRIME8="comb_ALLHVZPRIME8.${MASS}.txt" #neutral singlet
#8+13 TeV VH only
COMBALLHVZPRIME138="comb_ALLHVZPRIME138.${MASS}.txt" #neutral singlet
#8 TeV VH+WV
COMBALLZPRIME8="comb_ALLZPRIME8.${MASS}.txt" #neutral singlet
#8 + 13 TeV VH+WV
COMBALLZPRIME138="comb_ALLZPRIME138.${MASS}.txt" #neutral singlet

if [ $MASS -lt 800 ] #600-700
    then
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLJZH8CARD &> $COMBALLWVZPRIME8

    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLLJZH8CARD &> $COMBALLWVZPRIME138

    #8 TeV VH+WV
    combineCards.py $COMBLLJZH8CARD &> $COMBALLZPRIME8

    #8 + 13 TeV VH+WV
    combineCards.py $COMBLLJZH8CARD &> $COMBALLZPRIME138
                
elif [ $MASS -lt 1000 ] #800-900
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWW13CARD &> $COMBJJLVJZPRIME13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWW13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME13
        
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW8CARD $COMBLLJZH8CARD &> $COMBALLWVZPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW8CARD $COMBLVJWW13CARD $COMBLLJZH8CARD &> $COMBALLWVZPRIME138
    
    #8 TeV VH only
    combineCards.py $COMBTTJZH8CARD &> $COMBALLHVZPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBTTJZH8CARD $COMBLLJZH13CARD &> $COMBALLHVZPRIME138
        
    #8 TeV VH+WV
    combineCards.py $COMBLVJWW8CARD $COMBTTJZH8CARD $COMBLLJZH8CARD &> $COMBALLZPRIME8
      
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWW8CARD $COMBLLJZH8CARD $COMBTTJZH8CARD $COMBLVJWW13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME138
      
elif [ $MASS -lt 1200 ] #1000-1100
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWW13CARD &> $COMBJJLVJZPRIME13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWW13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBLLJZH8CARD &> $COMBALLWVZPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBLVJWW13CARD $COMBLLJZH8CARD &> $COMBALLWVZPRIME138
    
    #8 TeV VH only
    combineCards.py $COMBTTJZH8CARD $COMBJJZH8CARD &> $COMBALLHVZPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH13CARD &> $COMBALLHVZPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH8CARD &> $COMBALLZPRIME8

    #8 + 13 TeV VH+WV  
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH8CARD $COMBLVJWW13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME138     

elif [ $MASS -le 2000 ] #1200-2000
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBJJLVJZPRIME13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBLLJZH8CARD &> $COMBALLWVZPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH8CARD &> $COMBALLWVZPRIME138

    #8 TeV VH only
    combineCards.py $COMBTTJZH8CARD $COMBJJZH8CARD &> $COMBALLHVZPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH13CARD &> $COMBALLHVZPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH8CARD &> $COMBALLZPRIME8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH8CARD $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME138
                 
elif [ $MASS -le 2500 ] #2100-2500
    then

    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBJJLVJZPRIME13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBLLJZH8CARD &> $COMBALLWVZPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH8CARD &> $COMBALLWVZPRIME138

    #8 TeV VH only
    combineCards.py $COMBTTJZH8CARD $COMBJJZH8CARD &> $COMBALLHVZPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH13CARD &> $COMBALLHVZPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH8CARD &> $COMBALLZPRIME8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWW8CARD $COMBJJWWZH8CARD $COMBTTJZH8CARD $COMBJJZH8CARD $COMBLLJZH8CARD $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME138
                 
elif [ $MASS -le 2600 ] #2600
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBJJLVJZPRIME13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWWZH8CARD &> $COMBALLWVZPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWWZH8CARD $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBALLWVZPRIME138

    #8 TeV VH only
    combineCards.py $COMBJJZH8CARD &> $COMBALLHVZPRIME8

    #8+13 TeV VH only
    combineCards.py $COMBJJZH8CARD $COMBLLJZH13CARD &> $COMBALLHVZPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBJJWWZH8CARD $COMBJJZH8CARD &> $COMBALLZPRIME8
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBJJWWZH8CARD $COMBJJZH8CARD $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME138
                         
elif [ $MASS -lt 3000 ] #2500-2900
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBJJLVJZPRIME13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME13
    
    # 8 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWWZH8CARD &> $COMBALLWVZPRIME8
    
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBJJWWZH8CARD $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBALLWVZPRIME138

    #8+13 TeV VH only
    combineCards.py $COMBLLJZH13CARD &> $COMBALLHVZPRIME138
    
    #8 TeV VH+WV
    combineCards.py $COMBJJWWZH8CARD &> $COMBALLZPRIME8
        
    #8 + 13 TeV VH+WV
    combineCards.py $COMBJJWWZH8CARD $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME138

elif [ $MASS -le 3000 ] #3000
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBJJLVJZPRIME13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD &> $COMBALLZPRIME13
        
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBALLWVZPRIME138

    #8+13 TeV VH only
    combineCards.py $COMBLLJZH13CARD &> $COMBALLHVZPRIME138
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD $COMBLLJZH13CARD&> $COMBALLZPRIME138
         
elif [ $MASS -le 4000 ] #3100-4000
    then
    
    # 13 TeV LVJ+JJ
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBJJLVJZPRIME13

    # 13 TeV LVJ+JJ+LLBB+NNBB
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBALLZPRIME13
        
    #8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBALLWVZPRIME138
    
    #8 + 13 TeV VH+WV
    combineCards.py $COMBLVJWW13CARD $COMBJJWWZH13CARD &> $COMBALLZPRIME138
     
fi  
