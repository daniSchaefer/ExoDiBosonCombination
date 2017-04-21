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

def get_theo_map(sqrts):

   V_mass = array('d',[])

   brs = {}
   index = {}

   mapping = ["M0","M+","BRWW","BRhZ","BRZW","BRWh","CX+(pb)","CX0(pb)","CX-(pb)"]

   for m in xrange(0,len(mapping)):
      if mapping[m] != "M0" and mapping[m] != "M+":
   	 brs[mapping[m]] = array('d',[])
   	 #print mapping[m]

   f = open('xsect_HVT_%sTeV.txt'%sqrts,'r')
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

   f = open('xsect_HVT_%sTeV.txt'%sqrts,'r')
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

def getPValueFromCard(file,mass):

    f = ROOT.TFile(file)
    t = f.Get("limit")
    entries = t.GetEntries()
    
    lims = -1
    
    for i in range(entries):
        
     t.GetEntry(i)
     if t.mh != mass: continue
     lims = t.limit
    
    return lims
    
def plot_significance(label):

 names = {}
 names["JJLVJWPRIME13"]="lvJ, JJ (13 TeV)"
 names["ALLWPRIME13"]="lvJ, JJ (13 TeV)"
 names["ALLWVWPRIME8"]="lllv, llJ, lvJ, JJ (8 TeV)"
 names['ALLHVWPRIME8'] = "lvJ, JJ, J#tau#tau (8 TeV)"
 names["ALLHVWPRIME138"]="lvJ, JJ, J#tau#tau (8+13 TeV)"
 names['ALLWPRIME8'] = "lllv, llJ, lvJ, JJ, J#tau#tau (8 TeV)"
 names["ALLWVWPRIME138"]="lllv, lvJ, llJ, JJ (8+13 TeV)"
 names['ALLWPRIME138'] = "lllv, llJ, lvJ, JJ, J#tau#tau (8+13 TeV)"
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
   
 infileObs = "results/higgsCombine%sObsSignif.ProfileLikelihood.TOTAL.root"%label
 infileExp = "results/higgsCombine%sExpSignif.ProfileLikelihood.TOTAL.root"%label
 mass = [600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,
       2100,2200,2300,2400,2500,2600,2700,2800,2900,3000,3100,3200,3300,3400,3500,
       3600,3700,3800,3900,4000]
 
 xbins = array('d', [])
 ybins_obs = array('d', [])
 ybins_exp = array('d', [])
 nPoints = 0

 firstMass = 0.6
 for m in mass:

  pvalue_obs = getPValueFromCard(infileObs,m)
  if pvalue_obs == -1: continue
  firstMass = m/1000.
  break
   
 lastMass = 0.8
 for m in mass:
 
  pvalue_obs = getPValueFromCard(infileObs,m)
  pvalue_exp = getPValueFromCard(infileExp,m)  
  if pvalue_obs == -1: continue
  lastMass = m/1000.
  #print m,RooStats.PValueToSignificance(pvalue_obs)#,pvalue_obs
  ybins_obs.append(pvalue_obs)        
  ybins_exp.append(pvalue_exp)      
  xbins.append(m/1000.)       
  nPoints+=1  

 lumi13 = ""
 lumi8 = ""
 if label.find("13") != -1 and label.find("8") == -1:
  if label.find("ALL") != -1: lumi13 = "2.3-2.7"
  elif label.find("jj") != -1: lumi13 = "2.7"
  else: lumi13 = "2.3"
 if "8" in label and not "13" in label:
  lumi8 = "19.7"
 if "138" in label:
  lumi13 = "2.3-2.7"
  lumi8 = "19.7"
  
 canv = get_canvas("c_Significance",lumi8,lumi13)
 canv.cd()

 hrl_SM = canv.DrawFrame(firstMass-0.050,0.00001, lastMass+0.050, 10) 
 ytitle = "p-value"
 hrl_SM.GetYaxis().SetTitle(ytitle)
 hrl_SM.GetYaxis().SetTitleSize(0.045)
 hrl_SM.GetXaxis().SetTitleSize(0.045)
 hrl_SM.GetXaxis().SetLabelSize(0.035)
 hrl_SM.GetYaxis().SetLabelSize(0.035)
 hrl_SM.GetYaxis().SetTitleOffset(1.1)
 hrl_SM.GetXaxis().SetTitleOffset(1.1)
 hrl_SM.GetXaxis().SetTitle("M_{W'} (TeV)")
      
 gr_pvalue_exp = ROOT.TGraph(nPoints,xbins,ybins_exp)	
 gr_pvalue_exp.SetName("Expected")
 gr_pvalue_exp.SetLineStyle(2)
 gr_pvalue_exp.SetLineWidth(2)
 gr_pvalue_obs = ROOT.TGraph(nPoints,xbins,ybins_obs)
 gr_pvalue_obs.SetName("Observed")
 gr_pvalue_obs.SetLineColor(1)
 gr_pvalue_obs.SetMarkerColor(1)
 gr_pvalue_obs.SetMarkerStyle(20)
 gr_pvalue_obs.SetLineWidth(2)
 gr_pvalue_obs.SetMarkerSize(1.)

 oneSLine = ROOT.TF1("oneSLine","1.58655253931457074e-01",0.75,4.050);
 oneSLine.SetLineColor(ROOT.kRed); oneSLine.SetLineWidth(2); oneSLine.SetLineStyle(3);
 twoSLine = ROOT.TF1("twoSLine","2.27501319481792155e-02",0.75,4.050);
 twoSLine.SetLineColor(ROOT.kRed); twoSLine.SetLineWidth(2); twoSLine.SetLineStyle(3);
 threeSLine = ROOT.TF1("threeSLine","1.34989803163009588e-03",0.75,4.050);
 threeSLine.SetLineColor(ROOT.kRed); threeSLine.SetLineWidth(2); threeSLine.SetLineStyle(3);
 fourSLine = ROOT.TF1("fourSLine","3.16712418331199785e-05",0.75,4.050);
 fourSLine.SetLineColor(ROOT.kRed); fourSLine.SetLineWidth(2); fourSLine.SetLineStyle(3);

 ban1s = TLatex(3.8,1.58655253931457074e-01,("1 #sigma"));
 ban1s.SetTextSize(0.028); ban1s.SetTextColor(2)
 ban2s = TLatex(3.8,2.27501319481792155e-02,("2 #sigma"));
 ban2s.SetTextSize(0.028); ban2s.SetTextColor(2)
 ban3s = TLatex(3.8,1.34989803163009588e-03,("3 #sigma"));
 ban3s.SetTextSize(0.028); ban3s.SetTextColor(2);
 ban4s = TLatex(3.8,3.16712418331199785e-05,("4 #sigma"));
 ban4s.SetTextSize(0.028); ban4s.SetTextColor(2)

 leg2 = ROOT.TLegend(0.4966443,0.2325581,0.8926174,0.3239203)
 leg2.SetBorderSize(0);
 leg2.SetTextSize(0.031);
 leg2.SetLineColor(1);
 leg2.SetLineStyle(1);
 leg2.SetShadowColor(0);
 leg2.SetLineWidth(1);
 leg2.SetFillColor(0);
 leg2.SetTextFont(42)
 leg2.AddEntry( gr_pvalue_obs, "Observed significance", "pl" );
 leg2.AddEntry( gr_pvalue_exp, "Expected significance", "l" );

 pt = ROOT.TPaveText(0.5486577,0.8355482,0.8993289,0.8920266,"NDC")
 pt.SetTextFont(42)
 pt.SetTextSize(0.031)
 pt.SetTextAlign(32)
 pt.SetFillColor(0)
 pt.SetBorderSize(0)
 pt.SetFillStyle(0)
 text = pt.AddText(names[label])
 text.SetTextFont(62)
  
 gr_pvalue_exp.Draw("L")
 gr_pvalue_obs.Draw("LP") 
 oneSLine.Draw("same");
 twoSLine.Draw("same");
 threeSLine.Draw("same");
 fourSLine.Draw("same");
 ban1s.Draw();
 ban2s.Draw();
 ban3s.Draw();
 ban4s.Draw();
 leg2.Draw()
 pt.Draw()

 canv.Update()   
 canv.cd()
 
 period = 4
 if "138" in label: period = 7
 if "8" in label and not "13" in label: period = 2

 CMS_lumi.CMS_lumi(canv, period,11)	      
 canv.cd()
 canv.Update()
 canv.RedrawAxis()
 canv.RedrawAxis("g")
 frame = canv.GetFrame()
 frame.Draw() 
 canv.cd()
 canv.Update()
 
 canv.SaveAs("plots/EXOVVhvt_"+label+"_Significance.root")
 canv.SaveAs("plots/EXOVVhvt_"+label+"_Significance.C")
 canv.SaveAs("plots/EXOVVhvt_"+label+"_Significance.pdf")
     
def compare_significance(labels):

 palette = get_palette('gv')
 col = TColor()
 
 #line color
 lcol = {}
 lcol["JJLVJWPRIME13"] = kBlack
 lcol["ALLWPRIME13"] = kBlack
 lcol["ALLWVWPRIME8"] = kBlack
 lcol['ALLHVWPRIME8'] = kBlack
 lcol['ALLHVWPRIME138'] = kBlack
 lcol['ALLWPRIME8'] = kBlack
 lcol["ALLWVWPRIME138"] = kBlack
 lcol['ALLWPRIME138'] = kBlack
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
 mcol['ALLHVWPRIME138'] = kBlack
 mcol['ALLWPRIME8'] = kBlack
 mcol["ALLWVWPRIME138"] = kBlack
 mcol['ALLWPRIME138'] = kBlack
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
 msty['ALLHVWPRIME138'] = 20
 msty['ALLWPRIME8'] = 20
 msty['ALLWPRIME138'] = 20
 msty["ALLWVWPRIME138"] = 20
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
 names["ALLHVWPRIME138"]="lvJ, JJ, J#tau#tau (8+13 TeV)"
 names['ALLWPRIME8'] = "lllv, llJ, lvJ, JJ, J#tau#tau (8 TeV)"
 names["ALLWVWPRIME138"]="lllv, lvJ, llJ, JJ (8+13 TeV)"
 names['ALLWPRIME138'] = "lllv, llJ, lvJ, JJ, J#tau#tau (8+13 TeV)"
 if "138" in labels[0]:
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
 else: 
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
 legs1["JJLVJWPRIME13"]=[0.47,0.37,0.88,0.45]
 legs1["ALLWPRIME13"]=[0.47,0.37,0.88,0.45]
 legs1["ALLWVWPRIME8"]=[0.51,0.37,0.93,0.45]
 legs1["ALLWVWPRIME138"]=[0.47,0.37,0.88,0.45]
 legs1["ALLHVWPRIME8"]=[0.47,0.37,0.88,0.45]
 legs1["ALLHVWPRIME138"]=[0.47,0.37,0.88,0.45]
 legs1["ALLWPRIME8"]=[0.47,0.37,0.88,0.45]
 legs1["ALLWPRIME138"]=[0.43,0.38,0.84,0.46]
    
 legs2={}
 legs2["JJLVJWPRIME13"]=[0.48,0.26,0.72,0.34]
 legs2["ALLWPRIME13"]=[0.48,0.26,0.72,0.34]
 legs2["ALLWVWPRIME8"]=[0.52,0.21,0.76,0.35]
 legs2["ALLWVWPRIME138"]=[0.34,0.22,0.81,0.32]
 legs2["ALLHVWPRIME8"]=[0.48,0.25,0.72,0.35]
 legs2["ALLHVWPRIME138"]=[0.48,0.22,0.72,0.35]
 legs2["ALLWPRIME8"]=[0.48,0.23,0.90,0.35]
 legs2["ALLWPRIME138"]=[0.34,0.21,0.86,0.36]
  
 ncols={}
 ncols["JJLVJWPRIME13"] = 1
 ncols["ALLWPRIME13"] = 1
 ncols["ALLWVWPRIME8"] = 1
 ncols["ALLWVWPRIME138"] = 2
 ncols["ALLHVWPRIME8"] = 1
 ncols["ALLHVWPRIME138"] = 1
 ncols["ALLWPRIME8"] = 2
 ncols["ALLWPRIME138"] = 2
      
 files = []
 canvas = []
 graphexp = []
 graphobs = []
   
 files=[TFile.Open("plots/EXOVVhvt_"+l+"_Significance.root") for l in labels]
 canvas=[f.Get("c_Significance") for f in files]
 
 for c in range(len(canvas)):
  for p in canvas[c].GetListOfPrimitives():
   if str(p).find("Observed") != -1: graphobs.append(p.Clone("graphObs_%s"%labels[c])) 
   if str(p).find("Expected") != -1: graphexp.append(p.Clone("graphExp_%s"%labels[c]))

 for g in range(len(graphexp)):
  graphexp[g].SetMarkerColor(mcol[labels[g]])
  graphexp[g].SetLineColor(lcol[labels[g]])
  graphexp[g].SetMarkerStyle(msty[labels[g]])
  graphobs[g].SetMarkerColor(mcol[labels[g]])
  graphobs[g].SetLineColor(lcol[labels[g]])
  graphobs[g].SetLineWidth(1)
  graphexp[g].SetLineWidth(1)
  graphobs[g].SetMarkerStyle(msty[labels[g]])
  graphobs[g].SetMarkerSize(0.9)
  if g == 0:
   graphobs[g].SetLineWidth(2)
   graphexp[g].SetLineWidth(2)
   
 leg = ROOT.TLegend(legs1[labels[0]][0],legs1[labels[0]][1],legs1[labels[0]][2],legs1[labels[0]][3])
 leg.SetBorderSize(0)
 leg.SetTextSize(0.031)
 leg.SetLineColor(1)
 leg.SetLineStyle(1)
 leg.SetShadowColor(0)
 leg.SetLineWidth(1)
 leg.SetFillColor(0)
 leg.SetTextFont(42)

 leg2 = ROOT.TLegend(legs2[labels[0]][0],legs2[labels[0]][1],legs2[labels[0]][2],legs2[labels[0]][3])
 leg2.SetBorderSize(0)
 leg2.SetTextSize(0.026)
 leg2.SetLineColor(1)
 leg2.SetLineStyle(1)
 leg2.SetShadowColor(0)
 leg2.SetLineWidth(1)
 leg2.SetFillColor(0)
 leg2.SetTextFont(42)
 leg2.SetNColumns(ncols[labels[0]])
 leg2.SetTextSize(0.031)
 
 pt = ROOT.TPaveText(0.5486577,0.8438538,0.8993289,0.9003322,"NDC")
 pt.SetTextFont(42)
 pt.SetTextSize(0.031)
 pt.SetTextAlign(32)
 pt.SetFillColor(0)
 pt.SetBorderSize(0)
 pt.SetFillStyle(0)
 text = pt.AddText(names[labels[0]])
 text.SetTextFont(62)

 lumi13 = ""
 lumi8 = ""
 if labels[0].find("13") != -1 and labels[0].find("8") == -1:
  if labels[0].find("ALL") != -1: lumi13 = "2.3-2.7"
  elif labels[0].find("jj") != -1: lumi13 = "2.7"
  else: lumi13 = "2.3"
 if "8" in labels[0] and not "13" in labels[0]:
  lumi8 = "19.7"
 if "138" in labels[0]:
  lumi13 = "2.3-2.7"
  lumi8 = "19.7"
       
 canv = get_canvas("c_Significance_compare",lumi8,lumi13)
 canv.cd()

 npoints = graphobs[0].GetN()
 x = ROOT.Double(0.)
 y = ROOT.Double(0.)
 graphobs[0].GetPoint(npoints-1,x,y)
  
 hrl_SM = canv.DrawFrame(0.75,0.00001, x+0.050, 1) 
 ytitle = "p-value"
 hrl_SM.GetYaxis().SetTitle(ytitle)
 hrl_SM.GetYaxis().SetTitleSize(0.045)
 hrl_SM.GetXaxis().SetTitleSize(0.045)
 hrl_SM.GetXaxis().SetLabelSize(0.035)
 hrl_SM.GetYaxis().SetLabelSize(0.035)
 hrl_SM.GetYaxis().SetTitleOffset(1.1)
 hrl_SM.GetXaxis().SetTitleOffset(1.1)
 hrl_SM.GetXaxis().SetTitle("M_{W'} (TeV)")

 leg.AddEntry(graphobs[0],"Observed significance","LP")
 leg.AddEntry(graphobs[0],"Expected significance","L")
 for g in range(1,len(graphobs)): leg2.AddEntry(graphobs[g],names[labels[g]],"LP")   
 for g in range(0,len(graphobs)):
  graphobs[g].Draw("LPsame")
  graphexp[g].Draw("Lsame")

 oneSLine = ROOT.TF1("oneSLine","1.58655253931457074e-01",0.75,4.050);
 oneSLine.SetLineColor(ROOT.kRed); oneSLine.SetLineWidth(2); oneSLine.SetLineStyle(3);
 twoSLine = ROOT.TF1("twoSLine","2.27501319481792155e-02",0.75,4.050);
 twoSLine.SetLineColor(ROOT.kRed); twoSLine.SetLineWidth(2); twoSLine.SetLineStyle(3);
 threeSLine = ROOT.TF1("threeSLine","1.34989803163009588e-03",0.75,4.050);
 threeSLine.SetLineColor(ROOT.kRed); threeSLine.SetLineWidth(2); threeSLine.SetLineStyle(3);
 fourSLine = ROOT.TF1("fourSLine","3.16712418331199785e-05",0.75,4.050);
 fourSLine.SetLineColor(ROOT.kRed); fourSLine.SetLineWidth(2); fourSLine.SetLineStyle(3);

 ban1s = TLatex(3.8,1.58655253931457074e-01,("1 #sigma"));
 ban1s.SetTextSize(0.028); ban1s.SetTextColor(2)
 ban2s = TLatex(3.8,2.27501319481792155e-02,("2 #sigma"));
 ban2s.SetTextSize(0.028); ban2s.SetTextColor(2)
 ban3s = TLatex(3.8,1.34989803163009588e-03,("3 #sigma"));
 ban3s.SetTextSize(0.028); ban3s.SetTextColor(2);
 ban4s = TLatex(3.8,3.16712418331199785e-05,("4 #sigma"));
 ban4s.SetTextSize(0.028); ban4s.SetTextColor(2)
   
 leg.Draw()
 leg2.Draw()
 #pt.Draw()
 oneSLine.Draw("same");
 twoSLine.Draw("same");
 threeSLine.Draw("same");
 fourSLine.Draw("same");
 ban1s.Draw();
 ban2s.Draw();
 ban3s.Draw();
 ban4s.Draw();
    
 canv.Update()   
 canv.cd()
 
 period = 4
 if "138" in labels[0]: period = 7
 if "8" in labels[0] and not "13" in labels[0]: period = 2

 CMS_lumi.CMS_lumi(canv, period,0)   	
 canv.cd()
 canv.Update()
 canv.RedrawAxis()
 canv.RedrawAxis("g")
 frame = canv.GetFrame()
 frame.Draw()	
 canv.cd()
 canv.Update()
        
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_Significance.root")
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_Significance.C")
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_Significance.pdf")
                    
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

 #8+13 TeV VH only
 scenarios["ALLHVWPRIME138TeV"]=["ALLHVWPRIME138","lvjwh8","jjwh8","ttjwh8","lvjwh13"]
  
 #8 TeV VH+WV
 scenarios["ALLWPRIME8TeV"]=["ALLWPRIME8","lllv8","jjwzwh8","lljwz8","jjwh8","lvjwz8","ttjwh8","lvjwh8"]

 # 8 + 13 TeV LLJ+LVJ+JJ (WV)
 scenarios["ALLWVWPRIME138TeV"]=["ALLWVWPRIME138","lllv8","jjwzwh8","lljwz8","lvjwzh13","lvjwz8","jjwzwh13"]

 #8+13 TeV VH+WV
 scenarios["ALLWPRIME138TeV"]=["ALLWPRIME138","lllv8","jjwh8","lljwz8","ttjwh8","lvjwz8","lvjwzh13","lvjwh8","lvjwh13","jjwzwh8","jjwzwh13"]
      
 if len(sys.argv)>1:
    scenarios_arg={}
    scenarios_arg[sys.argv[1]]=scenarios[sys.argv[1]]
    scenarios=scenarios_arg
 else:
    print "Need input: <scenario>"
    sys.exit()

 for name in scenarios[sys.argv[1]]:
  print name
  plot_significance(name)

 compare_significance(scenarios[sys.argv[1]])

