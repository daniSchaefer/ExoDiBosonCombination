#! /bin/bash

# define input
if [ $# -lt 1 ]
    then
    echo "Need one input: mass point"
    exit 1
fi

MASS=$1
echo "Merging M=${MASS}"
ZHDIR="cards_ZH"
WHDIR="cards_WH"
VHDIR="cards_VH"
ZZDIR="ZZ_cards/${MASS}"
WWDIR="WW_cards"
JJDIR="JJ_cards"

#prepare output
OUTDIR="comb_${MASS}"
mkdir $OUTDIR/


### ZH only
LABEL="xzh"
COMBZHCARD="comb_${LABEL}.${MASS}.txt"
COMBRS1ZHCARD="datacard_${MASS}_interpolate_adapt.txt"

if [ $MASS -le 2500 ]
then
echo "Moving to "${ZHDIR}/
sed -e 's|lumi|lumi_8TeV|g' -e 's|PUReweighting|CMS_pu|g' -e 's|VTag|CMS_eff_tau21_sf|g' -e 's|EleScale|CMS_scale_e|g' -e 's|EleResol|CMS_res_e|g' -e 's|MuoScale|CMS_scale_m|g' -e 's|MuoResol|CMS_res_m|g' -e 's|EleID|CMS_eff_e|g' -e 's|MuoID|CMS_eff_m|g' -e 's|JES|CMS_scale_j|g' -e 's|JER|CMS_res_j|g' -e 's|BTagSyst|CMS_btagger|g' < ${ZHDIR}/${COMBRS1ZHCARD} &> $OUTDIR/${COMBZHCARD}
fi

### VH only
LABEL="xvh"
VHCARDORIG="CMS_jj_HVqq_${MASS}_8TeV_CMS_jj_HVCombined_adapt.txt"
COMBVHCARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ] && [ $MASS -le 2600 ]
then
###sed -e '/CMS_sig_p/ s|0|0.0|g' -e '/CMS_sig_p/ s|1|1.0|g' < CMS_vh_Bulk_1200_8TeV_CMS_vh_VH.txt
sed -e 's|datacards/../workspaces/||g' -e 's|datacards/../HbbVqqHwwworkspaces/||g'  -e 's|CMS_Btagging|CMS_doubleBtagging|g' < ${VHDIR}/${VHCARDORIG} &> $OUTDIR/${COMBVHCARD}
###    sed -e 's|datacards/../workspaces/||g' -e '/CMS_sig_p/ s|0|0.0|' -e '/CMS_sig_p1/ s|1|1.0|2' -e '/CMS_sig_p2/ s|1|1.0|' < ${VHDIR}/datacards/${VHCARDORIG} &> $OUTDIR/${COMBVHCARD}
#    cp ${VHDIR}/datacards/${VHCARDORIG}  $OUTDIR/${COMBVHCARD}
    cp ${VHDIR}/CMS_jj_*${MASS}*.root ${OUTDIR}/
    cp ${VHDIR}/CMS_jj_bkg_8TeV.root ${OUTDIR}/
fi

### WH only
LABEL="xwh"
WHBASE="whlvj_MWp_${MASS}_bb"
WHELEBASE="cards_el/${WHBASE}_el"
WHMUBASE="cards_mu/${WHBASE}_mu"
EXOWHCARDS="${LABEL}_mv1JLP=${WHMUBASE}_ALLP_unbin.txt ${LABEL}_ev1JLP=${WHELEBASE}_ALLP_unbin.txt"
COMBWHCARD="comb_${LABEL}.${MASS}.txt"

if [ $MASS -le 2500 ]
    then
    cd ${WHDIR}/
    combineCards.py $EXOWHCARDS &> tmp_XWH_card.txt
    sed -e 's|cards_mu/||g'  -e 's|cards_el/||g'   -e 's|CMS_xwh_prunedmass|CMS_jet_mass|g'   -e 's|CMS_xwh_btagger|CMS_btagger|g' -e 's|CMS_xwh_btag_eff|CMS_doubleBtagging|g' < tmp_XWH_card.txt  > ${COMBWHCARD}
    cd -
    cp ${WHDIR}/${COMBWHCARD} ${OUTDIR}/${COMBWHCARD}
    cp ${WHDIR}/cards_el/${WHBASE}_*workspace.root  ${OUTDIR}/
    cp ${WHDIR}/cards_mu/${WHBASE}_*workspace.root  ${OUTDIR}/
fi

### ZZ only
LABEL="xzz"
COMBZZCARD="comb_${LABEL}.${MASS}.txt"
COMBZZHVTCARD="comb_${LABEL}_hvt.${MASS}.txt"

if [ $MASS -le 2500 ]
then
echo "Moving to "${ZZDIR}/
cp ${ZZDIR}/${COMBZZHVTCARD} ${OUTDIR}/${COMBZZCARD}
cp ${ZZDIR}/${LABEL}_*input*.root  ${OUTDIR}/
fi

### JJ only
LABEL="xjj"
JJCARDORIG="CMS_jj_HVT_${MASS}_8TeV_CMS_jj_VV.txt" ##Andreas gives us cards with WW and ZZ already merged
COMBJJCARD="comb_${LABEL}.${MASS}.txt"
 
if [ $MASS -ge 1000 ]
then
###sed -e '/CMS_sig_p/ s|0|0.0|g' -e '/CMS_sig_p/ s|1|1.0|g' < CMS_jj_Bulk_1200_8TeV_CMS_jj_VV.txt
sed -e 's|datacards/../workspaces/||g' -e 's|CMS_jj_bkg_8TeV|CMS_jj_bkg_WZ_8TeV|g' < ${JJDIR}/datacards/${JJCARDORIG} &> $OUTDIR/${COMBJJCARD}
###    sed -e 's|datacards/../workspaces/||g' -e '/CMS_sig_p/ s|0|0.0|' -e '/CMS_sig_p1/ s|1|1.0|2' -e '/CMS_sig_p2/ s|1|1.0|' < ${JJDIR}/datacards/${JJCARDORIG} &> $OUTDIR/${COMBJJCARD}
#    cp ${JJDIR}/datacards/${JJCARDORIG}  $OUTDIR/${COMBJJCARD}
    cp ${JJDIR}/workspaces/CMS_jj_WZ*${MASS}*.root ${OUTDIR}/
    cp ${JJDIR}/workspaces/CMS_jj_bkg_8TeV.root ${OUTDIR}/CMS_jj_bkg_WZ_8TeV.root
fi

### WW only
LABEL="xww"
WWBASE="wwlvj_BulkG_WW_inclusive_c0p2_M${MASS}"
COMBWWCARD="comb_${LABEL}.${MASS}.txt"
COMBWWHVTCARD="comb_${LABEL}_hvt.${MASS}.txt"

if [ $MASS -ge 800 ] && [ $MASS -le 2500 ]
    then
    cp ${WWDIR}/${COMBWWHVTCARD} ${OUTDIR}/${COMBWWCARD}
    cp ${WWDIR}/${WWBASE}_*workspace.root  ${OUTDIR}/
fi

###put things together
cd $OUTDIR/

COMB3CHANCARD="comb_ALL.${MASS}.txt"
COMBWZHCARD="comb_WZH.${MASS}.txt"

if [ $MASS -lt 1000 ]
    then
    combineCards.py $COMBWHCARD $COMBZHCARD &>  $COMB3CHANCARD
    combineCards.py $COMBWHCARD $COMBZHCARD $COMBWWCARD $COMBZZCARD &>  $COMBWZHCARD
elif [ $MASS -gt 2500 ]
    then
    combineCards.py $COMBVHCARD &>  $COMB3CHANCARD
    combineCards.py $COMBVHCARD $COMBJJCARD &>  $COMBWZHCARD
else 
    combineCards.py $COMBVHCARD $COMBWHCARD $COMBZHCARD &>  $COMB3CHANCARD
    combineCards.py $COMBVHCARD $COMBWHCARD $COMBZHCARD $COMBJJCARD $COMBWWCARD $COMBZZCARD &>  $COMBWZHCARD
fi
