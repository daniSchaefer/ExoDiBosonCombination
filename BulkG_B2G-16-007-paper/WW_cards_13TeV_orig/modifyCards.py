import sys,os
import ROOT
from ROOT import *
import math
 
def get_sys(mass):

 tot = math.sqrt(0.028*0.028+0.003*0.003+0.02*0.02)
 return 1+tot/1.007
   
mass =[m*100 for m in range(8,40+1)]

indir = 'WW_cards_13TeV/'
outdir = 'WW_cards_13TeV/'
  
for m in mass:

 card = "/wwlvj_BulkG_WW_lvjj_M%i_combo_ALLP_unbin.txt"%m
 
 infile = open(indir+card,"r")
 outfile = open('tmp.txt',"w")
 
 for l in infile:

  if 'kmax' in l:
  
   lsplit = l.split(' ')
   l = l.replace(lsplit[1],str(int(lsplit[1])+1))
       
  if 'CMS_eff_vtag_tau21_sf_13TeV' in l:

   syst = 4.53132*math.log(m/2./200.)/100.
   print m,get_sys(m),1+syst
   
   lsplit = l.replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   l = l.replace(lsplit[2],'%.3f'%get_sys(m))
   
   newline = 'CMS_eff_vtag_tau21_pt_13TeV   lnN                1.028/0.972   -             -             1.028/0.972   -             1.028/0.972   -             -             1.028/0.972   -             1.028/0.972   -             -             1.028/0.972   -             1.028/0.972   -             -             1.028/0.972   -           ' 

   newline = newline.replace('1.028/0.972','%.3f'%(1+syst))
   newline+='\n'
   l = l+newline
    
  outfile.write(l)
  
 infile.close()
 outfile.close()
 os.system("mv tmp.txt %s"%(outdir+card))
