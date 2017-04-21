import ROOT
from ROOT import *
import CMS_lumi, tdrstyle
import time
from array import array

def get_ratio(num,den):

   rx = array('d',[])
   ry = array('d',[])
   for p in range(0,num.GetN()):
    xnum = ROOT.Double(0.)
    xden = ROOT.Double(0.)
    n = ROOT.Double(0.)
    d = ROOT.Double(0.)
    num.GetPoint(p,xnum,n)
    print p,xnum,n
    if xnum>=0.8:
     den.GetPoint(p-2,xden,d) #p-2 for lvqq and 8+13 combined
     #print p-2,xden,d
     rx.append(xden)
     ry.append(n/d)
   
   ratio = ROOT.TGraph(len(rx),rx,ry) 
   ratio.SetLineColor(1)      
   ratio.SetLineColor(1)
   ratio.SetMarkerColor(1)
   ratio.SetMarkerStyle(20)
   ratio.SetMarkerSize(1.)
         
   return ratio

def get_canvas(cname,lumi=1):

   CMS_lumi.lumi_13TeV = "%.1f fb^{-1},#sqrt{s} = " %(lumi/1000.)
   CMS_lumi.writeExtraText = 1
   CMS_lumi.extraText = "Preliminary"

   iPos = 11
   if( iPos==0 ): CMS_lumi.relPosX = 0.15

   H_ref = 600; 
   W_ref = 800; 
   W = W_ref
   H  = H_ref

   T = 0.08*H_ref
   B = 0.12*H_ref 
   L = 0.12*W_ref
   R = 0.06*W_ref

   canvas = ROOT.TCanvas(cname,cname,W,H)
   canvas.SetFillColor(0)
   canvas.SetBorderMode(0)
   canvas.SetFrameFillStyle(0)
   canvas.SetFrameBorderMode(0)
   canvas.SetLeftMargin( L/W )
   canvas.SetRightMargin( R/W )
   canvas.SetTopMargin( T/H )
   canvas.SetBottomMargin( B/H+0.03 )
   canvas.SetTickx()
   canvas.SetTicky()
   
   return canvas
   
tdrstyle.setTDRStyle()

f1 = TFile.Open("plots/EXOVVbulkg_ALL813_UL_Asymptotic_mu_log.root") 

c1=f1.Get("c_lim_Asymptotic")
 
g1_exp = TGraph()
g1_obs = TGraph()

for p in c1.GetListOfPrimitives():
 if str(p).find("LimitExpectedCLs") != -1: g1_exp = p.Clone("g1_exp")
 if str(p).find("LimitObservedCLs") != -1: g1_obs = p.Clone("g1_obs")

f2 = TFile.Open("../BulkG_B2G-16-007/plots/EXOVVbulkg_ALL813_UL_Asymptotic_mu_log.root")  

c2=f2.Get("c_lim_Asymptotic")
 
g2_exp = TGraph()
g2_obs = TGraph()

for p in c2.GetListOfPrimitives():
 if str(p).find("LimitExpectedCLs") != -1: g2_exp = p.Clone("g2_exp")
 if str(p).find("LimitObservedCLs") != -1: g2_obs = p.Clone("g2_obs")

leg = ROOT.TLegend(0.3724832,0.5963455,0.8875839,0.7973422)
leg.SetBorderSize(0);
leg.SetTextSize(0.04);
leg.SetLineColor(1);
leg.SetLineStyle(1);
leg.SetShadowColor(0);
leg.SetLineWidth(1);
leg.SetFillColor(0);
leg.SetTextFont(42)
  
canvas = get_canvas('canvas')
canvas.SetLogy()
canvas.cd()

pad0 = ROOT.TPad("pad0","pad0",0,0.3,1,1)
pad0.SetBottomMargin(0);
pad0.SetRightMargin(0.1);
pad0.SetTopMargin(0.1);   
pad0.Draw()
pad0.SetLogy()
pad0.cd()  
   
hrl_SM0 = pad0.DrawFrame(0.55,0.011, 4.05, 10)
hrl_SM0.GetYaxis().SetTitle('cross section limits')
hrl_SM0.GetYaxis().SetTitleOffset(0.8)

g1_exp.SetLineColor(kRed)
g1_obs.SetLineColor(kRed)

g1_exp.Draw("L")
g1_obs.Draw("L")
g2_exp.Draw("L")
g2_obs.Draw("L")

leg.AddEntry(g1_exp,"new limits expected","L")
leg.AddEntry(g1_obs,"new limits observed","L")
leg.AddEntry(g2_exp,"old limits expected","L")
leg.AddEntry(g2_obs,"old limits observed","L")

leg.Draw()

canvas.Update()   
canvas.cd()
           
pad1 = ROOT.TPad("pad1","pad1",0,0,1,0.30) 
pad1.SetRightMargin(0.1)
pad1.SetTopMargin(0)
pad1.SetBottomMargin(0.4)
pad1.Draw("same")
pad1.cd()
pad1.SetGridy()

ph_exp = get_ratio(g1_exp,g2_exp)
ph_exp.SetLineStyle(2)
ph_exp.SetLineWidth(3)
hrl_SM = pad1.DrawFrame(0.55,0.7, 4.05, 1.29)
hrl_SM.GetXaxis().SetTitle("M_{G} (TeV)");
hrl_SM.GetXaxis().SetLabelFont(42);
hrl_SM.GetXaxis().SetLabelOffset(0.02);
hrl_SM.GetXaxis().SetLabelSize(0.12);
hrl_SM.GetXaxis().SetTitleSize(0.12);
hrl_SM.GetXaxis().SetTitleOffset(1.2);
hrl_SM.GetXaxis().SetTitleFont(42);
hrl_SM.GetYaxis().SetTitle("#frac{new limits}{old limits}");
hrl_SM.GetYaxis().CenterTitle(True);
hrl_SM.GetYaxis().SetNdivisions(205);
hrl_SM.GetYaxis().SetLabelFont(42);
hrl_SM.GetYaxis().SetLabelOffset(0.007);
hrl_SM.GetYaxis().SetLabelSize(0.12);
hrl_SM.GetYaxis().SetTitleSize(0.12);
hrl_SM.GetYaxis().SetTitleOffset(0.5);
hrl_SM.GetYaxis().SetTitleFont(42);
hrl_SM.GetXaxis().SetNdivisions(505)
ph_exp.Draw("L")

ph_obs = get_ratio(g1_obs,g2_obs)
ph_obs.SetLineWidth(3)
ph_obs.Draw("L")
 
canvas.Update()
time.sleep(1000)
