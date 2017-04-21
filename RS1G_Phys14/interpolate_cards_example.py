from ROOT import *
import ROOT
import array, math
import os
import sys

# This interpolates the datacards between the points where full simulation was available.

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
import array

masses =[m*100 for m in range(10,40+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

input_masses=[1000,2000,3000,4000]

for channel in ["el","mu"]:
  print channel
  signal_yields=[]
  for mass in input_masses:
    for line in open("WW_cards_13TeV_1fb/wwlvj_RS1G_WW_lvjj_M"+str(mass)+"_"+channel+"_HP_unbin.txt").readlines():
        if "rate " in line:
            split=line.replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("\n","").split(" ")
	    print split
            signal_yields+=[float(split[1])]
  print signal_yields
  input_masses_array=array.array('d')
  signal_yields_array=array.array('d')
  for p in input_masses: input_masses_array.append(p)
  for p in signal_yields: signal_yields_array.append(p)
  g=TGraph(len(input_masses_array),input_masses_array,signal_yields_array)

  for mass in masses:
        print "mass = ",mass
	if mass in input_masses:
	  fin=open("WW_cards_13TeV_1fb/wwlvj_RS1G_WW_lvjj_M"+str(mass)+"_"+channel+"_HP_unbin.txt").readlines()
	outfile="WW_cards_13TeV_1fb/wwlvj_RS1G_WW_lvjj_M"+str(mass)+"_"+channel+"_HP_unbin_interpolate.txt"
	print outfile
        f=open(outfile,"w")

	for l in range(len(fin)):
	  if "rate " in fin[l]:
	    line="rate             "
	    fsplit=fin[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
	    for s in range(1,len(fsplit)):
	      try:
	        float(fsplit[s])
	      except: continue
              number=float(fsplit[s])
	      if s==1:
                number=g.Eval(mass)
              line+="%.5e  " % number
	    line+="\n"
	    f.write(line)
	  else:
	    f.write(fin[l])
