from ROOT import *
import ROOT
import array, math
import os
import sys
from array import array

def get_xsec_unc(mass):

   uncs = {}
   
   fin = TFile.Open('XsecUnc/xsec-unc-8TeV.root','READ')   
   cin = fin.Get('c')
   for p in cin.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): uncs[g.GetName()] = g.Eval(mass) 
   fin.Close() 
   
   return uncs
   
def get_theo_map():

   V_mass = array('d',[])

   brs = {}
   index = {}

   mapping = ["M0","M+","BRWW","BRhZ","BRZW","BRWh","CX+(pb)","CX0(pb)","CX-(pb)"]

   for m in xrange(0,len(mapping)):
      if mapping[m] != "M0" and mapping[m] != "M+":
   	 brs[mapping[m]] = array('d',[])
   	 #print mapping[m]

   f = open('xsect_HVT_8TeV.txt','r')
   for line in f:
      brDict = line.split(",")
      for d in xrange(0,len(brDict)):
   	 if brDict[d].find('\n') != -1:
   	    brDict[d] = brDict[d].split('\n')[0]
   	 for m in xrange(0,len(mapping)):
   	    if brDict[d] == mapping[m]:
   	       index[mapping[m]] = d
   	       #print "%s %i" %(mapping[m],d)
	    
   f.close()

   f = open('xsect_HVT_8TeV.txt','r')
   for line in f:
      if line.find('M0') != -1: continue
      brDict = line.split(",")  	    
      V_mass.append(float(brDict[index['M0']]))
      for m in xrange(0,len(mapping)):
   	 if mapping[m] != "M0" and mapping[m] != "M+":
   	    brs[mapping[m]].append(float(brDict[index[mapping[m]]]))

   f.close()

   return [brs,V_mass]

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

thMap = get_theo_map()
xsecMap = thMap[0]
#massMap = thMap[1]

for mass in masses:
 #print "mass = ",mass
 m = int((mass-745)/5) #for jen's 8 TeV theo map 
 #m = int((mass-800)/100) #for jen'2 13 TeV theo map or 8 TeV alternative model B

 fWW=open("LVJ_cards_8TeV/comb_xww."+str(mass)+".txt").readlines()
 outfile="LVJ_cards_8TeV/comb_lvjwz8."+str(mass)+".txt"
 print outfile
 f=open(outfile,"w")

 bulkWW={}
 for line in open("xsect_BulkG_WW_c0p5_xsect_in_pb_factor4wrong.txt").readlines():
    split=line.replace(" ","").replace(" ","").replace(" ","").replace("\n","").split("\t")
    bulkWW[int(split[0])]=float(split[1])

 HVTWW={}
 HVTWW[mass] = xsecMap['CX0(pb)'][m]*xsecMap['BRWW'][m]
 
 HVTWZ={}
 HVTWZ[mass]=(xsecMap['CX-(pb)'][m]+xsecMap['CX+(pb)'][m])*xsecMap['BRZW'][m]

 xsecUnc =  get_xsec_unc(mass)
 pdf_Wprime = 1+xsecUnc['qq_PDF_Wprime']
 pdf_Zprime = 1+xsecUnc['qq_PDF_Zprime']
 scale_Wprime = 1+xsecUnc['qq_scale_Wprime']
 scale_Zprime = 1+xsecUnc['qq_scale_Zprime']
 
 newline1 = 'CMS_XS_qq_PDF lnN				    '
 newline2 = 'CMS_XS_qq_scale lnN				    '
 
 for l in range(len(fWW)):
  if "kmax" in fWW[l]:
   fWWsplit = fWW[l].split(' ') 
   fWW[l] = fWW[l].replace(fWWsplit[1],str(int(fWWsplit[1])+2))
  if "rate" in fWW[l]:
   line="rate 				    "
   fWWsplit=fWW[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   for s in range(len(fWWsplit)):
    try: float(fWWsplit[s])
    except: continue
    signal=(s in [1,6,11,16]) # only change signal
    numberWW=float(fWWsplit[s])
    if signal:
     #print numberWW,efficienciesBulk[mass][0]*19700.*bulkWW[mass]*0.2882464, efficienciesBulk[mass][0],19700.,bulkWW[mass],0.2882464
     #efficienciesBulk[mass]=numberWW/19700./bulkWW[mass]/0.2882464
     #print efficienciesBulk[mass]
     #print "eff corr", (0.73+0.08*mass/1000.), "xsec fac", 1./bulkWW[mass]*(HVTWW[mass]+HVTWZ[mass]*69.91/67.60/2.)
     numberWW=numberWW/bulkWW[mass]*(0.73+0.08*mass/1000.)*HVTWZ[mass]*69.91/67.60/2. #factor /2 from combinatorics of lnuqq into WW or WZ #+0.19*0.30*HVTWH[mass]*57.7/67.60/2.
     newline1+="%.3f  "%pdf_Wprime
     newline2+="%.3f  "%scale_Wprime
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
