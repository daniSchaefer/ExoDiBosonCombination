from array import array
import sys
from ROOT import *

def get_xsec_unc(mass):

   uncs = {}
   
   fin = TFile.Open('XsecUnc/xsec-unc-13TeV.root','READ')   
   cin = fin.Get('c')
   for p in cin.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): uncs[g.GetName()] = g.Eval(mass) 
   fin.Close() 
   
   return uncs
   
def get_efficiency(mass):

   dEff = {}
   effs = []
   
   fElHP = TFile.Open('Wprime_WH_efficiency_el_HP.root','R')
   cElHP = fElHP.Get('eff_HPV')
   for p in cElHP.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): dEff[g.GetName()] = g.Eval(mass/1000.) 
   fElHP.Close()
   
   fElLP = TFile.Open('Wprime_WH_efficiency_el_LP.root','R')
   cElLP = fElLP.Get('eff_LPV')
   for p in cElLP.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): dEff[g.GetName()] = g.Eval(mass/1000.) 
   fElLP.Close()
   
   fMuHP = TFile.Open('Wprime_WH_efficiency_mu_HP.root','R')
   cMuHP = fMuHP.Get('eff_HPV')
   for p in cMuHP.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): dEff[g.GetName()] = g.Eval(mass/1000.) 
   fMuHP.Close()
   
   fMuLP = TFile.Open('Wprime_WH_efficiency_mu_LP.root','R')
   cMuLP = fMuLP.Get('eff_LPV')
   for p in cMuLP.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): dEff[g.GetName()] = g.Eval(mass/1000.) 
   fMuLP.Close()
   
   #keep this order of channels
   effs.append( dEff['mu_HPW'] )
   effs.append( dEff['mu_HPZ'] )
   effs.append( dEff['mu_LPW'] )
   effs.append( dEff['mu_LPZ'] )
   effs.append( dEff['el_HPW'] )
   effs.append( dEff['el_HPZ'] )
   effs.append( dEff['el_LPW'] )
   effs.append( dEff['el_LPZ'] )
   
   return effs
               
def get_theo_map():

   V_mass = array('d',[])

   brs = {}
   index = {}

   mapping = ["M0","M+","BRWW","BRhZ","BRZW","BRWh","CX+(pb)","CX0(pb)","CX-(pb)"]

   for m in xrange(0,len(mapping)):
      if mapping[m] != "M0" and mapping[m] != "M+":
   	 brs[mapping[m]] = array('d',[])
   	 #print mapping[m]

   f = open('xsect_HVT_13TeV.txt','r')
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

   f = open('xsect_HVT_13TeV.txt','r')
   for line in f:
      if line.find('M0') != -1: continue
      brDict = line.split(",")  	    
      V_mass.append(float(brDict[index['M0']]))
      for m in xrange(0,len(mapping)):
   	 if mapping[m] != "M0" and mapping[m] != "M+":
   	    brs[mapping[m]].append(float(brDict[index[mapping[m]]]))

   f.close()

   return [brs,V_mass]


thMap = get_theo_map()
xsecMap = thMap[0]
massMap = thMap[1]

masses =[m*100 for m in range(8,40+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

WprimeWZ={}
WprimeWH={}
for mass in masses:

 m = int((mass-800)/100)
 #print "mass = ",mass
 
 try:
   fWZ=open("LVJ_cards_13TeV/wwlvj_Wprime_WZ_lvjj_M"+str(mass)+"_combo_ALLP_unbin.txt").readlines()
 except:
   print "could not open"
   continue
   
 outfile="LVJ_cards_13TeV/wwlvj_Wprimefix_WZ_WH_lvjj_M"+str(mass)+"_combo_ALLP_unbin.txt"
 print outfile
 f=open(outfile,"w")

 WprimeWZ[mass]=(xsecMap['CX-(pb)'][m]+xsecMap['CX+(pb)'][m])*xsecMap['BRZW'][m]*0.322*0.6991
 WprimeWH[mass]=(xsecMap['CX-(pb)'][m]+xsecMap['CX+(pb)'][m])*xsecMap['BRWh'][m]*0.322*0.577
 WHeff = get_efficiency(mass)

 xsecUnc =  get_xsec_unc(mass)
 pdf_Wprime = 1+xsecUnc['qq_PDF_Wprime']
 pdf_Zprime = 1+xsecUnc['qq_PDF_Zprime']
 scale_Wprime = 1+xsecUnc['qq_scale_Wprime']
 scale_Zprime = 1+xsecUnc['qq_scale_Zprime']
 
 newline1 = 'CMS_XS_qq_PDF lnN				    '
 newline2 = 'CMS_XS_qq_scale lnN				    '
 
 for l in range(len(fWZ)):
  if "kmax" in fWZ[l]:
   fWZsplit = fWZ[l].split(' ') 
   fWZ[l] = fWZ[l].replace(fWZsplit[1],str(int(fWZsplit[1])+1))
  if "CMS_xww_XS_Wprime_WZ_13TeV" in fWZ[l]: continue
  if "rate" in fWZ[l]:
   line="rate 				    "
   fWZsplit=fWZ[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   i=0
   for s in range(len(fWZsplit)):
    try: float(fWZsplit[s])
    except: continue
    signal=(s in [1,6,11,16,21,26,31,36]) # only change signal
    numberWZ=float(fWZsplit[s])
    if signal:
     #print "ch",i+1," wz ",numberWZ*WprimeWZ[mass]*100.," wh ",WHeff[i]*WprimeWH[mass]*2197.956," effwh ",WHeff[i]," effwz ",numberWZ/0.01/2197.956
     numberWZ=numberWZ*WprimeWZ[mass]*100.+WHeff[i]*WprimeWH[mass]*2197.956 # cards from Jennnifer are in units of 0.01 pb
     i+=1
     newline1+="%.3f  "%pdf_Wprime
     newline2+="%.3f  "%scale_Wprime
    else:
     newline1+="-  "
     newline2+="-  "
    line+="%.5e  " % numberWZ
   line+="\n"
   f.write(line)
  else:
   f.write(fWZ[l])

 f.write(newline1)
 f.write('\n')
 f.write(newline2)
 f.close()
