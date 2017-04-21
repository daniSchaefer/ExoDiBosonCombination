from ROOT import *
import ROOT
import array, math
import os
import sys

def get_xsec_unc(mass):

   uncs = {}
   
   fin = TFile.Open('XsecUnc/xsec-unc-8TeV.root','READ')   
   cin = fin.Get('c')
   for p in cin.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): uncs[g.GetName()] = g.Eval(mass) 
   fin.Close() 
   
   return uncs

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

 fWW=open("WW_cards/comb_xww."+str(mass)+".txt").readlines()
 outfile="WW_cards/comb_xww_bulkfix."+str(mass)+".txt"
 print outfile
 f=open(outfile,"w")

 xsecUnc =  get_xsec_unc(mass)
 pdf_ = 1+xsecUnc['gg_PDF']
 scale_ = 1+xsecUnc['gg_scale']
 
 newline1 = 'CMS_xww_XS_gg_PDF lnN				    '
 newline2 = 'CMS_xww_XS_gg_scale lnN				    '

 for l in range(len(fWW)):
  if "kmax" in fWW[l]:
   fWWsplit = fWW[l].split(' ') 
   fWW[l] = fWW[l].replace(fWWsplit[1],str(int(fWWsplit[1])+2))
  if "rate" in fWW[l]:
   line="rate					  "
   fWWsplit=fWW[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   for s in range(len(fWWsplit)):
    try: float(fWWsplit[s])
    except: continue
    signal=(s in [1,6,11,16]) # only change signal
    numberWW=float(fWWsplit[s])
    if signal:
     numberWW=numberWW/4.
     newline1+="%.3f  "%pdf_
     newline2+="%.3f  "%scale_
    else:
     newline1+="-  "
     newline2+="-  "
    line+="%.5e  " % numberWW
   line+="\n"
   f.write(line)
  else:
   f.write(fWW[l])

 f.write(newline1)
 f.write('\n')
 f.write(newline2)
 f.close()
