from ROOT import *
import ROOT
import array, math
import os
import sys
from array import array

gROOT.Reset()
gROOT.SetStyle("Plain")
gStyle.SetOptStat(0)
gStyle.SetOptFit(0)
gStyle.SetTitleOffset(1.2,"Y")
gStyle.SetPadLeftMargin(0.18)
gStyle.SetPadBottomMargin(0.15)
gStyle.SetPadTopMargin(0.03)
gStyle.SetPadRightMargin(0.05)
gStyle.SetMarkerSize(1.5)
gStyle.SetHistLineWidth(1)
gStyle.SetStatFontSize(0.020)
gStyle.SetTitleSize(0.06, "XYZ")
gStyle.SetLabelSize(0.05, "XYZ")
gStyle.SetNdivisions(510, "XYZ")
gStyle.SetLegendBorderSize(0)

masses =[m*100 for m in range(8,25+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

for mass in masses:

 #print "mass = ",mass
 m = int((mass-745)/5) #for jen's 8 TeV theo map 
 #m = int((mass-800)/100) #for jen'2 13 TeV theo map or 8 TeV alternative model B
 
 fZH=open("cards_ZH_8TeV/datacard_"+str(mass)+"_interpolate.txt").readlines()
 outfile="cards_ZH_8TeV/datacard_"+str(mass)+"_interpolate_BulkGadapt.txt"
 print outfile
 f=open(outfile,"w")

 bulkZZ={}
 for line in open("xsect_BulkG_WW_c0p5_8TeV.txt").readlines():
  split=line.replace(" ","").replace(" ","").replace(" ","").replace("\n","").split("\t")
  bulkZZ[int(split[0])]=float(split[1])*0.6991*0.03370*0.59*2./4./2.

 for l in range(len(fZH)):
  if "rate" in fZH[l]:
   line="rate					  "
   fZHsplit=fZH[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   for s in range(len(fZHsplit)):
    try:
      float(fZHsplit[s])
    except: continue
    signal=(s in [1,3,5,7,9,11]) # only change signal
    numberZH=float(fZHsplit[s])
    if signal:
     numberZH=numberZH*1000.*(bulkZZ[mass])
    line+="%.5e  " % numberZH
   line+="\n"
   f.write(line)
  else:
    f.write(fZH[l])
