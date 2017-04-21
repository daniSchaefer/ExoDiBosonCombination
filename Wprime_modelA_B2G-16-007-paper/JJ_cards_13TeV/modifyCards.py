import sys,os
import ROOT
from ROOT import *
import math
 
def get_sys(mass):

 fsys = []
 sys = 5.90094*math.log(mass/2./200.)/100.
 
 tothp = math.sqrt(0.055*0.055+0.03*0.03+0.003*0.003)
 fsys.append( (1+tothp/0.951)*(1+tothp/0.951) )
 fsys.append( (1-tothp/0.951)*(1-tothp/0.951) )

 totlp = math.sqrt(0.294*0.294+0.13*0.13+0.008*0.008)
 fsys.append( (1+tothp/0.951)*(1-totlp/1.245) )
 fsys.append( (1-tothp/0.951)*(1+totlp/1.245) )
  
 return fsys

def get_sys_pt(mass):

 fsys = []
 systhp = 5.90094*math.log(mass/2./200.)/100.
 
 fsys.append( (1+systhp)*(1+systhp) )
 fsys.append( (1-systhp)*(1-systhp) )

 tothp = math.sqrt(0.055*0.055+0.03*0.03+0.003*0.003)/0.951
 totlp = math.sqrt(0.294*0.294+0.13*0.13+0.008*0.008)/1.245
 systlp = systhp*totlp/tothp
 
 #print systhp,totlp,tothp,systlp
 #sys.exit()
 fsys.append( (1+systhp)*(1-systlp) )
 fsys.append( (1-systhp)*(1+systlp) )
  
 return fsys
    
mass =[m*100 for m in range(12,40+1)]

indir = 'JJ_cards_13TeV/'
outdir = 'JJ_cards_13TeV/'
  
for m in mass:

 card = "/CMS_jj_WZ_%s_13TeV_CMS_jj_VV.txt"%m
 
 infile = open(indir+card,"r")
 outfile = open('tmp.txt',"w")
 
 for l in infile:
    
  if 'CMS_eff_vtag_tau21_sf_13TeV' in l:

   
   lsplit = l.replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")

   #print m,"*** SF **** HPHP %.3f/%.3f"%(get_sys(m)[0],get_sys(m)[1]),"HPLP %.3f/%.3f"%(get_sys(m)[2],get_sys(m)[3])
   print m,"*** PT **** HPHP %.3f/%.3f"%(get_sys_pt(m)[0]-1,1-get_sys_pt(m)[1]),"HPLP %.3f/%.3f"%(1-get_sys_pt(m)[2],get_sys_pt(m)[3]-1)

   l = l.replace(lsplit[2],'%.3f/%.3f'%(get_sys(m)[0],get_sys(m)[1])).replace(lsplit[11],'%.3f/%.3f'%(get_sys(m)[2],get_sys(m)[3]))
   
   newline = 'CMS_eff_vtag_tau21_pt_13TeV   lnN              1.199/0.819  1.199/0.819  -            1.199/0.819  1.199/0.819  -            1.199/0.819  1.199/0.819  -            0.806/1.144  0.806/1.144  -            0.806/1.144  0.806/1.144  -            0.806/1.144  0.806/1.144  -          ' 
   newline = newline.replace('1.199/0.819','%.3f/%.3f'%(get_sys_pt(m)[0],get_sys_pt(m)[1])).replace('0.806/1.144','%.3f/%.3f'%(get_sys_pt(m)[2],get_sys_pt(m)[3]))
   newline+='\n'
   l = l+newline
    
  outfile.write(l)
  
 infile.close()
 outfile.close()
 os.system("mv tmp.txt %s"%(outdir+card))
