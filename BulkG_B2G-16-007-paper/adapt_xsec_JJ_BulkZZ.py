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

masses =[m*100 for m in range(10,29+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

for mass in masses:
 print "mass = ",mass

 fVV=open("JJ_cards/datacards/CMS_jj_BulkZZ_"+str(mass)+"_8TeV_CMS_jj_VV.txt").readlines()
 outfile="JJ_cards/datacards/CMS_jj_BulkZZfix_"+str(mass)+"_8TeV_CMS_jj_VV.txt"
 print outfile
 f=open(outfile,"w")

 BulkZZ={}
 for line in open("xsect_BulkG_ZZ_c0p5_xsect_in_pb_factor4wrong.txt").readlines():
  split=line.replace("\n","").split("\t")
  BulkZZ[int(split[0])]=float(split[1])/4.

 xsecUnc =  get_xsec_unc(mass)
 pdf_ = 1+xsecUnc['gg_PDF']
 scale_ = 1+xsecUnc['gg_scale']
 
 newline1 = 'CMS_xww_XS_gg_PDF lnN				    '
 newline2 = 'CMS_xww_XS_gg_scale lnN				    '

 for l in range(len(fVV)):
  if "kmax" in fVV[l]:
   fVVsplit = fVV[l].split(' ') 
   fVV[l] = fVV[l].replace(fVVsplit[1],str(int(fVVsplit[1])+2))
  if "rate" in fVV[l]:
   line="rate					  "
   fVVsplit=fVV[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   for s in range(len(fVVsplit)):
    try: float(fVVsplit[s])
    except: continue
    signal=(s in [1,2,4,5]) # only change signal
    numberVV=float(fVVsplit[s])
    if signal:
     numberVV=numberVV*BulkZZ[mass]*100.
     newline1+="%.3f  "%pdf_
     newline2+="%.3f  "%scale_
    else:
     newline1+="-  "
     newline2+="-  "
    line+="%.5e  " % numberVV
   line+="\n"
   f.write(line)
  else:
   f.write(fVV[l])

 f.write(newline1)
 f.write('\n')
 f.write(newline2)
 f.close()
