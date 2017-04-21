from ROOT import *
import ROOT
import array, math
import os
import sys

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

masses =[m*100 for m in range(10,26+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

for mass in masses:
        print "mass = ",mass

	fVH=open("cards_VH/CMS_jj_HVqq_"+str(mass)+"_8TeV_CMS_jj_HVCombined.txt").readlines()
	outfile="cards_VH/CMS_jj_HVqq_"+str(mass)+"_8TeV_CMS_jj_HVCombined_adapt.txt"
	print outfile
        f=open(outfile,"w")

	xsecVH={}
	for line in open("theory_HVT_VH_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   xsecVH[int(split[0])]=float(split[1])

	for l in range(len(fVH)):
	  if "rate" in fVH[l]:
	    line="rate                                     "
	    fVHsplit=fVH[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
	    for s in range(len(fVHsplit)):
	      try:
	        float(fVHsplit[s])
	      except: continue
	      signal=(s in [1,2,4,5,7,8,9,10,12,13,14,15,17,18,19,20]) # only change signal
              numberVH=float(fVHsplit[s])
	      if signal:
                numberVH=numberVH*xsecVH[mass]/0.03
              line+="%.5e  " % numberVH
	    line+="\n"
	    f.write(line)
	  else:
	    f.write(fVH[l])
