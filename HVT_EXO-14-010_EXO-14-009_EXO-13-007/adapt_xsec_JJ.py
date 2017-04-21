from ROOT import *
import ROOT
import array, math
import os
import sys

# This script changes multiplies the rate in the data cards
# from Bulk graviton cross section to W'/Z' cross sections
# and also account for the efficiency difference for Bulk and W'/Z' selection

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

masses =[m*100 for m in range(10,29+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

for mass in masses:
        #print "mass = ",mass

	fWW=open("JJ_cards/datacards/CMS_jj_WZ_"+str(mass)+"_8TeV_CMS_jj_VV.txt").readlines()
	outfile="JJ_cards/datacards/CMS_jj_HVT_"+str(mass)+"_8TeV_CMS_jj_VV.txt"
	print outfile
        f=open(outfile,"w")

	HVTVW={}
	for line in open("theory_HVT_VW_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   HVTVW[int(split[0])]=float(split[1])

	for l in range(len(fWW)):
	  if "rate" in fWW[l]:
	    line="rate                                     "
	    fWWsplit=fWW[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
	    for s in range(len(fWWsplit)):
	      try:
	        float(fWWsplit[s])
	      except: continue
	      signal=(s in [2,6]) # only change signal
              numberWW=float(fWWsplit[s])
	      if signal:
                numberWW=numberWW*100.*HVTVW[mass]
              line+="%.5e  " % numberWW
	    line+="\n"
	    f.write(line)
	  else:
	    f.write(fWW[l])
