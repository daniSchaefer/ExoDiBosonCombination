import ROOT
from ROOT import *
import time
from array import array

mass_gg = array('d',[])
mass_qq_Wprime = array('d',[])
mass_qq_Zprime = array('d',[])
y_gg_scale = array('d',[])
y_qq_scale_Wprime = array('d',[])
y_qq_scale_Zprime = array('d',[])
y_gg_PDF = array('d',[])
y_qq_PDF_Wprime = array('d',[])
y_qq_PDF_Zprime = array('d',[])

fin = open('XsecUnc/xsec-unc-13TeV.txt','r')
for l in fin:
 if l.find('signal') != -1: continue
 split = l.split('\t')
 if l.find('BulkG') != -1:
  mass_gg.append(float(split[1])) 
  y_gg_scale.append(float(split[2]))
  y_gg_PDF.append(float(split[3]))
 if l.find('Wprime') != -1:
  mass_qq_Wprime.append(float(split[1])) 
  y_qq_scale_Wprime.append(float(split[2]))
  y_qq_PDF_Wprime.append(float(split[3]))
 if l.find('Zprime') != -1:
  mass_qq_Zprime.append(float(split[1])) 
  y_qq_scale_Zprime.append(float(split[2]))
  y_qq_PDF_Zprime.append(float(split[3]))  

gr_gg_scale = TGraph(len(mass_gg),mass_gg,y_gg_scale)
gr_qq_scale_Wprime = TGraph(len(mass_qq_Wprime),mass_qq_Wprime,y_qq_scale_Wprime)
gr_qq_scale_Zprime = TGraph(len(mass_qq_Zprime),mass_qq_Zprime,y_qq_scale_Zprime)
gr_gg_PDF = TGraph(len(mass_gg),mass_gg,y_gg_PDF)
gr_qq_PDF_Wprime = TGraph(len(mass_qq_Wprime),mass_qq_Wprime,y_qq_PDF_Wprime)
gr_qq_PDF_Zprime = TGraph(len(mass_qq_Zprime),mass_qq_Zprime,y_qq_PDF_Zprime)

gr_gg_scale.SetName('gg_scale')
gr_gg_scale.SetLineColor(kRed)

gr_qq_scale_Wprime.SetName('qq_scale_Wprime')
gr_qq_scale_Wprime.SetLineColor(kBlue)

gr_qq_scale_Zprime.SetName('qq_scale_Zprime')
gr_qq_scale_Zprime.SetLineColor(kMagenta)

gr_gg_PDF.SetName('gg_PDF')
gr_gg_PDF.SetLineColor(kRed)
gr_gg_PDF.SetLineStyle(7)

gr_qq_PDF_Wprime.SetName('qq_PDF_Wprime')
gr_qq_PDF_Wprime.SetLineColor(kBlue)
gr_qq_PDF_Wprime.SetLineStyle(7)

gr_qq_PDF_Zprime.SetName('qq_PDF_Zprime')
gr_qq_PDF_Zprime.SetLineColor(kMagenta)
gr_qq_PDF_Zprime.SetLineStyle(7)

mg = TMultiGraph("mg","mg")
mg.Add(gr_gg_scale)
mg.Add(gr_qq_scale_Wprime)
mg.Add(gr_qq_scale_Zprime)
mg.Add(gr_gg_PDF)
mg.Add(gr_qq_PDF_Wprime)
mg.Add(gr_qq_PDF_Zprime)

c = TCanvas('c','c')
mg.Draw('ALP')
time.sleep(10)
c.SaveAs('XsecUnc/xsec-unc-13TeV.root')
