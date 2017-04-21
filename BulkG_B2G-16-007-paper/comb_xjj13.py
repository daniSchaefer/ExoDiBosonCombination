import os,sys

masses =[m*100 for m in range(12,40+1)]
if len(sys.argv)>1:
  masses=[int(sys.argv[1])]
  
for m in masses:

 fWW=open("comb_%i/comb_xjj13ww.%i.txt"%(m,m)).readlines()
 fZZ=open("comb_%i/comb_xjj13zz.%i.txt"%(m,m)).readlines()
 f=open("comb_%i/comb_xjj13.%i.txt"%(m,m),"w")
 print "comb_%i/comb_xjj13.%i.txt"%(m,m)
 
 for l in range(len(fWW)):
   if "rate" in fWW[l]:
     line="rate 				    "
     fWWsplit=fWW[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
     fZZsplit=fZZ[l].replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").split(" ")
     #print fWWsplit
     #print fZZsplit
     for s in range(len(fWWsplit)):
       try:
 	 float(fWWsplit[s])
       except: continue
       signalAlt=(s in [2,5,8,11,14,17]) # ZZ
       signal=(s in [1,4,7,10,13,16]) #WW
       numberWW=float(fWWsplit[s])
       numberZZ=float(fZZsplit[s])
       if signal:
         numberWW=numberWW
       if signalAlt:
        numberWW=numberZZ
       line+="%.5e  " % numberWW
     line+="\n"
     f.write(line)
   else:
     f.write(fWW[l]) 
