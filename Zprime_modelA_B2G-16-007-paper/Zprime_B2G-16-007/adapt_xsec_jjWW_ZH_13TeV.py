from array import array
import sys
import ROOT
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
   
   #WWHP (g1), WZHP (g2), ZZHP (g3), WWLP (g1), WZLP (g2), ZZLP (g3)
   
   fHP = TFile.Open('jjVH_sigEff_13TeV/HP_VH_SigEff.root','R')
   cHP = fHP.Get('c0')
   for p in cHP.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs():
      if g.GetName() == 'g1': dEff['WWHP'] = g.Eval(mass) 
      if g.GetName() == 'g2': dEff['WZHP'] = g.Eval(mass) 
      if g.GetName() == 'g3': dEff['ZZHP'] = g.Eval(mass) 
   fHP.Close()
   
   fLP = TFile.Open('jjVH_sigEff_13TeV/LP_VH_SigEff.root','R')
   cLP = fLP.Get('c1')
   for p in cLP.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs():
      if g.GetName() == 'g1': dEff['WWLP'] = g.Eval(mass) 
      if g.GetName() == 'g2': dEff['WZLP'] = g.Eval(mass) 
      if g.GetName() == 'g3': dEff['ZZLP'] = g.Eval(mass) 
   fLP.Close()
   
   #keep this order
   effs.append( dEff['WWHP'] )
   effs.append( dEff['WZHP'] )
   effs.append( dEff['ZZHP'] )
   effs.append( dEff['WWLP'] )
   effs.append( dEff['WZLP'] )
   effs.append( dEff['ZZLP'] )
   
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

ZprimeWW={}
ZprimeZH={}
for mass in masses:

 m = int((mass-800)/100)
 #print "mass = ",mass
 
 try:
   fWW=open("JJ_cards_13TeV/CMS_jj_ZprimeWW_"+str(mass)+"_13TeV_CMS_jj_VVnew.txt").readlines()
 except:
   print "could not open"
   continue
   
 outfile="JJ_cards_13TeV/CMS_jj_Zprimefix_WW_ZH_"+str(mass)+"_13TeV_CMS_jj_VVnew.txt"
 print outfile
 f=open(outfile,"w")

 ZprimeWW[mass]=xsecMap['CX0(pb)'][m]*xsecMap['BRWW'][m]
 ZprimeZH[mass]=xsecMap['CX0(pb)'][m]*xsecMap['BRhZ'][m]*0.577*0.6991
 ZHeff = get_efficiency(mass)

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
   fWW[l] = fWW[l].replace(fWWsplit[1],str(int(fWWsplit[1])+1))
  if "CMS_xww_XS_Zprime_13TeV" in fWW[l]: continue
  if "rate" in fWW[l]:
   line="rate 				    "
   fWWsplit=fWW[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   i = 0
   for s in range(len(fWWsplit)):
    try: float(fWWsplit[s])
    except: continue
    signal=(s in [2,5,8,11,14,17]) # only change signal
    numberWW=float(fWWsplit[s])
    if signal:
     #print numberWW*100./2600.,ZHeff[i], ZHeff[i]*0.577*0.6991
     numberWW=numberWW*ZprimeWW[mass]*100.+ZHeff[i]*ZprimeZH[mass]*2564.649 # cards from Jennnifer are in units of 0.01 pb
     i+=1
     newline1+="%.3f  "%pdf_Zprime
     newline2+="%.3f  "%scale_Zprime
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
