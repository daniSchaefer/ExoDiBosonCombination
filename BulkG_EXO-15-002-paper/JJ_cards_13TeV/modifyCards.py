import sys,os
import ROOT
from ROOT import *
import math
 
def get_sys(mass):

 fsys = []
 sys = ((mass/2)*0.00442857+4.5)/100.
 
 tothp = math.sqrt(0.055*0.055+0.03*0.03+0.003*0.003+sys*sys)
 fsys.append( (1+tothp/0.951)*(1+tothp/0.951) )
 fsys.append( (1-tothp/0.951)*(1-tothp/0.951) )

 totlp = math.sqrt(0.294*0.294+0.13*0.13+0.008*0.008+sys*sys)
 fsys.append( (1+tothp/0.951)*(1-totlp/1.245) )
 fsys.append( (1-tothp/0.951)*(1+totlp/1.245) )
  
 return fsys
   
mass =[m*100 for m in range(12,40+1)]

indir = 'JJ_cards_13TeV/'
outdir = 'JJ_cards_13TeV/'
  
for m in mass:

 card = "/CMS_jj_BulkZZ_%s_13TeV_CMS_jj_VV.txt"%m
 
 infile = open(indir+card,"r")
 outfile = open('tmp.txt',"w")
 
 for l in infile:
    
  if 'CMS_eff_vtag_tau21_sf_13TeV' in l:
   print m,"HPHP %.3f/%.3f"%(get_sys(m)[0],get_sys(m)[1]),"HPLP %.3f/%.3f"%(get_sys(m)[2],get_sys(m)[3])
   l = l.replace('1.121/0.885','%.3f/%.3f'%(get_sys(m)[0],get_sys(m)[1]))
   l = l.replace('0.794/1.176','%.3f/%.3f'%(get_sys(m)[2],get_sys(m)[3]))
  
  outfile.write(l)
  
 infile.close()
 outfile.close()
 os.system("mv tmp.txt %s"%(outdir+card))
