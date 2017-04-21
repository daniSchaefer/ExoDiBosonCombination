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

masses =[m*100 for m in range(8,40+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

for lumi in ["1fb","3fb","10fb"]:
  for mass in masses:
        print "mass = ",mass

	fWW=open("WW_cards_13TeV_"+lumi+"/comb_xww13"+lumi.replace("1fb","")+"."+str(mass)+".txt").readlines()
	outfile="WW_cards_13TeV_"+lumi+"/comb_xww13"+lumi.replace("1fb","")+"_rs1."+str(mass)+".txt"
	print outfile
        f=open(outfile,"w")

	RS1WW={}
	for line in open("theory_RS1_WW_13TeV.txt").readlines():
	   split=line.replace("\n","").split(" ")
	   RS1WW[int(split[0])]=float(split[1])

	for l in range(len(fWW)):
	  if "rate" in fWW[l]:
	    line="rate                                     "
	    fWWsplit=fWW[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
	    for s in range(len(fWWsplit)):
	      try:
	        float(fWWsplit[s])
	      except: continue
	      signal=(s in [1,5]) # only change signal
              numberWW=float(fWWsplit[s])
	      if signal:
                numberWW=numberWW*RS1WW[mass]*100. # cards from Jennnifer are in units of 100. pb
              line+="%.5e  " % numberWW
	    line+="\n"
	    f.write(line)
	  else:
	    f.write(fWW[l])
