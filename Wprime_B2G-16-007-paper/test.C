{
//=========Macro generated from canvas: c_Significance/c_Significance
//=========  (Wed Nov 30 11:41:04 2016) by ROOT version5.34/18
   TCanvas *c_Significance = new TCanvas("c_Significance", "c_Significance",0,22,600,630);
   gStyle->SetOptFit(1);
   gStyle->SetOptStat(0);
   gStyle->SetOptTitle(0);
   c_Significance->SetHighLightColor(2);
   c_Significance->Range(1.70125,-5.888889,2.07625,1.518519);
   c_Significance->SetFillColor(0);
   c_Significance->SetBorderMode(0);
   c_Significance->SetBorderSize(2);
   c_Significance->SetLogy();
   c_Significance->SetTickx(1);
   c_Significance->SetTicky(1);
   c_Significance->SetLeftMargin(0.13);
   c_Significance->SetRightMargin(0.07);
   c_Significance->SetTopMargin(0.07);
   c_Significance->SetBottomMargin(0.12);
   c_Significance->SetFrameFillStyle(0);
   c_Significance->SetFrameBorderMode(0);
   c_Significance->SetFrameFillStyle(0);
   c_Significance->SetFrameBorderMode(0);
   
   TH1F *hframe__1__1 = new TH1F("hframe__1__1","",1000,1.75,2.05);
   hframe__1__1->SetMinimum(1e-05);
   hframe__1__1->SetMaximum(10);
   hframe__1__1->SetDirectory(0);
   hframe__1__1->SetStats(0);

   Int_t ci;   // for color index setting
   ci = TColor::GetColor("#000099");
   hframe__1__1->SetLineColor(ci);
   hframe__1__1->SetLineStyle(0);
   hframe__1__1->SetMarkerStyle(20);
   hframe__1__1->GetXaxis()->SetTitle("M_{W'} (TeV)");
   hframe__1__1->GetXaxis()->SetLabelFont(42);
   hframe__1__1->GetXaxis()->SetLabelOffset(0.007);
   hframe__1__1->GetXaxis()->SetLabelSize(0.035);
   hframe__1__1->GetXaxis()->SetTitleSize(0.045);
   hframe__1__1->GetXaxis()->SetTitleOffset(1.1);
   hframe__1__1->GetXaxis()->SetTitleFont(42);
   hframe__1__1->GetYaxis()->SetTitle("p-value");
   hframe__1__1->GetYaxis()->SetLabelFont(42);
   hframe__1__1->GetYaxis()->SetLabelOffset(0.007);
   hframe__1__1->GetYaxis()->SetLabelSize(0.035);
   hframe__1__1->GetYaxis()->SetTitleSize(0.045);
   hframe__1__1->GetYaxis()->SetTitleOffset(1.1);
   hframe__1__1->GetYaxis()->SetTitleFont(42);
   hframe__1__1->GetZaxis()->SetLabelFont(42);
   hframe__1__1->GetZaxis()->SetLabelOffset(0.007);
   hframe__1__1->GetZaxis()->SetLabelSize(0.05);
   hframe__1__1->GetZaxis()->SetTitleSize(0.06);
   hframe__1__1->GetZaxis()->SetTitleFont(42);
   hframe__1__1->Draw(" ");
   
   TGraph *graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);

   ci = TColor::GetColor("#ff0000");
   graph->SetLineColor(ci);
   graph->SetLineWidth(2);

   ci = TColor::GetColor("#ff0000");
   graph->SetMarkerColor(ci);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.1119674537);
   graph->SetPoint(1,1.9,0.1297435624);
   graph->SetPoint(2,2,0.2388120608);
   
   TH1F *Graph_Graph_Observed11 = new TH1F("Graph_Graph_Observed11","Graph",100,0.37,3.13);
   Graph_Graph_Observed11->SetMinimum(0.03681925);
   Graph_Graph_Observed11->SetMaximum(0.545909);
   Graph_Graph_Observed11->SetDirectory(0);
   Graph_Graph_Observed11->SetStats(0);

   ci = TColor::GetColor("#000099");
   Graph_Graph_Observed11->SetLineColor(ci);
   Graph_Graph_Observed11->SetLineStyle(0);
   Graph_Graph_Observed11->SetMarkerStyle(20);
   Graph_Graph_Observed11->GetXaxis()->SetLabelFont(42);
   Graph_Graph_Observed11->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed11->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed11->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed11->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph_Observed11->GetXaxis()->SetTitleFont(42);
   Graph_Graph_Observed11->GetYaxis()->SetLabelFont(42);
   Graph_Graph_Observed11->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed11->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed11->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed11->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph_Observed11->GetYaxis()->SetTitleFont(42);
   Graph_Graph_Observed11->GetZaxis()->SetLabelFont(42);
   Graph_Graph_Observed11->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed11->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed11->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed11->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph_Observed11);
   
   graph->Draw("lp");
   
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);

   ci = TColor::GetColor("#00ff00");
   graph->SetLineColor(ci);
   graph->SetLineWidth(2);

   ci = TColor::GetColor("#00ff00");
   graph->SetMarkerColor(ci);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.0201061237);
   graph->SetPoint(1,1.9,0.01508285517);
   graph->SetPoint(2,2,0.5);
   
   TH1F *Graph_Graph_Observed22 = new TH1F("Graph_Graph_Observed22","Graph",100,0.62,2.78);
   Graph_Graph_Observed22->SetMinimum(0.01357457);
   Graph_Graph_Observed22->SetMaximum(0.5484917);
   Graph_Graph_Observed22->SetDirectory(0);
   Graph_Graph_Observed22->SetStats(0);

   ci = TColor::GetColor("#000099");
   Graph_Graph_Observed22->SetLineColor(ci);
   Graph_Graph_Observed22->SetLineStyle(0);
   Graph_Graph_Observed22->SetMarkerStyle(20);
   Graph_Graph_Observed22->GetXaxis()->SetLabelFont(42);
   Graph_Graph_Observed22->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed22->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed22->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed22->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph_Observed22->GetXaxis()->SetTitleFont(42);
   Graph_Graph_Observed22->GetYaxis()->SetLabelFont(42);
   Graph_Graph_Observed22->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed22->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed22->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed22->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph_Observed22->GetYaxis()->SetTitleFont(42);
   Graph_Graph_Observed22->GetZaxis()->SetLabelFont(42);
   Graph_Graph_Observed22->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed22->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed22->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed22->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph_Observed22);
   
   graph->Draw("lp");
   
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);

   ci = TColor::GetColor("#ff00ff");
   graph->SetLineColor(ci);
   graph->SetLineWidth(2);

   ci = TColor::GetColor("#ff00ff");
   graph->SetMarkerColor(ci);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.01379839392);
   graph->SetPoint(1,1.9,0.01191891314);
   graph->SetPoint(2,2,0.2986039328);
   
   TH1F *Graph_Graph_Observed33 = new TH1F("Graph_Graph_Observed33","Graph",100,0.37,3.13);
   Graph_Graph_Observed33->SetMinimum(0.01072702);
   Graph_Graph_Observed33->SetMaximum(0.5488081);
   Graph_Graph_Observed33->SetDirectory(0);
   Graph_Graph_Observed33->SetStats(0);

   ci = TColor::GetColor("#000099");
   Graph_Graph_Observed33->SetLineColor(ci);
   Graph_Graph_Observed33->SetLineStyle(0);
   Graph_Graph_Observed33->SetMarkerStyle(20);
   Graph_Graph_Observed33->GetXaxis()->SetLabelFont(42);
   Graph_Graph_Observed33->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed33->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed33->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed33->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph_Observed33->GetXaxis()->SetTitleFont(42);
   Graph_Graph_Observed33->GetYaxis()->SetLabelFont(42);
   Graph_Graph_Observed33->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed33->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed33->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed33->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph_Observed33->GetYaxis()->SetTitleFont(42);
   Graph_Graph_Observed33->GetZaxis()->SetLabelFont(42);
   Graph_Graph_Observed33->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed33->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed33->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed33->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph_Observed33);
   
   graph->Draw("lp");
   
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);

   ci = TColor::GetColor("#0000ff");
   graph->SetLineColor(ci);
   graph->SetLineWidth(2);

   ci = TColor::GetColor("#0000ff");
   graph->SetMarkerColor(ci);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.5);
   graph->SetPoint(1,1.9,0.5);
   graph->SetPoint(2,2,0.5);
   
   TH1F *Graph_Graph_Observed44 = new TH1F("Graph_Graph_Observed44","Graph",100,0.26,4.34);
   Graph_Graph_Observed44->SetMinimum(0.002869778);
   Graph_Graph_Observed44->SetMaximum(0.5496811);
   Graph_Graph_Observed44->SetDirectory(0);
   Graph_Graph_Observed44->SetStats(0);

   ci = TColor::GetColor("#000099");
   Graph_Graph_Observed44->SetLineColor(ci);
   Graph_Graph_Observed44->SetLineStyle(0);
   Graph_Graph_Observed44->SetMarkerStyle(20);
   Graph_Graph_Observed44->GetXaxis()->SetLabelFont(42);
   Graph_Graph_Observed44->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed44->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed44->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed44->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph_Observed44->GetXaxis()->SetTitleFont(42);
   Graph_Graph_Observed44->GetYaxis()->SetLabelFont(42);
   Graph_Graph_Observed44->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed44->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed44->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed44->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph_Observed44->GetYaxis()->SetTitleFont(42);
   Graph_Graph_Observed44->GetZaxis()->SetLabelFont(42);
   Graph_Graph_Observed44->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed44->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed44->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed44->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph_Observed44);
   
   graph->Draw("lp");
   
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);

   ci = TColor::GetColor("#ffcc00");
   graph->SetLineColor(ci);
   graph->SetLineWidth(2);

   ci = TColor::GetColor("#ffcc00");
   graph->SetMarkerColor(ci);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.5);
   graph->SetPoint(1,1.9,0.5);
   graph->SetPoint(2,2,0.5);
   
   TH1F *Graph_Graph_Observed55 = new TH1F("Graph_Graph_Observed55","Graph",100,0.26,4.34);
   Graph_Graph_Observed55->SetMinimum(0.002869778);
   Graph_Graph_Observed55->SetMaximum(0.5496811);
   Graph_Graph_Observed55->SetDirectory(0);
   Graph_Graph_Observed55->SetStats(0);

   ci = TColor::GetColor("#000099");
   Graph_Graph_Observed55->SetLineColor(ci);
   Graph_Graph_Observed55->SetLineStyle(0);
   Graph_Graph_Observed55->SetMarkerStyle(20);
   Graph_Graph_Observed55->GetXaxis()->SetLabelFont(42);
   Graph_Graph_Observed55->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed55->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed55->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed55->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph_Observed55->GetXaxis()->SetTitleFont(42);
   Graph_Graph_Observed55->GetYaxis()->SetLabelFont(42);
   Graph_Graph_Observed55->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed55->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed55->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed55->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph_Observed55->GetYaxis()->SetTitleFont(42);
   Graph_Graph_Observed55->GetZaxis()->SetLabelFont(42);
   Graph_Graph_Observed55->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed55->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed55->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed55->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph_Observed55);
   
   graph->Draw("lp");
   
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);

   ci = TColor::GetColor("#00ffff");
   graph->SetLineColor(ci);
   graph->SetLineWidth(2);

   ci = TColor::GetColor("#00ffff");
   graph->SetMarkerColor(ci);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.3591660307);
   graph->SetPoint(1,1.9,0.5);
   graph->SetPoint(2,2,0.4345144436);
   
   TH1F *Graph_Graph_Observed66 = new TH1F("Graph_Graph_Observed66","Graph",100,0.26,4.34);
   Graph_Graph_Observed66->SetMinimum(0.005184239);
   Graph_Graph_Observed66->SetMaximum(0.549424);
   Graph_Graph_Observed66->SetDirectory(0);
   Graph_Graph_Observed66->SetStats(0);

   ci = TColor::GetColor("#000099");
   Graph_Graph_Observed66->SetLineColor(ci);
   Graph_Graph_Observed66->SetLineStyle(0);
   Graph_Graph_Observed66->SetMarkerStyle(20);
   Graph_Graph_Observed66->GetXaxis()->SetLabelFont(42);
   Graph_Graph_Observed66->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed66->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed66->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed66->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph_Observed66->GetXaxis()->SetTitleFont(42);
   Graph_Graph_Observed66->GetYaxis()->SetLabelFont(42);
   Graph_Graph_Observed66->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed66->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed66->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed66->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph_Observed66->GetYaxis()->SetTitleFont(42);
   Graph_Graph_Observed66->GetZaxis()->SetLabelFont(42);
   Graph_Graph_Observed66->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed66->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed66->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed66->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph_Observed66);
   
   graph->Draw("lp");
   
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetLineWidth(2);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.2013182205);
   graph->SetPoint(1,1.9,0.466097453);
   graph->SetPoint(2,2,0.5);
   
   TH1F *Graph_Graph_Observed77 = new TH1F("Graph_Graph_Observed77","Graph",100,0.26,4.34);
   Graph_Graph_Observed77->SetMinimum(0.003477671);
   Graph_Graph_Observed77->SetMaximum(0.5496136);
   Graph_Graph_Observed77->SetDirectory(0);
   Graph_Graph_Observed77->SetStats(0);

   ci = TColor::GetColor("#000099");
   Graph_Graph_Observed77->SetLineColor(ci);
   Graph_Graph_Observed77->SetLineStyle(0);
   Graph_Graph_Observed77->SetMarkerStyle(20);
   Graph_Graph_Observed77->GetXaxis()->SetLabelFont(42);
   Graph_Graph_Observed77->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed77->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed77->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed77->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph_Observed77->GetXaxis()->SetTitleFont(42);
   Graph_Graph_Observed77->GetYaxis()->SetLabelFont(42);
   Graph_Graph_Observed77->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed77->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed77->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed77->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph_Observed77->GetYaxis()->SetTitleFont(42);
   Graph_Graph_Observed77->GetZaxis()->SetLabelFont(42);
   Graph_Graph_Observed77->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph_Observed77->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph_Observed77->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph_Observed77->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph_Observed77);
   
   graph->Draw("lp");
   
   TF1 *oneSLine = new TF1("oneSLine","1.58655253931457074e-01",0.75,2.05);
   oneSLine->SetFillColor(19);
   oneSLine->SetFillStyle(0);
   oneSLine->SetMarkerStyle(20);
   oneSLine->SetLineColor(2);
   oneSLine->SetLineWidth(2);
   oneSLine->SetLineStyle(3);
   oneSLine->GetXaxis()->SetLabelFont(42);
   oneSLine->GetXaxis()->SetLabelOffset(0.007);
   oneSLine->GetXaxis()->SetLabelSize(0.05);
   oneSLine->GetXaxis()->SetTitleSize(0.06);
   oneSLine->GetXaxis()->SetTitleOffset(0.9);
   oneSLine->GetXaxis()->SetTitleFont(42);
   oneSLine->GetYaxis()->SetLabelFont(42);
   oneSLine->GetYaxis()->SetLabelOffset(0.007);
   oneSLine->GetYaxis()->SetLabelSize(0.05);
   oneSLine->GetYaxis()->SetTitleSize(0.06);
   oneSLine->GetYaxis()->SetTitleOffset(1.25);
   oneSLine->GetYaxis()->SetTitleFont(42);
   oneSLine->Draw("same");
   
   TF1 *twoSLine = new TF1("twoSLine","2.27501319481792155e-02",0.75,2.05);
   twoSLine->SetFillColor(19);
   twoSLine->SetFillStyle(0);
   twoSLine->SetMarkerStyle(20);
   twoSLine->SetLineColor(2);
   twoSLine->SetLineWidth(2);
   twoSLine->SetLineStyle(3);
   twoSLine->GetXaxis()->SetLabelFont(42);
   twoSLine->GetXaxis()->SetLabelOffset(0.007);
   twoSLine->GetXaxis()->SetLabelSize(0.05);
   twoSLine->GetXaxis()->SetTitleSize(0.06);
   twoSLine->GetXaxis()->SetTitleOffset(0.9);
   twoSLine->GetXaxis()->SetTitleFont(42);
   twoSLine->GetYaxis()->SetLabelFont(42);
   twoSLine->GetYaxis()->SetLabelOffset(0.007);
   twoSLine->GetYaxis()->SetLabelSize(0.05);
   twoSLine->GetYaxis()->SetTitleSize(0.06);
   twoSLine->GetYaxis()->SetTitleOffset(1.25);
   twoSLine->GetYaxis()->SetTitleFont(42);
   twoSLine->Draw("same");
   
   TF1 *threeSLine = new TF1("threeSLine","1.34989803163009588e-03",0.75,2.05);
   threeSLine->SetFillColor(19);
   threeSLine->SetFillStyle(0);
   threeSLine->SetMarkerStyle(20);
   threeSLine->SetLineColor(2);
   threeSLine->SetLineWidth(2);
   threeSLine->SetLineStyle(3);
   threeSLine->GetXaxis()->SetLabelFont(42);
   threeSLine->GetXaxis()->SetLabelOffset(0.007);
   threeSLine->GetXaxis()->SetLabelSize(0.05);
   threeSLine->GetXaxis()->SetTitleSize(0.06);
   threeSLine->GetXaxis()->SetTitleOffset(0.9);
   threeSLine->GetXaxis()->SetTitleFont(42);
   threeSLine->GetYaxis()->SetLabelFont(42);
   threeSLine->GetYaxis()->SetLabelOffset(0.007);
   threeSLine->GetYaxis()->SetLabelSize(0.05);
   threeSLine->GetYaxis()->SetTitleSize(0.06);
   threeSLine->GetYaxis()->SetTitleOffset(1.25);
   threeSLine->GetYaxis()->SetTitleFont(42);
   threeSLine->Draw("same");
   
   TF1 *fourSLine = new TF1("fourSLine","3.16712418331199785e-05",0.75,2.05);
   fourSLine->SetFillColor(19);
   fourSLine->SetFillStyle(0);
   fourSLine->SetMarkerStyle(20);
   fourSLine->SetLineColor(2);
   fourSLine->SetLineWidth(2);
   fourSLine->SetLineStyle(3);
   fourSLine->GetXaxis()->SetLabelFont(42);
   fourSLine->GetXaxis()->SetLabelOffset(0.007);
   fourSLine->GetXaxis()->SetLabelSize(0.05);
   fourSLine->GetXaxis()->SetTitleSize(0.06);
   fourSLine->GetXaxis()->SetTitleOffset(0.9);
   fourSLine->GetXaxis()->SetTitleFont(42);
   fourSLine->GetYaxis()->SetLabelFont(42);
   fourSLine->GetYaxis()->SetLabelOffset(0.007);
   fourSLine->GetYaxis()->SetLabelSize(0.05);
   fourSLine->GetYaxis()->SetTitleSize(0.06);
   fourSLine->GetYaxis()->SetTitleOffset(1.25);
   fourSLine->GetYaxis()->SetTitleFont(42);
   fourSLine->Draw("same");
   TLatex *   tex = new TLatex(2.02,0.1586553,"1 #sigma");
   tex->SetTextColor(2);
   tex->SetTextSize(0.028);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(2.02,0.02275013,"2 #sigma");
   tex->SetTextColor(2);
   tex->SetTextSize(0.028);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(2.02,0.001349898,"3 #sigma");
   tex->SetTextColor(2);
   tex->SetTextSize(0.028);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(2.02,3.167124e-05,"4 #sigma");
   tex->SetTextColor(2);
   tex->SetTextSize(0.028);
   tex->SetLineWidth(2);
   tex->Draw();
   
   TLegend *leg = new TLegend(0.2248322,0.2109635,0.8171141,0.3704319,NULL,"brNDC");
   leg->SetBorderSize(0);
   leg->SetTextSize(0.031);
   leg->SetLineColor(1);
   leg->SetLineStyle(1);
   leg->SetLineWidth(1);
   leg->SetFillColor(0);
   leg->SetFillStyle(1001);
   TLegendEntry *entry=leg->AddEntry("Observed","VV 8 TeV","LP");

   ci = TColor::GetColor("#ff0000");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);

   ci = TColor::GetColor("#ff0000");
   entry->SetMarkerColor(ci);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Observed","VH 8 TeV","LP");

   ci = TColor::GetColor("#00ff00");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);

   ci = TColor::GetColor("#00ff00");
   entry->SetMarkerColor(ci);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Observed","VV+VH 8 TeV","LP");

   ci = TColor::GetColor("#ff00ff");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);

   ci = TColor::GetColor("#ff00ff");
   entry->SetMarkerColor(ci);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Observed","VV 13 TeV","LP");

   ci = TColor::GetColor("#0000ff");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);

   ci = TColor::GetColor("#0000ff");
   entry->SetMarkerColor(ci);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Observed","VV+VH 13 TeV","LP");

   ci = TColor::GetColor("#ffcc00");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);

   ci = TColor::GetColor("#ffcc00");
   entry->SetMarkerColor(ci);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Observed","VV 8+13 TeV","LP");

   ci = TColor::GetColor("#00ffff");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);

   ci = TColor::GetColor("#00ffff");
   entry->SetMarkerColor(ci);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Observed","VV+VH 8+13 TeV","LP");
   entry->SetLineColor(1);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   leg->Draw();
      tex = new TLatex(0.93,0.944,"2.3-2.7 fb^{-1} (13 TeV)");
tex->SetNDC();
   tex->SetTextAlign(31);
   tex->SetTextFont(42);
   tex->SetTextSize(0.0371);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(0.234,0.90165,"CMS");
tex->SetNDC();
   tex->SetTextAlign(13);
   tex->SetTextFont(61);
   tex->SetTextSize(0.0455);
   tex->SetLineWidth(2);
   tex->Draw();
   
   TH1F *hframe__2__2 = new TH1F("hframe__2__2","",1000,1.75,2.05);
   hframe__2__2->SetMinimum(1e-05);
   hframe__2__2->SetMaximum(10);
   hframe__2__2->SetDirectory(0);
   hframe__2__2->SetStats(0);

   ci = TColor::GetColor("#000099");
   hframe__2__2->SetLineColor(ci);
   hframe__2__2->SetLineStyle(0);
   hframe__2__2->SetMarkerStyle(20);
   hframe__2__2->GetXaxis()->SetTitle("M_{W'} (TeV)");
   hframe__2__2->GetXaxis()->SetLabelFont(42);
   hframe__2__2->GetXaxis()->SetLabelOffset(0.007);
   hframe__2__2->GetXaxis()->SetLabelSize(0.035);
   hframe__2__2->GetXaxis()->SetTitleSize(0.045);
   hframe__2__2->GetXaxis()->SetTitleOffset(1.1);
   hframe__2__2->GetXaxis()->SetTitleFont(42);
   hframe__2__2->GetYaxis()->SetTitle("p-value");
   hframe__2__2->GetYaxis()->SetLabelFont(42);
   hframe__2__2->GetYaxis()->SetLabelOffset(0.007);
   hframe__2__2->GetYaxis()->SetLabelSize(0.035);
   hframe__2__2->GetYaxis()->SetTitleSize(0.045);
   hframe__2__2->GetYaxis()->SetTitleOffset(1.1);
   hframe__2__2->GetYaxis()->SetTitleFont(42);
   hframe__2__2->GetZaxis()->SetLabelFont(42);
   hframe__2__2->GetZaxis()->SetLabelOffset(0.007);
   hframe__2__2->GetZaxis()->SetLabelSize(0.05);
   hframe__2__2->GetZaxis()->SetTitleSize(0.06);
   hframe__2__2->GetZaxis()->SetTitleFont(42);
   hframe__2__2->Draw("sameaxis");
   
   TH1F *hframe__3__3 = new TH1F("hframe__3__3","",1000,1.75,2.05);
   hframe__3__3->SetMinimum(1e-05);
   hframe__3__3->SetMaximum(10);
   hframe__3__3->SetDirectory(0);
   hframe__3__3->SetStats(0);

   ci = TColor::GetColor("#000099");
   hframe__3__3->SetLineColor(ci);
   hframe__3__3->SetLineStyle(0);
   hframe__3__3->SetMarkerStyle(20);
   hframe__3__3->GetXaxis()->SetTitle("M_{W'} (TeV)");
   hframe__3__3->GetXaxis()->SetLabelFont(42);
   hframe__3__3->GetXaxis()->SetLabelOffset(0.007);
   hframe__3__3->GetXaxis()->SetLabelSize(0.035);
   hframe__3__3->GetXaxis()->SetTitleSize(0.045);
   hframe__3__3->GetXaxis()->SetTitleOffset(1.1);
   hframe__3__3->GetXaxis()->SetTitleFont(42);
   hframe__3__3->GetYaxis()->SetTitle("p-value");
   hframe__3__3->GetYaxis()->SetLabelFont(42);
   hframe__3__3->GetYaxis()->SetLabelOffset(0.007);
   hframe__3__3->GetYaxis()->SetLabelSize(0.035);
   hframe__3__3->GetYaxis()->SetTitleSize(0.045);
   hframe__3__3->GetYaxis()->SetTitleOffset(1.1);
   hframe__3__3->GetYaxis()->SetTitleFont(42);
   hframe__3__3->GetZaxis()->SetLabelFont(42);
   hframe__3__3->GetZaxis()->SetLabelOffset(0.007);
   hframe__3__3->GetZaxis()->SetLabelSize(0.05);
   hframe__3__3->GetZaxis()->SetTitleSize(0.06);
   hframe__3__3->GetZaxis()->SetTitleFont(42);
   hframe__3__3->Draw("sameaxig");
   c_Significance->Modified();
   c_Significance->cd();
   c_Significance->SetSelected(c_Significance);
}
