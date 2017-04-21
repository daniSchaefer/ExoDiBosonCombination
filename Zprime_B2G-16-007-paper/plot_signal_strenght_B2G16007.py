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
   CMS_lumi.writeExtraText = 0
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

def plot_Asympt_limits(label):
 
 infile = "results/higgsCombine%s.Asymptotic.TOTAL.root"%label
 mass = [800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,
         2100,2200,2300,2400,2500,2600,2700,2800,2900,3000,3100,3200,3300,3400,3500,
	 3600,3700,3800,3900,4000]	 
 
 names = {}
 names["ALLHVZPRIME138"]="llJ, vvJ, JJ, J#tau#tau (8+13 TeV)"
 names["ALLWVZPRIME138"]="lvJ, JJ (8+13 TeV)"
 names['ALLZPRIME138'] = "llJ, lvJ, vvJ, JJ, J#tau#tau (8+13 TeV)"
 names["lvjww8"]="lvqq (8 TeV)"
 names['lljzh8']="llqq (8 TeV)"
 names["jjwwzh8"]="qqqq (8 TeV)" 
 names["jjwwzh13"]="qqqq (13 TeV)"
 names["lvjww13"]="lvqq (13 TeV)"
 names["lljnnjzh13"]="llbb/vvbb (13 TeV)"
 names['ttjzh8'] = "qq#tau#tau (8 TeV)"
 names['jjzh8'] = "qqbb(4q) (8 TeV)" 
  
 nPoints = 0

 xbins	   = array('d', [])
 xbins_env = array('d', [])
 ybins_exp = array('d', [])
 ybins_obs = array('d', [])
 ybins_1s  = array('d', [])
 ybins_2s  = array('d', [])
 ybins_xs  = array('d', [])

 lastMass = 0.8
 for m in mass:

  curAsymLimits = getAsymLimits(infile,m);
  if curAsymLimits[0] == -1:
   #print "************** MISSING MASS POINT = ",m
   continue
  #print m,curAsymLimits[3],curAsymLimits[0]
  lastMass = m/1000.
  xbins.append( m/1000. );
  xbins_env.append( m/1000. );
  ybins_exp.append( curAsymLimits[3] );
  ybins_obs.append( curAsymLimits[0] );
  ybins_2s.append( curAsymLimits[1] );
  ybins_1s.append( curAsymLimits[2] );
  ybins_xs.append( 1 );
  nPoints+=1

 for i in range( len(mass)-1, -1, -1 ):

  curAsymLimits = getAsymLimits(infile,mass[i]);
  if curAsymLimits[0] == -1: continue
  xbins_env.append( mass[i]/1000. );
  ybins_2s.append( curAsymLimits[5] );
  ybins_1s.append( curAsymLimits[4] );

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

 hrl_SM = canv.DrawFrame(0.75,0.01, lastMass+0.050, 100) 
 
 ytitle = "#sigma_{95%} #times BR_{Z' #rightarrow WW/ZH} (pb)"
 hrl_SM.GetYaxis().SetTitle(ytitle)
 hrl_SM.GetYaxis().SetTitleSize(0.045)
 hrl_SM.GetXaxis().SetTitleSize(0.045)
 hrl_SM.GetXaxis().SetLabelSize(0.035)
 hrl_SM.GetYaxis().SetLabelSize(0.035)
 hrl_SM.GetYaxis().SetTitleOffset(1.1)
 hrl_SM.GetXaxis().SetTitleOffset(1.1)
 hrl_SM.GetXaxis().SetTitle("M_{Z'} (TeV)")
     
 curGraph_2s.Draw("F")
 curGraph_1s.Draw("Fsame")
 curGraph_exp.Draw("Lsame")
 curGraph_obs.Draw("LPsame")
 curGraph_xs.Draw("Csame")

 leg2 = ROOT.TLegend(0.3691275,0.1993355,0.8842282,0.4003322)
 leg2.SetBorderSize(0);
 leg2.SetTextSize(0.031);
 leg2.SetLineColor(1);
 leg2.SetLineStyle(1);
 leg2.SetShadowColor(0);
 leg2.SetLineWidth(1);
 leg2.SetFillColor(0);
 leg2.SetTextFont(42)

 leg2.AddEntry(curGraph_obs,"Asympt. CL_{S} Observed","LP")
 leg2.AddEntry(curGraph_1s,"Asympt. CL_{S} Expected #pm 1#sigma","LF")
 leg2.AddEntry(curGraph_2s,"Asympt. CL_{S} Expected #pm 2#sigma","LF")
 theoleg = " HVT_{B} (g_{V}=3)"
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
 if "138" in label: period = 7
 if "8" in label and not "13" in label: period = 2
 
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
  
 canv.SaveAs("plots/EXOVVhvt_"+label+"_UL_Asymptotic_mu_log.root")
 canv.SaveAs("plots/EXOVVhvt_"+label+"_UL_Asymptotic_mu_log.C")
 canv.SaveAs("plots/EXOVVhvt_"+label+"_UL_Asymptotic_mu_log.pdf")

def compare_Asympt_limits(labels,unblind,bands):

 palette = get_palette('gv')
 col = TColor()
 
 #line color
 lcol = {}
 lcol["ALLWVZPRIME138"] = kBlack
 lcol["ALLHVZPRIME138"] = kBlack
 lcol['ALLZPRIME138'] = kBlack  
 lcol["lvjww13"] = col.GetColor(palette[11])
 lcol["jjwwzh13"] = col.GetColor(palette[9])
 lcol["lljnnjzh13"] = col.GetColor(palette[10])
 lcol['lljzh8'] = col.GetColor(palette[1])
 lcol["lvjww8"] = col.GetColor(palette[2])
 lcol["jjwwzh8"] = col.GetColor(palette[6])
 lcol['jjzh8'] = col.GetColor(palette[5])
 lcol['ttjzh8'] = col.GetColor(palette[4])
 
 #marker color
 mcol = {}
 mcol["ALLWVZPRIME138"] = kBlack
 mcol["ALLHVZPRIME138"] = kBlack
 mcol['ALLZPRIME138'] = kBlack  
 mcol["lvjww13"] = col.GetColor(palette[11])
 mcol["jjwwzh13"] = col.GetColor(palette[9])
 mcol["lljnnjzh13"] = col.GetColor(palette[10])
 mcol['lljzh8'] = col.GetColor(palette[1])
 mcol["lvjww8"] = col.GetColor(palette[2])
 mcol["jjwwzh8"] = col.GetColor(palette[6])
 mcol['ttjzh8'] =  col.GetColor(palette[4])
 mcol['jjzh8'] = col.GetColor(palette[5])
 
 #marker style
 msty = {}
 msty['ALLZPRIME138'] = 20
 msty["ALLWVZPRIME138"] = 20
 msty["ALLHVZPRIME138"] = 20
 msty["lvjww13"] = 26
 msty["jjwwzh13"] = 22  
 msty["lljnnjzh13"] = 31
 msty['lljzh8'] = 25
 msty["lvjww8"] = 26
 msty["jjwwzh8"] = 22 
 msty['ttjzh8'] = 25
 msty['jjzh8'] = 31
     
 names = {}
 names["ALLHVZPRIME138"]="llJ, vvJ, JJ, J#tau#tau (8+13 TeV)"
 names["ALLWVZPRIME138"]="lvJ, JJ (8+13 TeV)"
 names['ALLZPRIME138'] = "llJ, lvJ, vvJ, JJ, J#tau#tau (8+13 TeV)"
 names["lvjww8"]="lvqq (8 TeV)"
 names['lljzh8']="llqq (8 TeV)"
 names["jjwwzh8"]="qqqq (8 TeV)" 
 names["jjwwzh13"]="qqqq (13 TeV)"
 names["lvjww13"]="lvqq (13 TeV)"
 names["lljnnjzh13"]="llbb/vvbb (13 TeV)"
 names['ttjzh8'] = "qq#tau#tau (8 TeV)"
 names['jjzh8'] = "qqbb(4q) (8 TeV)" 
 
 legs1={}
 legs1["ALLZPRIME138"]=[0.16,0.75,0.49,0.88]
 legs1["ALLWVZPRIME138"]=[0.16,0.75,0.49,0.88]
 legs1["ALLHVZPRIME138"]=[0.16,0.75,0.49,0.88]
    
 legs2={}
 legs2["ALLWVZPRIME138"]=[0.37,0.18,0.88,0.29]
 legs2["ALLZPRIME138"]=[0.37,0.16,0.88,0.33]
 legs2["ALLHVZPRIME138"]=[0.37,0.18,0.88,0.29]

 legs3={}
 legs3["ALLWVZPRIME138"]=[0.17,0.71,0.43,0.88]
 legs3["ALLZPRIME138"]=[0.15,0.66,0.41,0.90] 
 legs3["ALLHVZPRIME138"]=[0.17,0.71,0.43,0.88]
    
 ymin = {}
 ymax = {}  
 ymin["ALLWVZPRIME138"] = 0.06
 ymax["ALLWVZPRIME138"] = 1000
 ymin["ALLZPRIME138"] = 0.02
 ymax["ALLZPRIME138"] = 3000
 ymin["ALLHVZPRIME138"] = 0.06
 ymax["ALLHVZPRIME138"] = 200
              
 files = []
 canvas = []
 graph_1s = []
 graph_2s = []
 graphexp = []
 graphobs = []
 graphth = []
   
 files=[TFile.Open("plots/EXOVVhvt_"+l+"_UL_Asymptotic_mu_log.root") for l in labels]
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
   
 leg = ROOT.TLegend(0.46,0.16,0.90,0.33)
 if not bands: leg = ROOT.TLegend(legs1[labels[0]][0],legs1[labels[0]][1],legs1[labels[0]][2],legs1[labels[0]][3])
 leg.SetBorderSize(0)
 leg.SetTextSize(0.031)
 leg.SetLineColor(1)
 leg.SetLineStyle(1)
 leg.SetShadowColor(0)
 leg.SetLineWidth(1)
 leg.SetFillColor(0)
 leg.SetTextFont(42)

 leg2 = ROOT.TLegend(legs2[labels[0]][0],legs2[labels[0]][1],legs2[labels[0]][2],legs2[labels[0]][3])
 if bands: leg2 = ROOT.TLegend(legs3[labels[0]][0],legs3[labels[0]][1],legs3[labels[0]][2],legs3[labels[0]][3])
 leg2.SetBorderSize(0)
 leg2.SetTextSize(0.032)
 leg2.SetLineColor(1)
 leg2.SetLineStyle(1)
 leg2.SetShadowColor(0)
 leg2.SetLineWidth(1)
 leg2.SetFillColor(0)
 leg2.SetTextFont(42)
 if not bands: leg2.SetNColumns(2)
 
 pt = ROOT.TPaveText(0.56,0.85,0.91,0.90,"NDC")
 pt.SetTextFont(42)
 pt.SetTextSize(0.032)
 pt.SetTextAlign(32)
 pt.SetFillColor(0)
 pt.SetBorderSize(0)
 pt.SetFillStyle(0)
 text = pt.AddText(names[labels[0]])
 text.SetTextFont(62)

 lumi13 = "2.3-2.7"
 lumi8 = "19.7"
          
 canv = get_canvas("c_lim_Asymptotic_compare",lumi8,lumi13)
 canv.cd()
  
 npoints = graphobs[0].GetN()
 x = ROOT.Double(0.)
 y = ROOT.Double(0.)
 graphobs[0].GetPoint(npoints-1,x,y)
  
 hrl_SM = canv.DrawFrame(0.75,ymin[labels[0]], x+0.050, ymax[labels[0]]) 
 
 if not unblind:  
  leg.AddEntry(graphobs[0],"Asympt. CL_{S} Obs.","L")
  leg.AddEntry(graphexp[0],"Asympt. CL_{S} Exp.","L")
  for g in range(1,len(graphobs)): leg2.AddEntry(graphobs[g],names[labels[g]],"LP")   
  if bands:
   graph_2s[0].Draw("F")
   graph_1s[0].Draw("Fsame")
   leg.AddEntry(graph_1s[0],"Asympt. CL_{S} Exp. #pm 1 s.d.","LF")
   leg.AddEntry(graph_2s[0],"Asympt. CL_{S} Exp. #pm 2 s.d.","LF")
  graphexp[0].Draw("Lsame")
  graphobs[0].Draw("Lsame")
  for g in range(1,len(graphobs)): graphobs[g].Draw("LPsame")
 else:
  if bands:   
   graph_2s[0].Draw("F")
   graph_1s[0].Draw("Fsame")
   leg.AddEntry(graphobs[0],"Asympt. CL_{S} Obs.","L")
   leg.AddEntry(graph_1s[0],"Asympt. CL_{S} Exp. #pm 1 s.d.","LF")
   leg.AddEntry(graph_2s[0],"Asympt. CL_{S} Exp. #pm 2 s.d.","LF")
   graphobs[0].Draw("Lsame")
  else: leg.AddEntry(graphexp[0],"Asympt. CL_{S} Exp.","L") 
  graphexp[0].Draw("Lsame")  
  for c in range(1,len(graphexp)):
   leg2.AddEntry(graphexp[c],names[labels[c]],"LP")
   graphexp[c].Draw("LPsame")
   
 graphth[0].SetLineStyle(3)
 graphth[0].Draw("Lsame")
 theoleg = " HVT_{B} (g_{V}=3)"
 leg.AddEntry(graphth[0],theoleg,"L") 

 ytitle = "#sigma_{95%}/#sigma_{theory}"
 hrl_SM.GetYaxis().SetTitle(ytitle)
 hrl_SM.GetYaxis().SetTitleSize(0.05)
 hrl_SM.GetXaxis().SetTitleSize(0.05)
 hrl_SM.GetXaxis().SetLabelSize(0.04)
 hrl_SM.GetYaxis().SetLabelSize(0.04)
 hrl_SM.GetYaxis().SetTitleOffset(1.2)
 hrl_SM.GetXaxis().SetTitleOffset(1)
 hrl_SM.GetXaxis().SetTitle("M_{Z'} (TeV)")
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
   outf.write(which+" excluded mass for HVTB is "+str(i)+" TeV with signal strenght "+str(y)+"\n")
   exclMass = i
   break

 outf.close()

 line = TLine(exclMass,ymin[labels[0]],exclMass,ymax[labels[0]])
 line.SetLineStyle(7)
 line.SetLineColor(kBlue) 
 #line.Draw()
             
 canv.Update()   
 canv.cd()
 
 period = 7
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

 suffix = "observed"
 if unblind and not bands: suffix = "expected"
 if bands and not unblind: suffix = "bands"
 if bands and unblind: suffix = "final"
 
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_"+suffix+".root")
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_"+suffix+".C")
 canv.SaveAs("plots/EXOVVhvt_compare_"+labels[0]+"_"+suffix+".pdf")
    
#************************************************************************************************
if __name__ == '__main__':

 gROOT.SetBatch(ROOT.kTRUE)
 
 scenarios={} 
 
 # 8 + 13 TeV LLJ+LVJ+JJ (WV)
 scenarios["ALLWVZPRIME138TeV"]=["ALLWVZPRIME138","lljzh8","lvjww8","jjwwzh8","lvjww13","jjwwzh13"]

 #8+13 TeV VH only
 scenarios["ALLHVZPRIME138TeV"]=["ALLHVZPRIME138","jjzh8","ttjzh8","lljnnjzh13"]
 
 #8+13 TeV VH+WV
 scenarios["ALLZPRIME138TeV"]=["ALLZPRIME138","lljzh8","lvjww8","jjwwzh8","jjzh8","ttjzh8","lvjww13","lljnnjzh13","jjwwzh13"]
     
 if len(sys.argv)>1:
    scenarios_arg={}
    scenarios_arg[sys.argv[1]]=scenarios[sys.argv[1]]
    scenarios=scenarios_arg
 else:
    print "Need input: <scenario>"
    sys.exit()

 for name in scenarios[sys.argv[1]]:
  print name
  plot_Asympt_limits(name)

 compare_Asympt_limits(scenarios[sys.argv[1]],False,False) #only observed
 compare_Asympt_limits(scenarios[sys.argv[1]],False,True) #observed + bands
 compare_Asympt_limits(scenarios[sys.argv[1]],True,False) #only expected 
 compare_Asympt_limits(scenarios[sys.argv[1]],True,True) #expected + observed combination + bands
 
