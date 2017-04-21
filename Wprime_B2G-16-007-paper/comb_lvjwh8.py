import sys,os
import ROOT
from ROOT import *

masses =[m*100 for m in range(8,25+1)]
if len(sys.argv)>1:
  masses=[int(sys.argv[1])]

def get_xsec_unc(mass):

   uncs = {}
   
   fin = TFile.Open('XsecUnc/xsec-unc-8TeV.root','READ')   
   cin = fin.Get('c')
   for p in cin.GetListOfPrimitives():
    if p.InheritsFrom("TMultiGraph"):
     for g in p.GetListOfGraphs(): uncs[g.GetName()] = g.Eval(mass) 
   fin.Close() 
   
   return uncs
   
for m in masses:

 xsecUnc =  get_xsec_unc(m)
 pdf_Wprime = 1+xsecUnc['qq_PDF_Wprime']
 pdf_Zprime = 1+xsecUnc['qq_PDF_Zprime']
 scale_Wprime = 1+xsecUnc['qq_scale_Wprime']
 scale_Zprime = 1+xsecUnc['qq_scale_Zprime']
 
 fname = 'comb_%i/comb_lvjwh8.%i.txt'%(m,m)
 
 fin = open(fname,'r')
 print fname
 
 fout = open('test.txt','w')
 for l in fin:
  if "kmax" in l:
   split = l.split(' ')
   l = l.replace(split[1],str(int(split[1])+2))
  fout.write(l)
  
 fout.write('CMS_XS_qq_PDF lnN %.3f - - - - %.3f - - - -\n'%(pdf_Wprime,pdf_Wprime)) 
 fout.write('CMS_XS_qq_scale lnN %.3f - - - - %.3f - - - -\n'%(scale_Wprime,scale_Wprime)) 

 fout.close()
 os.system('mv test.txt %s'%fname)
