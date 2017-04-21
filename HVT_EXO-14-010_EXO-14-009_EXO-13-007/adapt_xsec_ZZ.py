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
        #print "mass = ",mass

	fZZ=open("ZZ_cards/"+str(mass)+"/comb_xzz."+str(mass)+".txt").readlines()
	outfile="ZZ_cards/"+str(mass)+"/comb_xzz_hvt."+str(mass)+".txt"
	print outfile
        f=open(outfile,"w")

	bulkZZ={}
	for line in open("xsect_BulkG_ZZ_c0p5_xsect_in_pb.txt").readlines():
	   split=line.replace(" ","").replace(" ","").replace(" ","").replace("\n","").split("\t")
	   bulkZZ[int(split[0])]=float(split[1])

	HVTWZ={}
	for line in open("theory_HVT_WZ_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   HVTWZ[int(split[0])]=float(split[1])

	HVTZH={}
	for line in open("theory_HVT_ZH_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   HVTZH[int(split[0])]=float(split[1])

	for l in range(len(fZZ)):
	  if "rate" in fZZ[l]:
	    line="rate                                     "
	    fZZsplit=fZZ[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
	    for s in range(len(fZZsplit)):
	      try:
	        float(fZZsplit[s])
	      except: continue
	      signal=(s in [1,3,5,7]) # only change signal
              numberZZ=float(fZZsplit[s])
	      if signal:
	        #print numberZZ/19700./bulkZZ[mass]/0.0941
                numberZZ=numberZZ/bulkZZ[mass]*0.8*(HVTWZ[mass]*67.60/69.91/2.+0.27*HVTZH[mass]*57.7/67.60/2.) #factor /2 from combinatorics of llqq into ZZ or WZ
              line+="%.5e  " % numberZZ
	    line+="\n"
	    f.write(line)
	  else:
	    f.write(fZZ[l])
