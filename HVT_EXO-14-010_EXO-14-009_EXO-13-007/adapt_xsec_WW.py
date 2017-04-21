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

masses =[m*100 for m in range(8,25+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

for mass in masses:
        #print "mass = ",mass

	fWW=open("WW_cards/comb_xww."+str(mass)+".txt").readlines()
	outfile="WW_cards/comb_xww_hvt."+str(mass)+".txt"
	print outfile
        f=open(outfile,"w")

	bulkWW={}
	for line in open("xsect_BulkG_WW_c0p5_xsect_in_pb.txt").readlines():
	   split=line.replace(" ","").replace(" ","").replace(" ","").replace("\n","").split("\t")
	   bulkWW[int(split[0])]=float(split[1])

	HVTWW={}
	for line in open("theory_HVT_WW_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   HVTWW[int(split[0])]=float(split[1])

	HVTWZ={}
	for line in open("theory_HVT_WZ_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   HVTWZ[int(split[0])]=float(split[1])

	HVTWH={}
	for line in open("theory_HVT_WH_8TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   HVTWH[int(split[0])]=float(split[1])

	for l in range(len(fWW)):
	  if "rate" in fWW[l]:
	    line="rate                                     "
	    fWWsplit=fWW[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
	    for s in range(len(fWWsplit)):
	      try:
	        float(fWWsplit[s])
	      except: continue
	      signal=(s in [1,6,11,16]) # only change signal
              numberWW=float(fWWsplit[s])
	      if signal:
                #print numberWW,efficienciesBulk[mass][0]*19700.*bulkWW[mass]*0.2882464, efficienciesBulk[mass][0],19700.,bulkWW[mass],0.2882464
		#efficienciesBulk[mass]=numberWW/19700./bulkWW[mass]/0.2882464
		#print efficienciesBulk[mass]
		print "eff corr", (0.73+0.08*mass/1000.), "xsec fac", 1./bulkWW[mass]*(HVTWW[mass]+HVTWZ[mass]*69.91/67.60/2.)
                numberWW=numberWW/bulkWW[mass]*(0.73+0.08*mass/1000.)*(HVTWW[mass]+HVTWZ[mass]*69.91/67.60/2.) #factor /2 from combinatorics of lnuqq into WW or WZ #+0.19*0.30*HVTWH[mass]*57.7/67.60/2.
              line+="%.5e  " % numberWW
	    line+="\n"
	    f.write(line)
	  else:
	    f.write(fWW[l])
