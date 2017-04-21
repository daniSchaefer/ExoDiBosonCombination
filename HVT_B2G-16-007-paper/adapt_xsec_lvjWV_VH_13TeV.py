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
   effs.append( dEff['el_HPW'] )
   effs.append( dEff['el_HPZ'] )
   
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

WprimeWH={}

for mass in masses:

 m = int((mass-800)/100)
 #print "mass = ",mass
 
 try:
   fWV=open("LVJ_cards_13TeV/wwlvj_Vprime_WV_lvjj_M"+str(mass)+"_combo_ALLP_unbin.txt").readlines()
 except:
   print "could not open"
   continue
   
 outfile="LVJ_cards_13TeV/wwlvj_Vprimefix_WV_VH_lvjj_M"+str(mass)+"_combo_ALLP_unbin.txt"
 print outfile
 f=open(outfile,"w")

 WprimeWH[mass]=(xsecMap['CX-(pb)'][m]+xsecMap['CX+(pb)'][m])*xsecMap['BRWh'][m]*0.322*0.577
 WHeff = get_efficiency(mass)

 for l in range(len(fWV)):
  if "rate" in fWV[l]:
   line="rate 				    "
   fWVsplit=fWV[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   i=0
   for s in range(len(fWVsplit)):
    try: float(fWVsplit[s])
    except: continue
    signal=(s in [1,7,13,19,]) # only change signal
    numberWV=float(fWVsplit[s])
    if signal:
     numberWV=numberWV+WHeff[i]*WprimeWH[mass]*2197.956
     i+=1
    line+="%.5e  " % numberWV
   line+="\n"
   f.write(line)
  else:
   f.write(fWV[l])

 f.close() 
   
