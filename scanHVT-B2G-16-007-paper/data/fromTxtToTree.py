import ROOT
import sys
from ROOT import *
import CMS_lumi, tdrstyle
import time
from array import array

outfile = TFile.Open('scanHVT-M1500.root','RECREATE')
outtree = TTree("hvtM1500","hvtM1500")

gV = array('f',[0])
cH = array('f',[0])
cF = array('f',[0])
g = array('f',[0])
sigma_Wp_13TeV = array('f',[0])
sigma_Wpp_13TeV = array('f',[0])
sigma_Wpm_13TeV = array('f',[0])
sigma_Zp_13TeV = array('f',[0])
br_WZ_13TeV = array('f',[0])
br_WW_13TeV = array('f',[0])
br_WH_13TeV = array('f',[0])
br_ZH_13TeV = array('f',[0])
xsecTot_WV_13TeV = array('f',[0])
xsecTot_VH_13TeV = array('f',[0])
xsecTot_13TeV = array('f',[0])
width_Wp_13TeV = array('f',[0])
width_Zp_13TeV = array('f',[0])
sigma_Wp_8TeV = array('f',[0])
sigma_Wpp_8TeV = array('f',[0])
sigma_Wpm_8TeV = array('f',[0])
sigma_Zp_8TeV = array('f',[0])
br_WZ_8TeV = array('f',[0])
br_WW_8TeV = array('f',[0])
br_WH_8TeV = array('f',[0])
br_ZH_8TeV = array('f',[0])
xsecTot_WV_8TeV = array('f',[0])
xsecTot_VH_8TeV = array('f',[0])
xsecTot_8TeV = array('f',[0])
width_Wp_8TeV = array('f',[0])
width_Zp_8TeV = array('f',[0])

outtree.Branch( 'gV', gV, 'gV/F' )
outtree.Branch( 'cH', cH, 'cH/F' )
outtree.Branch( 'cF', cF, 'cF/F' )
outtree.Branch( 'g', g, 'g/F' )
outtree.Branch( 'sigma_Wp_13TeV', sigma_Wp_13TeV, 'sigma_Wp_13TeV/F' )
outtree.Branch( 'sigma_Wpp_13TeV', sigma_Wpp_13TeV, 'sigma_Wpp_13TeV/F' )
outtree.Branch( 'sigma_Wpm_13TeV', sigma_Wpm_13TeV, 'sigma_Wpm_13TeV/F' )
outtree.Branch( 'sigma_Zp_13TeV', sigma_Zp_13TeV, 'sigma_Zp_13TeV/F' )
outtree.Branch( 'br_WZ_13TeV', br_WZ_13TeV, 'br_WZ_13TeV/F' )
outtree.Branch( 'br_WW_13TeV', br_WW_13TeV, 'br_WW_13TeV/F' )
outtree.Branch( 'br_WH_13TeV', br_WH_13TeV, 'br_WH_13TeV/F' )
outtree.Branch( 'br_ZH_13TeV', br_ZH_13TeV, 'br_ZH_13TeV/F' )
outtree.Branch( 'xsecTot_WV_13TeV', xsecTot_WV_13TeV, 'xsecTot_WV_13TeV/F' )
outtree.Branch( 'xsecTot_VH_13TeV', xsecTot_VH_13TeV, 'xsecTot_VH_13TeV/F' )
outtree.Branch( 'xsecTot_13TeV', xsecTot_13TeV, 'xsecTot_13TeV/F' )
outtree.Branch( 'width_Wp_13TeV', width_Wp_13TeV, 'width_Wp_13TeV/F' )
outtree.Branch( 'width_Zp_13TeV', width_Zp_13TeV, 'width_Zp_13TeV/F' )
outtree.Branch( 'sigma_Wp_8TeV', sigma_Wp_8TeV, 'sigma_Wp_8TeV/F' )
outtree.Branch( 'sigma_Wpp_8TeV', sigma_Wpp_8TeV, 'sigma_Wpp_8TeV/F' )
outtree.Branch( 'sigma_Wpm_8TeV', sigma_Wpm_8TeV, 'sigma_Wpm_8TeV/F' )
outtree.Branch( 'sigma_Zp_8TeV', sigma_Zp_8TeV, 'sigma_Zp_8TeV/F' )
outtree.Branch( 'br_WZ_8TeV', br_WZ_8TeV, 'br_WZ_8TeV/F' )
outtree.Branch( 'br_WW_8TeV', br_WW_8TeV, 'br_WW_8TeV/F' )
outtree.Branch( 'br_WH_8TeV', br_WH_8TeV, 'br_WH_8TeV/F' )
outtree.Branch( 'br_ZH_8TeV', br_ZH_8TeV, 'br_ZH_8TeV/F' )
outtree.Branch( 'xsecTot_WV_8TeV', xsecTot_WV_8TeV, 'xsecTot_WV_8TeV/F' )
outtree.Branch( 'xsecTot_VH_8TeV', xsecTot_VH_8TeV, 'xsecTot_VH_8TeV/F' )
outtree.Branch( 'xsecTot_8TeV', xsecTot_8TeV, 'xsecTot_8TeV/F' )
outtree.Branch( 'width_Wp_8TeV', width_Wp_8TeV, 'width_Wp_8TeV/F' )
outtree.Branch( 'width_Zp_8TeV', width_Zp_8TeV, 'width_Zp_8TeV/F' )

infile13 = open('data/scanHVT-M1500.txt','r')
lines = infile13.readlines()

infile8 = open('data/scanHVT-M1500_8TeV.txt','r')    
nlines = -1
for line in infile8:
 if nlines%1000 == 0: print nlines,"/82500"
 nlines+=1
 if "M" in line: continue
 line = line.replace("*10^","e")
 l = line.split('	')#line.split(' ')
 gV[0] = float(l[3])
 cH[0] = float(l[4])
 cF[0] = float(l[5])
 g[0] = float(l[2])
 sigma_Wp_8TeV[0] = float(l[28])+float(l[30])
 sigma_Wpp_8TeV[0] = float(l[28])
 sigma_Wpm_8TeV[0] = float(l[30])
 sigma_Zp_8TeV[0] = float(l[29])
 br_WZ_8TeV[0] = float(l[21])
 br_WW_8TeV[0] = float(l[12])
 br_WH_8TeV[0] = float(l[23])
 br_ZH_8TeV[0] = float(l[13])
 xsecTot_WV_8TeV[0] = (float(l[28])+float(l[30]))*float(l[21])+float(l[29])*float(l[12])
 xsecTot_VH_8TeV[0] = (float(l[28])+float(l[30]))*float(l[23])+float(l[29])*float(l[13])
 xsecTot_8TeV[0] = float(l[28])+float(l[30])+float(l[29]) 
 width_Wp_8TeV[0] = float(l[20])
 width_Zp_8TeV[0] = float(l[11])
 sigma_Wp_13TeV[0] = -99
 sigma_Wpp_13TeV[0] = -99
 sigma_Wpm_13TeV[0] = -99
 sigma_Zp_13TeV[0] = -99
 br_WZ_13TeV[0] = -99
 br_WW_13TeV[0] = -99
 br_WH_13TeV[0] = -99
 br_ZH_13TeV[0] = -99
 xsecTot_WV_13TeV[0] = -99
 xsecTot_VH_13TeV[0] = -99
 xsecTot_13TeV[0] = -99
 line2 = lines[nlines].replace("*10^","e")
 ll=line2.split('	')
 sigma_Wp_13TeV[0] = float(ll[28])+float(ll[30])
 sigma_Wpp_13TeV[0] = float(ll[28])
 sigma_Wpm_13TeV[0] = float(ll[30])
 sigma_Zp_13TeV[0] = float(ll[29])
 br_WZ_13TeV[0] = float(ll[21])
 br_WW_13TeV[0] = float(ll[12])
 br_WH_13TeV[0] = float(ll[23])
 br_ZH_13TeV[0] = float(ll[13])
 xsecTot_WV_13TeV[0] = (float(ll[28])+float(ll[30]))*float(ll[21])+float(ll[29])*float(ll[12])
 xsecTot_VH_13TeV[0] = (float(ll[28])+float(ll[30]))*float(ll[23])+float(ll[29])*float(ll[13])
 xsecTot_13TeV[0] = float(ll[28])+float(ll[30])+float(ll[29])	  
 width_Wp_13TeV[0] = float(ll[20])
 width_Zp_13TeV[0] = float(ll[11])
 outtree.Fill()

infile8.close()
infile13.close()
outfile.Write()
outfile.Close() 
 
