#!/usr/bin/env python
import array, math
import os
import sys

### Make changes here if it is needed
channels = ["xvh","xwh","xzh","ALL"]
channels = ["xwh","ALL"]
m=open("masses.txt")
masses=[int(mm.strip("\n")) for mm in m.readlines()]

for channel in channels:
 
 f1=open("observedLimit_"+channel+".txt","w")
 f2=open("limitM2_"+channel+".txt","w")
 f3=open("limitM1_"+channel+".txt","w")
 f4=open("expectedLimit_"+channel+".txt","w")
 f5=open("limitP1_"+channel+".txt","w")
 f6=open("limitP2_"+channel+".txt","w")

 for mass in masses:
  print mass,channel
  os.system("grep '95%' comb_"+str(mass)+"/limitOb*"+channel+"*txt | awk '{print $4}' >qwe.txt")
  f1.write(open("qwe.txt").readline().replace("\n","")+"\n")
  os.system("grep '95%' comb_"+str(mass)+"/limitM2*"+channel+"*txt | awk '{print $4}' >qwe.txt")
  f2.write(open("qwe.txt").readline().replace("\n","")+"\n")
  os.system("grep '95%' comb_"+str(mass)+"/limitM1*"+channel+"*txt | awk '{print $4}' >qwe.txt")
  f3.write(open("qwe.txt").readline().replace("\n","")+"\n")
  os.system("grep '95%' comb_"+str(mass)+"/limitE0*"+channel+"*txt | awk '{print $4}' >qwe.txt")
  f4.write(open("qwe.txt").readline().replace("\n","")+"\n")
  os.system("grep '95%' comb_"+str(mass)+"/limitP1*"+channel+"*txt | awk '{print $4}' >qwe.txt")
  f5.write(open("qwe.txt").readline().replace("\n","")+"\n")
  os.system("grep '95%' comb_"+str(mass)+"/limitP2*"+channel+"*txt | awk '{print $4}' >qwe.txt")
  f6.write(open("qwe.txt").readline().replace("\n","")+"\n")
