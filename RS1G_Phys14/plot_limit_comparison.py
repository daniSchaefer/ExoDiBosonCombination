from ROOT import *

gROOT.Reset()
gROOT.SetStyle("Plain")
gStyle.SetOptStat(0)
gStyle.SetOptFit(0)
gStyle.SetTitleOffset(1.2,"Y")
gStyle.SetPadLeftMargin(0.18)
gStyle.SetPadBottomMargin(0.15)
gStyle.SetPadTopMargin(0.08)
gStyle.SetPadRightMargin(0.05)
gStyle.SetMarkerSize(0.5)
gStyle.SetHistLineWidth(1)
gStyle.SetStatFontSize(0.020)
gStyle.SetTitleSize(0.06, "XYZ")
gStyle.SetLabelSize(0.05, "XYZ")
gStyle.SetNdivisions(510, "XYZ")
gStyle.SetLegendBorderSize(0)

if __name__ == '__main__':
 scenarios={}
 scenarios["ALL8TeV"]=["ALL","xww","xzz","xjj8"]
 scenarios["JJ813TeV"]=["JJ813","xjj8","xjj13"]
 scenarios["JJ813TeV3fb"]=["JJ8133fb","xjj8","xjj133fb"]
 scenarios["JJ813TeV10fb"]=["JJ81310fb","xjj8","xjj1310fb"]
 scenarios["ZZ813TeV"]=["ZZ813","xzz","xzz13"]
 scenarios["WW813TeV"]=["WW813","xww","xww13"]
 scenarios["WW813TeV3fb"]=["WW8133fb","xww","xww133fb"]
 scenarios["WW813TeV10fb"]=["WW81310fb","xww","xww1310fb"]
 scenarios["ALL813TeV"]=["ALL813","ALL","ALL13"]
 scenarios["ALL813TeV3fb"]=["ALL8133fb","ALL","ALL133fb"]
 scenarios["ALL813TeV10fb"]=["ALL81310fb","ALL","ALL1310fb"]
 scenarios["ALL13TeV"]=["ALL13","xzz13","xww13","xjj13"]
 scenarios["ALL13TeV3fb"]=["ALL133fb","xww133fb","xjj133fb"]
 scenarios["ALL13TeV10fb"]=["ALL1310fb","xww1310fb","xjj1310fb"]
 names={}
 names["ALL"]="lvJ, llJ, JJ (8 TeV, 20/fb)"
 names["xww"]="lvJ (8 TeV, 20/fb)"
 names["xjj8"]="JJ (8 TeV, 20/fb)"
 names["xzz"]="llJ (8 TeV, 20/fb)"
 names["JJ813"]="JJ (8+13 TeV, 20+1/fb)"
 names["xjj13"]="JJ (13 TeV, 1/fb)"
 names["ZZ813"]="llJ (8+13 TeV, 20+1/fb)"
 names["xzz13"]="llJ (13 TeV, 1/fb)"
 names["WW813"]="lvJ (8+13 TeV, 20+1/fb)"
 names["xww13"]="lvJ (13 TeV, 1/fb)"
 names["ALL813"]="lvJ, llJ, JJ (8+13 TeV, 20+1/fb)"
 names["ALL13"]="lvJ, llJ, JJ (13 TeV, 1/fb)"
 names["JJ8133fb"]="JJ (8+13 TeV, 20+3/fb)"
 names["xjj133fb"]="JJ (13 TeV, 3/fb)"
 names["WW8133fb"]="lvJ (8+13 TeV, 20+3/fb)"
 names["xww133fb"]="lvJ (13 TeV, 3/fb)"
 names["ALL8133fb"]="lvJ, llJ, JJ (8+13 TeV, 20+3/fb)"
 names["ALL133fb"]="lvJ, llJ, JJ (13 TeV, 3/fb)"
 names["JJ81310fb"]="JJ (8+13 TeV, 20+10/fb)"
 names["xjj1310fb"]="JJ (13 TeV, 10/fb)"
 names["WW81310fb"]="lvJ (8+13 TeV, 20+10/fb)"
 names["xww1310fb"]="lvJ (13 TeV, 10/fb)"
 names["ALL81310fb"]="lvJ, llJ, JJ (8+13 TeV, 20+10/fb)"
 names["ALL1310fb"]="lvJ, llJ, JJ (13 TeV, 10/fb)"
 colors=[4,6,7,8,9]
 styles=[3,4,5,6,7]
 fillstyles=[3007,3007,3007,3007]
 for scenario in scenarios.keys():
  files=[]
  canvas=[]
  graph=[]
  for name in scenarios[scenario]:
    files+=[TFile.Open("EXOVV_"+name+"_UL_Asymptotic.root")]
    canvas+=[files[-1].Get("c_lim_Asymptotic")]
    print [a for a in canvas[-1].GetListOfPrimitives()]
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[4])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[4])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[4])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[4])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[4])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[8])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[8])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[8])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[8])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[8])
    canvas[-1].GetListOfPrimitives().Remove(canvas[-1].GetListOfPrimitives()[8])
    graph+=[[a for a in canvas[-1].GetListOfPrimitives() if "Limit68CLs" in str(a)][0].Clone("graph_"+name)]
    if len(files)==1:
      l1=[a for a in canvas[-1].GetListOfPrimitives() if "TLegend" in str(a)][0]
      print [a for a in l1.GetListOfPrimitives()]
      canvas[-1].SetLogy()
      canvas[-1].Draw()
      l1.AddEntry(graph[-1],names[name],"lf")
    else:
      graph[-1].SetLineColor(colors[len(files)-2])
      graph[-1].SetLineStyle(styles[len(files)-2])
      graph[-1].SetFillColor(colors[len(files)-2])
      graph[-1].SetFillStyle(fillstyles[len(files)-2])
      #print graph[-1].GetErrorY(1)
      canvas[0].cd()
      graph[-1].Draw("L3")
      l1.AddEntry(graph[-1],names[name],"lf")
      #canvas[0].Update()
  canvas[0].SaveAs("EXOVV_compare_"+scenario+"_UL_Asymptotic.pdf")
