from array import array
import sys
from ROOT import *
import ROOT

def get_xsec_unc(mass):

   uncs = {}
   
   fin = TFile.Open('XsecUnc/xsec-unc-13TeV.root','READ')   
   cin = fin.Get('c')
   for p in cin.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): uncs[g.GetName()] = g.Eval(mass) 
   fin.Close() 
   
   return uncs
   
def get_theo_map(model=""):

   V_mass = array('d',[])

   brs = {}
   index = {}

   mapping = ["M0","M+","BRWW","BRhZ","BRZW","BRWh","CX+(pb)","CX0(pb)","CX-(pb)"]

   for m in xrange(0,len(mapping)):
      if mapping[m] != "M0" and mapping[m] != "M+":
   	 brs[mapping[m]] = array('d',[])
   	 #print mapping[m]

   f = open('xsect_HVT%s_13TeV.txt'%model,'r')
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

   f = open('xsect_HVT%s_13TeV.txt'%model,'r')
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

thMapA = get_theo_map("A")
xsecMapA = thMapA[0]
massMapA = thMapA[1]

masses =[m*100 for m in range(6,40+1)]

if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

ZprimeWW={}
WprimeWZ={}
for mass in masses:

 m = int((mass-600)/50)
 
 try:
   fWW=open("LVJlowmass_cards_13TeV/wwlvj_Vprime"+str(mass)+"_em_HP_unbin.txt").readlines()
 except:
   print "could not open"
   continue
   
 outfile="LVJlowmass_cards_13TeV/wwlvj_VprimeFix"+str(mass)+"_em_HP_unbin.txt"
 print outfile
 f=open(outfile,"w")

 ZprimeWW[mass]=xsecMapA['CX0(pb)'][m]*xsecMapA['BRWW'][m]*2*0.322*0.6760
 WprimeWZ[mass]=(xsecMapA['CX-(pb)'][m]+xsecMapA['CX+(pb)'][m])*xsecMapA['BRZW'][m]*0.322*0.6991
   
 for l in range(len(fWW)):
  if "rate" in fWW[l]:
   line="rate 				    "
   fWWsplit=fWW[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   for s in range(len(fWWsplit)):
    try: float(fWWsplit[s])
    except: continue
    signal=(s in [1,7]) # only change signal
    signalAlt=(s in [2,8]) # only change signal
    numberWW=float(fWWsplit[s])
    if signal:
     #print "Wprime",numberWW
     numberWW=numberWW*WprimeWZ[mass] # cards from Jennnifer are in units of 0.01 pb
    if signalAlt:
     #print "Zprime",numberWW
     numberWW=numberWW*ZprimeWW[mass] # cards from Jennnifer are in units of 0.01 pb
    line+="%.5e  " % numberWW
   line+="\n"
   f.write(line)
  else:
   f.write(fWW[l])

 f.close()
