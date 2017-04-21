import os,sys
import time

def formatFile(fname):

 print fname
 infile = open(fname,'r')
 outfile = open('tmp.txt','w')

 l = "M0,M+,g,gv,ch,cq,cl,c3,cvvw,cvvhh,cvvv,total_widthV0GeV,BRWW,BRhZ,BRuu,BRdd,BRll,BRnunu,BRbb,BRtt,total_widthV+GeV,BRZW,BRWGam,BRWh,BRud,BRus,BRlnu,BRtb,CX+(pb),CX0(pb),CX-(pb)"
 l = l.replace(',','	')
 outfile.write(l+"\n")

 l = infile.readline()
 l = l.strip('{{').strip('}}')
 lSplit = l.split('},{')
 for s in lSplit:
  s = s.replace(',','	')
  s = s.replace('*10^','e')
  outfile.write(s+"\n")

 infile.close()
 outfile.close()

 #time.sleep(100)
 os.system('mv tmp.txt %s'%fname)

for i in range(1,9): formatFile('file%i-M3500_8TeV.txt'%i)
