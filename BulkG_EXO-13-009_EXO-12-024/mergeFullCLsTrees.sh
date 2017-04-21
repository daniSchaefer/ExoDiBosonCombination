#!/bin/bash

mass=$1
card=binaryDatacard.root
cd comb_$mass;
rm output_$mass.root
hadd output_$mass.root crab_0*/res/output*root
combine ${card} -M HybridNew --freq --grid=output_$mass.root -m $mass --rMin=0.003 --rMax=6000 --expectedFromGrid 0.025 &> limitM2_$mass.txt;
combine ${card} -M HybridNew --freq --grid=output_$mass.root -m $mass --rMin=0.003 --rMax=6000 --expectedFromGrid 0.16 &> limitM1_$mass.txt;
combine ${card} -M HybridNew --freq --grid=output_$mass.root -m $mass --rMin=0.003 --rMax=6000 --expectedFromGrid 0.5 &> limitE0_$mass.txt;
combine ${card} -M HybridNew --freq --grid=output_$mass.root -m $mass --rMin=0.003 --rMax=6000 --expectedFromGrid 0.84 &> limitP1_$mass.txt;
combine ${card} -M HybridNew --freq --grid=output_$mass.root -m $mass --rMin=0.003 --rMax=6000 --expectedFromGrid 0.975 &> limitP2_$mass.txt;
combine ${card} -M HybridNew --freq --grid=output_$mass.root -m $mass --rMin=0.003 --rMax=6000 &> limitOb_$mass.txt;
cd -
