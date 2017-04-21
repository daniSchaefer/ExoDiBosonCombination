import os
import glob
import math
import array
import sys
import time
from array import array
import ROOT
from ROOT import *
import CMS_lumi, tdrstyle
from optparse import OptionParser

def get_palette(mode):

 palette = {}
 palette['gv'] = [] 
 
 colors = ['#40004b','#762a83','#9970ab','#de77ae','#a6dba0','#5aae61','#1b7837','#00441b','#92c5de','#4393c3','#2166ac','#053061']

 for c in colors:
  palette['gv'].append(c)
 
 return palette[mode]

def get_theo_map(sqrts,model=""):

   V_mass = array('d',[])

   brs = {}
   index = {}

   mapping = ["M0","M+","BRWW","BRhZ","BRZW","BRWh","CX+(pb)","CX0(pb)","CX-(pb)"]

   for m in xrange(0,len(mapping)):
      if mapping[m] != "M0" and mapping[m] != "M+":
   	 brs[mapping[m]] = array('d',[])
   	 #print mapping[m]

   f = open('xsect_HVT%s_%sTeV.txt'%(model,sqrts),'r')
   for line in f:
      brDict = line.split(",")
      for d in xrange(0,len(brDict)):
   	 if brDict[d].find('\n') != -1:
   	    brDict[d] = brDict[d].split('\n')[0]
   	 for m in xrange(0,len(mapping)):
   	    if brDict[d] == mapping[m]:
   	       index[mapping[m]] = d
   	       #print "%s %i" %(mapping[m],d)
	    
   f.close()

   f = open('xsect_HVT%s_%sTeV.txt'%(model,sqrts),'r')
   for line in f:
      if line.find('M0') != -1: continue
      brDict = line.split(",")  	    
      V_mass.append(float(brDict[index['M0']]))
      for m in xrange(0,len(mapping)):
   	 if mapping[m] != "M0" and mapping[m] != "M+":
   	    brs[mapping[m]].append(float(brDict[index[mapping[m]]]))

   f.close()

   return [brs,V_mass]

def get_canvas(cname,lumi8,lumi13):

   tdrstyle.setTDRStyle()
   CMS_lumi.lumi_13TeV = "%s fb^{-1}"%lumi13
   CMS_lumi.lumi_8TeV = "%s fb^{-1}"%lumi8
   CMS_lumi.writeExtraText = 1
   CMS_lumi.extraText = "Preliminary"
   CMS_lumi.lumi_sqrtS = "13 TeV" # used with iPeriod = 0, e.g. for simulation-only plots (default is an empty string)
   iPos = 0
   if( iPos==0 ): CMS_lumi.relPosX = 0.13
   iPeriod=4

   H_ref = 630 
   W_ref = 600 
   W = W_ref
   H  = H_ref

   T = 0.08*H_ref
   B = 0.12*H_ref 
   L = 0.12*W_ref
   R = 0.04*W_ref

   canvas = ROOT.TCanvas(cname,cname,50,50,W,H)
   canvas.SetFillColor(0)
   canvas.SetBorderMode(0)
   canvas.SetFrameFillStyle(0)
   canvas.SetFrameBorderMode(0)
   canvas.SetLeftMargin( L/W+0.01 )
   canvas.SetRightMargin( R/W+0.03 )
   canvas.SetTopMargin( 0.07 ) #/T/H
   canvas.SetBottomMargin( B/H )
   #canvas.SetGrid()
   canvas.SetLogy()
   
   return canvas

def getAsymLimits(file,mass):
    
    f = ROOT.TFile(file,"READ")
    t = f.Get("limit")
    entries = t.GetEntries()
    
    lims = [-1,-1,-1,-1,-1,-1]
    
    for i in range(entries):
        
        t.GetEntry(i)
        t_quantileExpected = t.quantileExpected
        t_limit = t.limit
	t_mass = t.mh
        
	if t_mass != mass: continue
        #print "mass: ", t_mass , " limit: ", t_limit, ", quantileExpected: ",t_quantileExpected
        
        if t_quantileExpected == -1.: lims[0] = t_limit
        elif t_quantileExpected >= 0.024 and t_quantileExpected <= 0.026: lims[1] = t_limit
        elif t_quantileExpected >= 0.15  and t_quantileExpected <= 0.17:  lims[2] = t_limit
        elif t_quantileExpected == 0.5: lims[3] = t_limit
        elif t_quantileExpected >= 0.83  and t_quantileExpected <= 0.85:  lims[4] = t_limit
        elif t_quantileExpected >= 0.974 and t_quantileExpected <= 0.976: lims[5] = t_limit
        else: print "Unknown quantile!"
    
    return lims

def plot_Asympt_limits(label,mainLabel):

 infile = "results/higgsCombine%s.Asymptotic.TOTAL.root"%label
 mass = [600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,
         2100,2200,2300,2400,2500,2600,2700,2800,2900,3000,3100,3200,3300,3400,3500,
	 3600,3700,3800,3900,4000]	 
 
 names = {}
 names["JJLVJWPRIME13"]="lvJ, JJ (13 TeV)"
 names["ALLWPRIME13"]="lvJ, JJ (13 TeV)"
 names["ALLWVWPRIME8"]="lllv, llJ, lvJ, JJ (8 TeV)"
 names['ALLHVWPRIME8'] = "lvJ, JJ, J#tau#tau (8 TeV)"
 names['ALLWPRIME8'] = "lllv, llJ, lvJ, JJ, J#tau#tau (8 TeV)"
 names['lllv8']="lllv (8 TeV)"
 names["lvjwz8"]="lvqq (8 TeV)"
 names["lljwz8"]="llqq (8 TeV)"
 names["jjwzwh8"]="qqqq (8 TeV)"
 names["jjwzwh13"]="qqqq (13 TeV)"
 names["lvjwzh13"]="lvqq (13 TeV)"
 names["lvjwh13"]="lvbb (13 TeV)"
 names['ttjwh8'] = "qq#tau#tau (8 TeV)"
 names['jjwh8'] = "qqbb(4q) (8 TeV)"
 names['lvjwh8'] = "lvbb (8 TeV)"

 thMap13A = get_theo_map("13","A")
 xsecMap13A = thMap13A[0]

 thMap8A = get_theo_map("8","A")
 xsecMap8A = thMap8A[0]
  	     
 scale = {}
 scale['JJLVJWPRIME13'] = {}
 scale['ALLWPRIME13'] = {}
 scale['ALLWVWPRIME8'] = {}
 scale['ALLHVWPRIME8'] = {}
 scale['ALLWPRIME8'] = {}
 for m in mass:
 
  idxA = int((m-600)/50)
                
  scale['ALLWVWPRIME8'][m] = (xsecMap8A['CX-(pb)'][idxA]+xsecMap8A['CX+(pb)'][idxA])*(xsecMap8A['BRZW'][idxA]+xsecMap8A['BRWh'][idxA])
  scale['ALLHVWPRIME8'][m] = (xsecMap8A['CX-(pb)'][idxA]+xsecMap8A['CX+(pb)'][idxA])*(xsecMap8A['BRZW'][idxA]+xsecMap8A['BRWh'][idxA])
  scale['ALLWPRIME8'][m] = (xsecMap8A['CX-(pb)'][idxA]+xsecMap8A['CX+(pb)'][idxA])*(xsecMap8A['BRZW'][idxA]+xsecMap8A['BRWh'][idxA])
  scale['JJLVJWPRIME13'][m] = (xsecMap13A['CX-(pb)'][idxA]+xsecMap13A['CX+(pb)'][idxA])*(xsecMap13A['BRZW'][idxA]+xsecMap13A['BRWh'][idxA])
  scale['ALLWPRIME13'][m] = (xsecMap13A['CX-(pb)'][idxA]+xsecMap13A['CX+(pb)'][idxA])*(xsecMap13A['BRZW'][idxA]+xsecMap13A['BRWh'][idxA])
       
 nPoints = 0
 
 xbins	   = array('d', [])
 xbins_env = array('d', [])
 ybins_exp = array('d', [])
 ybins_obs = array('d', [])
 ybins_1s  = array('d', [])
 ybins_2s  = array('d', [])
 ybins_xs  = array('d', [])

 firstMass = 0.6
 for m in mass:

  curAsymLimits = getAsymLimits(infile,m);
  if curAsymLimits[0] == -1: continue
  firstMass = m/1000.
  break
  
 lastMass = 0.6
 for m in mass:

  curAsymLimits = getAsymLimits(infile,m);
  if curAsymLimits[0] == -1:
   #print "************** MISSING MASS POINT = ",m
   continue
  #print m,curAsymLimits[3]*scale[mainLabel][m],curAsymLimits[0]*scale[mainLabel][m],scale[mainLabel][m]
  lastMass = m/1000.
  xbins.append( m/1000. );
  xbins_env.append( m/1000. );
  ybins_exp.append( curAsymLimits[3]*scale[mainLabel][m] );
  ybins_obs.append( curAsymLimits[0]*scale[mainLabel][m] );
  ybins_2s.append( curAsymLimits[1]*scale[mainLabel][m]);
  ybins_1s.append( curAsymLimits[2]*scale[mainLabel][m] );
  ybins_xs.append( scale[mainLabel][m] );
  nPoints+=1

 for i in range( len(mass)-1, -1, -1 ):

  curAsymLimits = getAsymLimits(infile,mass[i]);
  if curAsymLimits[0] == -1: continue
  xbins_env.append( mass[i]/1000. );
  ybins_2s.append( curAsymLimits[5]*scale[mainLabel][mass[i]] );
  ybins_1s.append( curAsymLimits[4]*scale[mainLabel][mass[i]] );

 lumi13 = ""
 lumi8 = ""
 if "13" in label:
  if label.find("ALL") != -1: lumi13 = "2.3-2.7"
  elif label.find("jj") != -1: lumi13 = "2.7"
  else: lumi13 = "2.3"
 elif "8" in label: lumi8 = "19.7"
  
 canv = get_canvas("c_lim_Asymptotic",lumi8,lumi13)
 canv.cd()
      
 curGraph_exp	 = ROOT.TGraphAsymmErrors(nPoints,xbins,ybins_exp)
 curGraph_exp.SetName("LimitExpectedCLs")
 curGraph_obs	 = ROOT.TGraphAsymmErrors(nPoints,xbins,ybins_obs)
 curGraph_obs.SetName("LimitObservedCLs")
 curGraph_xs	 = ROOT.TGraph(nPoints,xbins,ybins_xs)
 curGraph_xs.SetName("CrossSectionTheo")
 curGraph_1s	 = ROOT.TGraphAsymmErrors(nPoints*2,xbins_env,ybins_1s)
 curGraph_1s.SetName("Limit68CLs")
 curGraph_2s	 = ROOT.TGraphAsymmErrors(nPoints*2,xbins_env,ybins_2s)
 curGraph_2s.SetName("Limit95CLs")
 
 curGraph_obs.SetMarkerStyle(20)
 curGraph_obs.SetLineWidth(3)
 curGraph_obs.SetLineStyle(1)
 curGraph_obs.SetMarkerSize(1)
 curGraph_exp.SetMarkerSize(1.3)
 curGraph_exp.SetMarkerColor(ROOT.kBlack)

 curGraph_exp.SetLineStyle(2)
 curGraph_exp.SetLineWidth(3)
 curGraph_exp.SetMarkerSize(2)
 curGraph_exp.SetMarkerStyle(24)
 curGraph_exp.SetMarkerColor(ROOT.kBlack)

 curGraph_xs.SetLineStyle(ROOT.kSolid)
 curGraph_xs.SetFillStyle(3344)
 curGraph_xs.SetLineWidth(2)
 curGraph_xs.SetMarkerSize(2)
 curGraph_xs.SetLineColor(ROOT.kRed)

 transGreen = gROOT.GetColor(3)
 transGreen.SetAlpha(0.35)
 curGraph_1s.SetFillColor(3)
 curGraph_1s.SetFillStyle(1001)
 curGraph_1s.SetLineStyle(ROOT.kDashed)
 curGraph_1s.SetLineWidth(3)

 transYellow = gROOT.GetColor(5)
 transYellow.SetAlpha(0.5)
 curGraph_2s.SetFillColor(5)
 curGraph_2s.SetFillStyle(1001)
 curGraph_2s.SetLineStyle(ROOT.kDashed)
 curGraph_2s.SetLineWidth(3)

 hrl_SM = canv.DrawFrame(firstMass-0.050,1e-03, lastMass+0.050, 100)
 
 ytitle = "#sigma_{95%} #times BR_{W' #rightarrow WZ/WH} (pb)"
 hrl_SM.GetYaxis().SetTitle(ytitle)
 hrl_SM.GetYaxis().SetTitleSize(0.045)
 hrl_SM.GetXaxis().SetTitleSize(0.045)
 hrl_SM.GetXaxis().SetLabelSize(0.035)
 hrl_SM.GetYaxis().SetLabelSize(0.035)
 hrl_SM.GetYaxis().SetTitleOffset(1.1)
 hrl_SM.GetXaxis().SetTitleOffset(1.1)
 hrl_SM.GetXaxis().SetTitle("M_{W'} (TeV)")
     
 curGraph_2s.Draw("F")
 curGraph_1s.Draw("Fsame")
 curGraph_exp.Draw("Lsame")
 curGraph_obs.Draw("Lsame")
 curGraph_xs.Draw("Csame")
 
 leg2 = ROOT.TLegend(0.3724832,0.5963455,0.8875839,0.7973422)
 leg2.SetBorderSize(0);
 leg2.SetTextSize(0.031);
 leg2.SetLineColor(1);
 leg2.SetLineStyle(1);
 leg2.SetShadowColor(0);
 leg2.SetLineWidth(1);
 leg2.SetFillColor(0);
 leg2.SetTextFont(42)

 leg2.AddEntry(curGraph_obs,"Asympt. CL_{S} Observed","L")
 leg2.AddEntry(curGraph_1s,"Asympt. CL_{S} Expected #pm 1#sigma","LF")
 leg2.AddEntry(curGraph_2s,"Asympt. CL_{S} Expected #pm 2#sigma","LF")
 #theoleg = "#sigma_{TH} #times BR_{W' #rightarrow WZ/WH} , HVT_{B}"
 #leg2.AddEntry(curGraph_xs,theoleg,"L")     
 theoleg = "HVT_{A} (g_{V}=1)"
 leg2.AddEntry(curGraph_xs,theoleg,"L") 
 leg2.Draw()
 
 pt = ROOT.TPaveText(0.5486577,0.8355482,0.8993289,0.8920266,"NDC")
 pt.SetTextFont(42)
 pt.SetTextSize(0.031)
 pt.SetTextAlign(32)
 pt.SetFillColor(0)
 pt.SetBorderSize(0)
 pt.SetFillStyle(0)
 text = pt.AddText(names[label])
 text.SetTextFont(62)
  	  
 canv.Update()   
 canv.cd()
 
 period = 4
 if "8" in label: period = 2
 
 CMS_lumi.CMS_lumi(canv, period,0)   	
 canv.cd()
 canv.Update()
 canv.RedrawAxis()
 canv.RedrawAxis("g")
 leg2.Draw("same")
 pt.Draw("same")
 frame = canv.GetFrame()
 frame.Draw()	
 canv.cd()
 canv.Update() 
  
 canv.SaveAs("plots/EXOVVhvt_"+label+"_UL_Asymptotic_log.root")
 canv.SaveAs("plots/EXOVVhvt_"+label+"_UL_Asymptotic_log.C")
 canv.SaveAs("plots/EXOVVhvt_"+label+"_UL_Asymptotic_log.pdf")

def compare_Asympt_limits(labels,unblind,bands):
 
 palette = get_palette('gv')
 col = TColor()
 
 #line color
 lcol = {}
 lcol["JJLVJWPRIME13"] = kBlack
 lcol["ALLWPRIME13"] = kBlack
 lcol["ALLWVWPRIME8"] = kBlack
 lcol['ALLHVWPRIME8'] = kBlack
 lcol['ALLWPRIME8'] = kBlack
 lcol["lvjwzh13"] = col.GetColor(palette[11])
 lcol["jjwzwh13"] = col.GetColor(palette[9])
 lcol["lvjwh13"] = col.GetColor(palette[10])
 lcol['lllv8'] = col.GetColor(palette[0])
 lcol["lljwz8"] = col.GetColor(palette[1])
 lcol["lvjwz8"] = col.GetColor(palette[2])
 lcol['lvjwh8'] = col.GetColor(palette[3])
 lcol["jjwzwh8"] = col.GetColor(palette[6])
 lcol['jjwh8'] = col.GetColor(palette[5])
 lcol['ttjwh8'] = col.GetColor(palette[4])
 
 #marker color
 mcol = {}
 mcol["JJLVJWPRIME13"] = kBlack
 mcol["ALLWPRIME13"] = kBlack
 mcol["ALLWVWPRIME8"] = kBlack
 mcol['ALLHVWPRIME8'] = kBlack
 mcol['ALLWPRIME8'] = kBlack
 mcol["lvjwzh13"] = col.GetColor(palette[11])
 mcol["jjwzwh13"] = col.GetColor(palette[9])
 mcol["lvjwh13"] = col.GetColor(palette[10])
 mcol['lllv8'] = col.GetColor(palette[0])
 mcol["lljwz8"] = col.GetColor(palette[1])
 mcol["lvjwz8"] = col.GetColor(palette[2])
 mcol['lvjwh8'] = col.GetColor(palette[3])
 mcol["jjwzwh8"] = col.GetColor(palette[6])
 mcol['ttjwh8'] =  col.GetColor(palette[4])
 mcol['jjwh8'] = col.GetColor(palette[5])
 
 #marker style
 msty = {}
 msty["JJLVJWPRIME13"] = 20
 msty["ALLWPRIME13"] = 20
 msty["ALLWVWPRIME8"] = 20
 msty['ALLHVWPRIME8'] = 20
 msty['ALLWPRIME8'] = 20
 msty["lvjwzh13"] = 26
 msty["jjwzwh13"] = 22
 msty["lvjwh13"] = 31
 msty['lllv8'] = 22
 msty["lljwz8"] = 25
 msty["lvjwz8"] = 26
 msty['lvjwh8'] = 31
 msty["jjwzwh8"] = 22
 msty['ttjwh8'] = 25
 msty['jjwh8'] = 31
     
 names = {}
 names["JJLVJWPRIME13"]="lvJ, JJ (13 TeV)"
 names["ALLWPRIME13"]="lvJ, JJ (13 TeV)"
 names["ALLWVWPRIME8"]="lllv, llJ, lvJ, JJ (8 TeV)"
 names['ALLHVWPRIME8'] = "lvJ, JJ, J#tau#tau (8 TeV)"
 names['ALLWPRIME8'] = "lllv, llJ, lvJ, JJ, J#tau#tau (8 TeV)"
 names['lllv8'] = "lllv"
 names["lvjwz8"]="lvqq"
 names["lljwz8"]="llqq"
 names["jjwzwh8"]="qqqq"
 names["jjwzwh13"]="qqqq" 
 names["lvjwzh13"]="lvqq"
 names["lvjwh13"]="lvbb"
 names['ttjwh8'] = "qq#tau#tau"
 names['jjwh8'] = "qqbb(4q)"
 names['lvjwh8'] = "lvbb"
 
 legs1={}
 legs1["JJLVJWPRIME13"]=[0.38,0.68,0.90,0.84]
 legs1["ALLWPRIME13"]=[0.38,0.68,0.90,0.84]
 legs1["ALLWVWPRIME8"]=[0.38,0.68,0.90,0.84]
 legs1["ALLHVWPRIME8"]=[0.38,0.68,0.90,0.84]
 legs1["ALLWPRIME8"]=[0.38,0.68,0.90,0.84]
    
 legs2={}
 legs2["JJLVJWPRIME13"]=[0.38,0.61,0.90,0.65]
 legs2["ALLWPRIME13"]=[0.38,0.61,0.90,0.65]
 legs2["ALLWVWPRIME8"]=[0.38,0.57,0.90,0.65]
 legs2["ALLHVWPRIME8"]=[0.38,0.57,0.90,0.65]
 legs2["ALLWPRIME8"]=[0.38,0.55,0.90,0.65]

 legs3={}
 legs3["JJLVJWPRIME13"]=[0.19,0.20,0.42,0.29]
 legs3["ALLWPRIME13"]=[0.19,0.20,0.42,0.29]
 legs3["ALLWVWPRIME8"]=[0.18,0.18,0.45,0.31]
 legs3["ALLHVWPRIME8"]=[0.19,0.18,0.47,0.31]
 legs3["ALLWPRIME8"]=[0.17,0.15,0.48,0.28]
  
 ncols = {} 
 ncols["JJLVJWPRIME13"] = 1
 ncols["ALLWPRIME13"] = 1
 ncols["ALLWVWPRIME8"] = 1
 ncols["ALLHVWPRIME8"] = 1
 ncols["ALLWPRIME8"] = 2
    
 ymin = {}
 ymax = {}  
 ymin["JJLVJWPRIME13"] = 0.002
 ymax["JJLVJWPRIME13"] = 100
 ymin["ALLWPRIME13"] = 0.002
 ymax["ALLWPRIME13"] = 100
 ymin["ALLWVWPRIME8"] = 0.002
 ymax["ALLWVWPRIME8"] = 1.2
 ymin["ALLHVWPRIME8"] = 0.001
 ymax["ALLHVWPRIME8"] = 1.2
 ymin["ALLWPRIME8"] = 0.002
 ymax["ALLWPRIME8"] = 1.2
                 
 files = []
 canvas = []
 graph_1s = []
 graph_2s = []
 graphexp = []
 graphobs = []
 graphth = []
   
 files=[TFile.Open("plots/EXOVVhvt_"+l+"_UL_Asymptotic_log.root") for l in labels]
 #for f in files: print f.GetName()
 canvas=[f.Get("c_lim_Asymptotic") for f in files]
 
 for c in range(len(canvas)):
  for p in canvas[c].GetListOfPrimitives():
   if str(p).find("Limit68CLs") != -1: graph_1s.append(p.Clone("graph1s_%s"%labels[c])) 
   if str(p).find("Limit95CLs") != -1: graph_2s.append(p.Clone("graph2s_%s"%labels[c]))
   if str(p).find("LimitExpectedCLs") != -1: graphexp.append(p.Clone("graphexp_%s"%labels[c]))
   if str(p).find("LimitObservedCLs") != -1: graphobs.append(p.Clone("graphobs_%s"%labels[c]))
   if str(p).find("CrossSectionTheo") != -1: graphth.append(p.Clone("graphth_%s"%labels[c]))
 
 for g in range(len(graphexp)):
  graphexp[g].SetMarkerColor(mcol[labels[g]])
  graphexp[g].SetLineColor(lcol[labels[g]])
  graphexp[g].SetMarkerStyle(msty[labels[g]])
  graphexp[g].SetMarkerSize(0.7)
  graphobs[g].SetMarkerColor(mcol[labels[g]])
  graphobs[g].SetLineColor(lcol[labels[g]])
  graphobs[g].SetMarkerStyle(msty[labels[g]])
  graphobs[g].SetMarkerSize(0.9)  
  if g != 0:
   graphobs[g].SetLineWidth(1)
   graphexp[g].SetLineWidth(1)
   graphexp[g].SetLineStyle(1)
   
 leg = ROOT.TLegend(0.40,0.67,0.86,0.85)
 if not bands: leg = ROOT.TLegend(legs1[labels[0]][0],legs1[labels[0]][1],legs1[labels[0]][2],legs1[labels[0]][3])
 leg.SetBorderSize(0)
 leg.SetTextSize(0.032)#(0.031)
 leg.SetLineColor(1)
 leg.SetLineStyle(1)
 leg.SetShadowColor(0)
 leg.SetLineWidth(1)
 leg.SetFillColor(0)
 leg.SetTextFont(42)

 leg2 = ROOT.TLegend(legs3[labels[0]][0],legs3[labels[0]][1],legs3[labels[0]][2],legs3[labels[0]][3])
 leg2.SetBorderSize(0)
 leg2.SetTextSize(0.032)#0.031
 leg2.SetLineColor(1)
 leg2.SetLineStyle(1)
 leg2.SetShadowColor(0)
 leg2.SetLineWidth(1)
 leg2.SetFillColor(0)
 leg2.SetTextFont(42)
 leg2.SetNColumns(ncols[labels[0]])
 leg2.SetTextSize(0.031)
 
 pt = ROOT.TPaveText(0.40,0.85,0.75,0.91,"NDC")
 pt.SetTextFont(42)
 pt.SetTextSize(0.032)
 pt.SetTextAlign(12)
 pt.SetFillColor(0)
 pt.SetBorderSize(0)
 pt.SetFillStyle(0)
 text = pt.AddText(names[labels[0]])
 text.SetTextFont(62)

 lumi13 = ""
 lumi8 = ""
 if "13" in labels[0]:
  if labels[0].find("ALL") != -1: lumi13 = "2.3-2.7"
  elif labels[0].find("jj") != -1: lumi13 = "2.7"
  else: lumi13 = "2.3"
 elif "8" in labels[0]: lumi8 = "19.7"

 suffix = "observed"
 if unblind and not bands: suffix = "expected"
 if bands and not unblind: suffix = "bands"
 if bands and unblind: suffix = "final"
        
 canv = get_canvas("c_lim_Asymptotic_compare_%s"%suffix,lumi8,lumi13)
 canv.cd()
  
 npoints = graphobs[0].GetN()
 x = ROOT.Double(0.)
 y = ROOT.Double(0.)
 graphobs[0].GetPoint(npoints-1,x,y)

 hrl_SM = canv.DrawFrame(0.55,ymin[labels[0]], x+0.050, ymax[labels[0]])     
 
 if not unblind:  
  leg.AddEntry(graphobs[0],"Asympt. CL_{S} Obs.","L")
  if not bands: leg.AddEntry(graphexp[0],"Asympt. CL_{S} Exp.","L")
  for g in range(1,len(graphobs)): leg2.AddEntry(graphobs[g],names[labels[g]],"LP")   
  if bands:
   graph_2s[0].Draw("F")
   graph_1s[0].Draw("Fsame")
   leg.AddEntry(graph_1s[0],"Asympt. CL_{S} Exp. #pm 1#sigma","LF")
   leg.AddEntry(graph_2s[0],"Asympt. CL_{S} Exp. #pm 2#sigma","LF")
  graphexp[0].Draw("Lsame")
  graphobs[0].Draw("Lsame")
  for g in range(1,len(graphobs)): graphobs[g].Draw("LPsame")
 else:
  if bands:   
   graph_2s[0].Draw("F")
   graph_1s[0].Draw("Fsame")
   leg.AddEntry(graphobs[0],"Asympt. CL_{S} Obs.","L")
   leg.AddEntry(graph_1s[0],"Asympt. CL_{S} Exp. #pm 1#sigma","LF")
   leg.AddEntry(graph_2s[0],"Asympt. CL_{S} Exp. #pm 2#sigma","LF")
   graphobs[0].Draw("Lsame")
  else: leg.AddEntry(graphexp[0],"Asympt. CL_{S} Exp.","L") 
  graphexp[0].Draw("Lsame")  
  for c in range(1,len(graphexp)):
   leg2.AddEntry(graphexp[c],names[labels[c]],"LP")
   graphexp[c].Draw("LPsame")
   
 graphth[0].SetLineStyle(3)
 graphth[0].Draw("Lsame")
 theoleg = " HVT_{A} (g_{V}=1)"
 leg.AddEntry(graphth[0],theoleg,"L") 

 ytitle = "#sigma_{95%} #times BR_{W' #rightarrow WZ/WH} (pb)"
 hrl_SM.GetYaxis().SetTitle(ytitle)
 hrl_SM.GetYaxis().SetTitleSize(0.05)
 hrl_SM.GetXaxis().SetTitleSize(0.05)
 hrl_SM.GetXaxis().SetLabelSize(0.04)
 hrl_SM.GetYaxis().SetLabelSize(0.04)
 hrl_SM.GetYaxis().SetTitleOffset(1.2)
 hrl_SM.GetXaxis().SetTitleOffset(1)
 hrl_SM.GetXaxis().SetTitle("M_{W'} (TeV)")
 hrl_SM.GetXaxis().SetNdivisions(505)

 which = 'Expected'
 outf = open('plots/log_%s.txt'%labels[0],'a')
 
 i=0.8
 exclMass = 0
 while i < 3.:
  i+=0.01 
  if not unblind or (unblind and bands):
   y = graphobs[0].Eval(i)
   which = 'Observed'
  else: y = graphexp[0].Eval(i) 
  if y > graphth[0].Eval(i):
   outf.write(which+" excluded mass for HVTA is "+str(i)+" TeV with signal strenght "+str(y)+"\n")
   exclMass = i
   break

 outf.close()
 
 line = TLine(exclMass,ymin[labels[0]],exclMass,0.1)
 line.SetLineStyle(7)
 line.SetLineColor(kBlue) 
 #line.Draw()
             
 canv.Update()   
 canv.cd()
 
 period = 4
 if "8" in labels[0]: period = 2
 CMS_lumi.CMS_lumi(canv, period,0) 
  	
 canv.cd()
 canv.Update()
 canv.RedrawAxis()
 canv.RedrawAxis("g")
 leg.Draw("same")
 leg2.Draw("same")
 #pt.Draw("same")
 frame = canv.GetFrame()
 frame.Draw()	
 canv.cd()
 canv.Update() 
 
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_"+suffix+".root")
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_"+suffix+".C")
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_"+suffix+".pdf")
    
#************************************************************************************************
if __name__ == '__main__':

 gROOT.SetBatch(ROOT.kTRUE)
 scenarios={} 
 
 # 13 TeV LVJ+JJ only
 scenarios["JJLVJWPRIME13TeV"]=["JJLVJWPRIME13","lvjwzh13","jjwzwh13"]
 
 # 13 TeV LVJ+JJ+LVBB
 scenarios["ALLWPRIME13TeV"]=["ALLWPRIME13","lvjwzh13","lvjwh13","jjwzwh13"]
  
 # 8 TeV LLJ+LVJ+JJ (WV) only
 scenarios["ALLWVWPRIME8TeV"]=["ALLWVWPRIME8","lllv8","lljwz8","lvjwz8","jjwzwh8"]

 #8 TeV VH only
 scenarios["ALLHVWPRIME8TeV"]=["ALLHVWPRIME8","lvjwh8","jjwh8","ttjwh8"]
  
 #8 TeV VH+WV
 scenarios["ALLWPRIME8TeV"]=["ALLWPRIME8","lllv8","jjwzwh8","lljwz8","jjwh8","lvjwz8","ttjwh8","lvjwh8"]
     
 if len(sys.argv)>1:
    scenarios_arg={}
    scenarios_arg[sys.argv[1]]=scenarios[sys.argv[1]]
    scenarios=scenarios_arg
 else:
    print "Need input: <scenario>"
    sys.exit()

 mainName = scenarios[sys.argv[1]][0]
 for name in scenarios[sys.argv[1]]:
  print name
  plot_Asympt_limits(name,mainName)

 compare_Asympt_limits(scenarios[sys.argv[1]],False,False) #only observed
 compare_Asympt_limits(scenarios[sys.argv[1]],False,True) #observed + bands
 compare_Asympt_limits(scenarios[sys.argv[1]],True,False) #only expected 
 compare_Asympt_limits(scenarios[sys.argv[1]],True,True) #expected + observed combination + bands
