#!/usr/bin/env python
import array, math
import os
import sys
from ROOT import *

### Make changes here if it is needed
channels = ["xvh","xwh","xzh","ALL"]
channels = ["xwh","ALL"]
m=open("masses.txt")
masses=[int(mm.strip("")) for mm in m.readlines()]

for channel in channels:
  limit=array.array("d");
  limit.append(0)
  mh=array.array("d");
  mh.append(0)
  quantileExpected=array.array("f");
  quantileExpected.append(0)
  limitOfile =open("observedLimit_"+channel+".txt");
  limitE0file =open("expectedLimit_"+channel+".txt");
  limitM2file =open("limitM2_"+channel+".txt");
  limitM1file =open("limitM1_"+channel+".txt");
  limitP1file =open("limitP1_"+channel+".txt");
  limitP2file =open("limitP2_"+channel+".txt");

  f = TFile.Open("higgsCombine"+channel+".HybridNew.TOTAL.root","RECREATE");
  t = TTree("limit","limit");
  t.Branch("limit",limit,"limit/D");
  t.Branch("mh",mh,"mh/D");
  t.Branch("quantileExpected",quantileExpected,"quantileExpected/F");

  for mass in masses:
   print mass,channel
   mh[0] = mass;
   print "Harvesting mass %g" % mass;
    
   try:
    limit[0]=float(limitM2file.readline());
    quantileExpected[0] = 0.025;
    print "%g\t%g\t%g" % (mass,limit[0],quantileExpected[0]);
   except:
     print "error"
   try:
    t.Fill();
    limit[0]=float(limitM1file.readline());
    quantileExpected[0] = 0.16;
    print "%g\t%g\t%g" % (mass,limit[0],quantileExpected[0]);
    t.Fill();
   except:
     print "error"
   try:
    limit[0]=float(limitE0file.readline());
    quantileExpected[0] = 0.5;
    print "%g\t%g\t%g" % (mass,limit[0],quantileExpected[0]);
    t.Fill();
   except:
     print "error"
   try:
    limit[0]=float(limitP1file.readline());
    quantileExpected[0] = 0.84;
    print "%g\t%g\t%g" % (mass,limit[0],quantileExpected[0]);
    t.Fill();
   except:
     print "error"
   try:
    limit[0]=float(limitP2file.readline());
    quantileExpected[0] = 0.975;
    print "%g\t%g\t%g" % (mass,limit[0],quantileExpected[0]);
    t.Fill();
   except:
     print "error"
   try:
    limit[0]=float(limitOfile.readline());
    quantileExpected[0] = -1;
    print "%g\t%g\t%g" % (mass,limit[0],quantileExpected[0]);
    t.Fill();
   except:
     print "error"
   
  t.Write();
  f.Close();
