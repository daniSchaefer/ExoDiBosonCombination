import sys,os
import ROOT
from ROOT import *
import math
 
def get_sys(mass):

 tot = math.sqrt(0.055*0.055+0.03*0.03+0.003*0.003)
 return 1+tot/0.951
   
mass =[600,700,750,800,900,1000]

indir = 'WWlowmass_cards_13TeV/'
outdir = 'WWlowmass_cards_13TeV/'
  
for m in mass:

 card = "/wwlvj_BulkGraviton%s_em_HP_unbin.txt"%m
 
 infile = open(indir+card,"r")
 outfile = open('tmp.txt',"w")
 
 for l in infile:

  if 'kmax' in l:
  
   lsplit = l.split(' ')
   l = l.replace(lsplit[1],str(int(lsplit[1])+1))
       
  if 'CMS_eff_vtag_tau21_sf_13TeV' in l:

   syst = 5.90094*math.log(m/2./200.)/100.
   print m,get_sys(m),1+syst
   
   lsplit = l.replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
   l = l.replace(lsplit[2],'%.3f'%get_sys(m))
   
   newline = 'CMS_eff_vtag_tau21_pt_13TeV   lnN                1.044  -            1.044  -            -            1.044  -            1.044  -            -          ' 

   newline = newline.replace('1.044','%.3f'%(1+syst))
   newline+='\n'
   l = l+newline
    
  outfile.write(l)
  
 infile.close()
 outfile.close()
 os.system("mv tmp.txt %s"%(outdir+card))
