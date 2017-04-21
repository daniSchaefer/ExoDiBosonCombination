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
massMap = thMap[1]

for mass in masses:

 #print "mass = ",mass
 m = int((mass-745)/5) #for jen's 8 TeV theo map 
 #m = int((mass-800)/100) #for jen'2 13 TeV theo map or 8 TeV alternative model B
 
 fZH=open("cards_ZH_8TeV/datacard_"+str(mass)+"_interpolate.txt").readlines()
 outfile="cards_ZH_8TeV/datacard_"+str(mass)+"_interpolate_ZHadapt.txt"
 print outfile
 f=open(outfile,"w")

 xsecZH={}
 xsecZH[mass] = xsecMap['CX0(pb)'][m]*xsecMap['BRhZ'][m]*0.6991*0.0637

 xsecUnc =  get_xsec_unc(mass)
 pdf_Wprime = 1+xsecUnc['qq_PDF_Wprime']
 pdf_Zprime = 1+xsecUnc['qq_PDF_Zprime']
 scale_Wprime = 1+xsecUnc['qq_scale_Wprime']
 scale_Zprime = 1+xsecUnc['qq_scale_Zprime']
 
 newline1 = 'CMS_XS_qq_PDF lnN				    '
 newline2 = 'CMS_XS_qq_scale lnN				    '
 
 for l in range(len(fZH)):
  if "kmax" in fZH[l]:
   fZHsplit = fZH[l].split(' ') 
   fZH[l] = fZH[l].replace(fZHsplit[1],str(int(fZHsplit[1])+2))
  if "rate" in fZH[l]:
   line="rate 				    "
   fZHsplit=fZH[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   for s in range(len(fZHsplit)):
    try: float(fZHsplit[s])
    except: continue
    signal=(s in [1,3,5,7,9,11]) # only change signal
    numberZH=float(fZHsplit[s])
    if signal:
     #numberZH=numberZH*xsecZHqqtautau[mass]*(1.+0.95*2.) # WH has 95% lower Z-tagging efficiency than ZH and twice the cross section
     numberZH=numberZH*1000.*(xsecZH[mass]) # WH has 95% lower Z-tagging efficiency than ZH and twice the cross section
     newline1+="%.3f  "%pdf_Zprime
     newline2+="%.3f  "%scale_Zprime
    else:
     newline1+="-  "
     newline2+="-  "
    line+="%.5e  " % numberZH
   line+="\n"
   f.write(line)
  else:
   f.write(fZH[l])

 f.write(newline1)
 f.write('\n')
 f.write(newline2)
 f.close()
