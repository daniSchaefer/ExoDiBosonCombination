from ROOT import *
import ROOT
import array, math
import os

masses =[m*100 for m in range(8,30+1)]

print "8 TeV"
#xsec_x_VH=[900,1000,1500,2000,2500,3000]
#xsec_y_VH=[log(713.95*0.5223),log(501.244*0.5079),log(76.974*0.4849),log(12.886*0.4791),log(2.242*0.4767),log(0.3804*0.4754)]
#xsec_x_array_VH=array.array('d')
#xsec_y_array_VH=array.array('d')
#for p in xsec_x_VH: xsec_x_array_VH.append(p)
#for p in xsec_y_VH: xsec_y_array_VH.append(p)
#g_VH=TGraph(len(xsec_x_array_VH),xsec_x_array_VH,xsec_y_array_VH)
HVTWprime={}
HVTZprime={}
HVTBRWH={}
HVTBRWW={}
HVTBRZH={}
HVTBRZW={}
for line in open("HVTcrossSection.txt").readlines()[1:]:
   split=line.replace("\n","").split(",")
   HVTWprime[int(float(split[0]))]=float(split[-1])+float(split[-3])
   HVTZprime[int(float(split[0]))]=float(split[-2])
   HVTBRWH[int(float(split[0]))]=float(split[-8])
   HVTBRWW[int(float(split[0]))]=float(split[-19])
   HVTBRZH[int(float(split[0]))]=float(split[-18])
   HVTBRZW[int(float(split[0]))]=float(split[-10])
print HVTWprime[1000],HVTZprime[1000],HVTBRWH[1000],HVTBRWW[1000],HVTBRZH[1000],HVTBRZW[1000]

f_out_VH=open("theory_HVT_VH_8TeV.txt","w")
for mass in masses:
        #theoryVH=exp(g_VH.Eval(mass))/1000.
        theoryVH=HVTWprime[mass]*HVTBRWH[mass]+HVTZprime[mass]*HVTBRZH[mass]
	f_out_VH.write(str(mass)+" "+str(theoryVH)+"\n")
        print "mass = ",mass,"theoryVH = ",theoryVH
f_out_VH.close()

f_out_WH=open("theory_HVT_WH_8TeV.txt","w")
for mass in masses:
        #theoryWH=exp(g_WH.Eval(mass))/1000.
        theoryWH=HVTWprime[mass]*HVTBRWH[mass]
	f_out_WH.write(str(mass)+" "+str(theoryWH)+"\n")
        print "mass = ",mass,"theoryWH = ",theoryWH
f_out_WH.close()

f_out_ZH=open("theory_HVT_ZH_8TeV.txt","w")
for mass in masses:
        #theoryZH=exp(g_ZH.Eval(mass))/1000.
        theoryZH=HVTZprime[mass]*HVTBRZH[mass]
	f_out_ZH.write(str(mass)+" "+str(theoryZH)+"\n")
        print "mass = ",mass,"theoryZH = ",theoryZH
f_out_ZH.close()

f_out_VW=open("theory_HVT_VW_8TeV.txt","w")
for mass in masses:
        #theoryVW=exp(g_VW.Eval(mass))/1000.
        theoryVW=HVTWprime[mass]*HVTBRZW[mass]+HVTZprime[mass]*HVTBRWW[mass]
	f_out_VW.write(str(mass)+" "+str(theoryVW)+"\n")
        print "mass = ",mass,"theoryVW = ",theoryVW
f_out_VW.close()

f_out_WZ=open("theory_HVT_WZ_8TeV.txt","w")
for mass in masses:
        #theoryWZ=exp(g_WZ.Eval(mass))/1000.
        theoryWZ=HVTWprime[mass]*HVTBRZW[mass]
	f_out_WZ.write(str(mass)+" "+str(theoryWZ)+"\n")
        print "mass = ",mass,"theoryWZ = ",theoryWZ
f_out_WZ.close()

f_out_WW=open("theory_HVT_WW_8TeV.txt","w")
for mass in masses:
        #theoryWW=exp(g_WW.Eval(mass))/1000.
        theoryWW=HVTZprime[mass]*HVTBRWW[mass]
	f_out_WW.write(str(mass)+" "+str(theoryWW)+"\n")
        print "mass = ",mass,"theoryWW = ",theoryWW
f_out_WW.close()

f_out_HVT=open("theory_HVT_8TeV.txt","w")
for mass in masses:
        #theoryHVT=exp(g_HVT.Eval(mass))/1000.
        theoryHVT=HVTWprime[mass]+HVTZprime[mass]
	f_out_HVT.write(str(mass)+" "+str(theoryHVT)+"\n")
        print "mass = ",mass,"theoryHVT = ",theoryHVT
f_out_HVT.close()

