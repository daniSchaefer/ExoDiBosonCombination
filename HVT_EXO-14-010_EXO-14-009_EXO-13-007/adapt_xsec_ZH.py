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

masses =[m*100 for m in range(8,25+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

for mass in masses:
        print "mass = ",mass

	fZH=open("cards_ZH/datacard_"+str(mass)+"_interpolate.txt").readlines()
	outfile="cards_ZH/datacard_"+str(mass)+"_interpolate_adapt.txt"
	print outfile
        f=open(outfile,"w")

	xsecZHqqtautau={}
	for line in open("theory_HVT_ZH_qqtautau_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   xsecZHqqtautau[int(split[0])]=float(split[1])

	xsecZH={}
	for line in open("theory_HVT_ZH_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   xsecZH[int(split[0])]=float(split[1])

	xsecVH={}
	for line in open("theory_HVT_VH_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   xsecVH[int(split[0])]=float(split[1])

	for l in range(len(fZH)):
	  if "rate" in fZH[l]:
	    line="rate                                     "
	    fZHsplit=fZH[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
	    for s in range(len(fZHsplit)):
	      try:
	        float(fZHsplit[s])
	      except: continue
	      signal=(s in [1,3,5,7,9,11]) # only change signal
              numberZH=float(fZHsplit[s])
	      if signal:
                numberZH=numberZH*xsecZHqqtautau[mass]*(1.+0.95*2.) # WH has 95% lower Z-tagging efficiency than ZH and twice the cross section
              line+="%.5e  " % numberZH
	    line+="\n"
	    f.write(line)
	  else:
	    f.write(fZH[l])
